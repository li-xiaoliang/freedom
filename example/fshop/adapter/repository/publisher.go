package repository

import (
	"time"

	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/fshop/domain/po"
	"github.com/8treenet/freedom/infra/kafka"
	"github.com/jinzhu/gorm"
)

var publisher *Publisher

// EventChan .
var EventChan chan freedom.DomainEvent

func init() {
	publisher = &Publisher{}
	EventChan = make(chan freedom.DomainEvent, 1000)
	freedom.Prepare(func(initiator freedom.Initiator) {
		initiator.BindInfra(true, publisher)
	})
}

// NewPublisher .
func NewPublisher() func(freedom.DomainEvent) {
	return publisher.EventHandle
}

// Publisher .
type Publisher struct {
	freedom.Infra
	kafkaProducer kafka.Producer //Kafka 生产者
}

// Booting .
func (pub *Publisher) Booting(sb freedom.SingleBoot) {
	//单例启动，获取其他组件
	pub.GetSingleInfra(&pub.kafkaProducer)
}

// EventHandle .
func (pub *Publisher) EventHandle(event freedom.DomainEvent) {
	freedom.Logger().Info("领域事件发布", event)
	eventID := event.GetPrototype("id").(int)
	go func() {
		/*
			if err := pub.kafkaProducer.NewMsg(event.Name(), event.Marshal()).Publish(); err != nil {
				freedom.Logger().Error(err)
				return
			}
		*/
		EventChan <- event
		eventPo := &po.DomainEvent{ID: eventID}
		eventPo.SetSend(1)
		if err := pub.db().Model(eventPo).Updates(eventPo.TakeChanges()).Error; err != nil {
			freedom.Logger().Info(err)
		}
	}()
}

func (pub *Publisher) db() *gorm.DB {
	return pub.SourceDB().(*gorm.DB)
}

func saveEvents(repo GORMRepository, events []freedom.DomainEvent) error {
	for _, domainEvent := range events {
		model := po.DomainEvent{
			Name:    domainEvent.Name(),
			Content: string(domainEvent.Marshal()),
			Created: time.Now(),
			Updated: time.Now(),
		}

		_, err := createDomainEvent(repo, &model)
		if err != nil {
			return err
		}
		domainEvent.SetPrototype("id", model.ID)
	}
	return nil
}
