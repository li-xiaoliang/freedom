package repository

import (
	"errors"
	"time"

	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/fshop/domain/po"
	"github.com/8treenet/freedom/infra/kafka"
	"github.com/jinzhu/gorm"
)

var eventManager *EventManager

func init() {
	eventManager = &EventManager{publisherChan: make(chan freedom.DomainEvent, 1000)}
	freedom.Prepare(func(initiator freedom.Initiator) {
		initiator.BindInfra(true, eventManager)
		initiator.InjectController(func(ctx freedom.Context) (com *EventManager) {
			initiator.GetInfra(ctx, &com)
			return
		})
	})
}

// GetEventManager .
func GetEventManager() *EventManager {
	return eventManager
}

// EventManager .
type EventManager struct {
	freedom.Infra
	kafkaProducer kafka.Producer //Kafka 生产者
	publisherChan chan freedom.DomainEvent
}

// GetPublisherChan .
func (manager *EventManager) GetPublisherChan() <-chan freedom.DomainEvent {
	return manager.publisherChan
}

// Booting .
func (manager *EventManager) Booting(sb freedom.SingleBoot) {
	//单例启动，获取其他组件
	manager.GetSingleInfra(&manager.kafkaProducer)
}

// PublishHandle .
func (manager *EventManager) PublishHandle(event freedom.DomainEvent) {
	freedom.Logger().Info("领域事件发布", event)
	eventID := event.Identity().(int)
	go func() {
		/*
			if err := pub.kafkaProducer.NewMsg(event.Topic(), event.Marshal()).SetHeader(event.GetPrototypes()).Publish(); err != nil {
				freedom.Logger().Error(err)
				return
			}
		*/
		manager.publisherChan <- event
		eventPo := &po.DomainEventPublish{ID: eventID}
		eventPo.SetSend(1)
		if err := manager.db().Model(eventPo).Updates(eventPo.TakeChanges()).Error; err != nil {
			freedom.Logger().Info(err)
		}
	}()
}

func (manager *EventManager) db() *gorm.DB {
	return manager.SourceDB().(*gorm.DB)
}

// SavePubEvents .
func (manager *EventManager) newPubEvents(txRepo GORMRepository, events []freedom.DomainEvent) error {
	for _, domainEvent := range events {
		model := po.DomainEventPublish{
			Topic:   domainEvent.Topic(),
			Content: string(domainEvent.Marshal()),
			Created: time.Now(),
			Updated: time.Now(),
		}

		_, err := createDomainEventPublish(txRepo, &model)
		if err != nil {
			return err
		}
		domainEvent.SetIdentity(model.ID)
	}
	return nil
}

// NewSubEvent .
func (manager *EventManager) NewSubEvent(event freedom.DomainEvent) error {
	model := po.DomainEventSubscribe{
		ID:      event.Identity().(int),
		Topic:   event.Topic(),
		Content: string(event.Marshal()),
		Created: time.Now(),
		Updated: time.Now(),
	}

	_, err := createDomainEventSubscribe(manager, &model)
	if err != nil {
		return err
	}
	return nil
}

// updateSubEvent .
func (manager *EventManager) updateSubEvent(txRepo GORMRepository, event freedom.DomainEvent) error {
	eventID := event.Identity().(int)
	subscribe := &po.DomainEventSubscribe{ID: eventID}
	subscribe.SetProgress(1)

	rowResult := manager.db().Model(subscribe).Updates(subscribe.TakeChanges())
	if rowResult.Error != nil {
		freedom.Logger().Info(rowResult.Error)
		return rowResult.Error
	}
	if rowResult.RowsAffected == 0 {
		return errors.New("Event not found")
	}
	return nil
}
