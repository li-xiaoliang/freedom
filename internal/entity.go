package internal

import (
	"reflect"
	"strings"

	uuid "github.com/iris-contrib/go.uuid"
)

var _ Entity = (*entity)(nil)

// DomainEvent .
type DomainEvent interface {
	Name() string
	SetPrototype(string, interface{})
	GetPrototype(string) interface{}
	Marshal() []byte
}

//Entity is the entity's father interface.
type Entity interface {
	Identity() string
	GetWorker() Worker
	Marshal() []byte
	AddEvent(DomainEvent)
	GetEvent() []DomainEvent
	RemoveEvent(string)
	RemoveAllEvent()
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
	e.events = map[string][]DomainEvent{}
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
	events       map[string][]DomainEvent
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

// AddEvent.
func (e *entity) AddEvent(event DomainEvent) {
	e.events[event.Name()] = append(e.events[event.Name()], event)
	e.worker.addEvent(event)
}

// GetEvent .
func (e *entity) GetEvent() (result []DomainEvent) {
	for _, event := range e.events {
		result = append(result, event...)
	}
	return
}

// RemoveEvent .
func (e *entity) RemoveEvent(eventName string) {
	delete(e.events, eventName)
	e.worker.removeEvent(eventName)
}

// RemoveAllEvent .
func (e *entity) RemoveAllEvent() {
	for name := range e.events {
		e.worker.removeEvent(name)
	}
	e.events = map[string][]DomainEvent{}
}
