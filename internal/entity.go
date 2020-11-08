package internal

import (
	"reflect"
	"strings"

	uuid "github.com/iris-contrib/go.uuid"
)

var _ Entity = (*entity)(nil)

// DomainEvent .
type DomainEvent interface {
	Topic() string
	SetPrototypes(map[string]interface{})
	GetPrototypes() map[string]interface{}
	Marshal() []byte
	Identity() interface{}
	SetIdentity(identity interface{})
}

//Entity is the entity's father interface.
type Entity interface {
	Identity() string
	GetWorker() Worker
	Marshal() []byte
	AddPubEvent(DomainEvent)
	GetPubEvent() []DomainEvent
	RemovePubEvent(string)
	RemoveAllPubEvent()
	AddSubEvent(DomainEvent)
	GetSubEvent() []DomainEvent
	RemoveSubEvent(string)
	RemoveAllSubEvent()
}

func injectBaseEntity(run Worker, entityObject interface{}) {
	entityObjectValue := reflect.ValueOf(entityObject)
	if entityObjectValue.Kind() == reflect.Ptr {
		entityObjectValue = entityObjectValue.Elem()
	}
	entityField := entityObjectValue.FieldByName("Entity")
	if !entityField.IsNil() {
		return
	}

	e := new(entity)
	e.worker = run
	e.entityObject = entityObject
	e.pubEvents = map[string][]DomainEvent{}
	e.subEvents = map[string][]DomainEvent{}
	eValue := reflect.ValueOf(e)
	if entityField.Kind() != reflect.Interface || !eValue.Type().Implements(entityField.Type()) {
		globalApp.Logger().Fatalf("[Freedom] InjectBaseEntity: This is not a legitimate entity, %v", entityObjectValue.Type())
	}
	entityField.Set(eValue)
	return
}

type entity struct {
	worker       Worker
	entityName   string
	identity     string
	producer     string
	entityObject interface{}
	pubEvents    map[string][]DomainEvent
	subEvents    map[string][]DomainEvent
}

/*
func (e *entity) DomainEvent(fun string, object interface{}, header ...map[string]string) {
	if globalApp.eventInfra == nil {
		globalApp.Logger().Fatalf("[Freedom] DomainEvent: Unrealized Domain Event Infrastructure, %v", reflect.TypeOf(object))
	}
	json, err := globalApp.marshal(object)
	if err != nil {
		panic(err)
	}
	globalApp.eventInfra.DomainEvent(e.producer, fun, json, e.worker, header...)
}
*/

func (e *entity) Identity() string {
	if e.identity == "" {
		u, _ := uuid.NewV1()
		e.identity = strings.ToLower(strings.ReplaceAll(u.String(), "-", ""))
	}
	return e.identity
}

// GetWorker .
func (e *entity) GetWorker() Worker {
	return e.worker
}

// Marshal .
func (e *entity) Marshal() []byte {
	data, err := globalApp.marshal(e.entityObject)
	if err != nil {
		e.worker.Logger().Errorf("[Freedom] Entity.Marshal: serialization failed, %v, error:%v", reflect.TypeOf(e.entityObject), err)
	}
	return data
}

// AddPubEvent.
func (e *entity) AddPubEvent(event DomainEvent) {
	e.pubEvents[event.Topic()] = append(e.pubEvents[event.Topic()], event)
	e.worker.addEvent(event)
	m := map[string]interface{}{}
	for key, item := range e.GetWorker().Bus().Header {
		if len(item) <= 0 {
			continue
		}
		m[key] = item[0]
	}
	event.SetPrototypes(m)
}

// GetPubEvent .
func (e *entity) GetPubEvent() (result []DomainEvent) {
	for _, event := range e.pubEvents {
		result = append(result, event...)
	}
	return
}

// RemovePubEvent .
func (e *entity) RemovePubEvent(eventName string) {
	delete(e.pubEvents, eventName)
	e.worker.removeEvent(eventName)
}

// RemoveAllPubEvent .
func (e *entity) RemoveAllPubEvent() {
	for name := range e.pubEvents {
		e.worker.removeEvent(name)
	}
	e.pubEvents = map[string][]DomainEvent{}
}

// AddSubEvent.
func (e *entity) AddSubEvent(event DomainEvent) {
	e.subEvents[event.Topic()] = append(e.subEvents[event.Topic()], event)
	m := map[string]interface{}{}
	for key, item := range e.GetWorker().Bus().Header {
		if len(item) <= 0 {
			continue
		}
		m[key] = item[0]
	}
	event.SetPrototypes(m)
}

// GetSubEvent .
func (e *entity) GetSubEvent() (result []DomainEvent) {
	for _, event := range e.subEvents {
		result = append(result, event...)
	}
	return
}

// RemoveSubEvent .
func (e *entity) RemoveSubEvent(eventName string) {
	delete(e.subEvents, eventName)
}

// RemoveAllSubEvent .
func (e *entity) RemoveAllSubEvent() {
	e.subEvents = map[string][]DomainEvent{}
}
