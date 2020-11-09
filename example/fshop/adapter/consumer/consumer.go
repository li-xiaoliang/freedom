package consumer

import (
	"time"

	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/fshop/adapter/repository"
	"github.com/8treenet/freedom/example/fshop/domain"
	"github.com/8treenet/freedom/example/fshop/domain/event"
)

// Start .
func Start(app freedom.Application) {
	fixedTime(app)
	eventLoop(app)
}

// fixedTime .
func fixedTime(app freedom.Application) {
	/*
		展示非控制器使用领域服务的示例
		接口 Application.CallService(fun interface{}, worker ...freedom.Worker)
		CallService可以自定义Wokrer
	*/
	go func() {
		time.Sleep(10 * time.Second) //延迟，等待程序Application.Run
		t := time.NewTimer(15 * time.Second)
		for range t.C {
			app.CallService(func(goodsService *domain.Goods) {
				goodsService.MarkedTag(4, "HOT")
			})
			t.Reset(15 * time.Second)
		}
	}()
}

// eventLoop .
func eventLoop(app freedom.Application) {
	eventManager := repository.GetEventManager()
	go func() {
		for domainEvent := range eventManager.GetPublisherChan() {
			time.Sleep(1 * time.Second)
			freedom.Logger().Info("领域事件消费", domainEvent)
			shopEvent, ok := domainEvent.(*event.ShopGoods)
			if ok {
				if err := eventManager.NewSubEvent(shopEvent); err != nil {
					freedom.Logger().Error("领域事件消费错误", err)
					continue
				}
				app.CallService(func(goodsService *domain.Goods) {
					//收到购买事件，自动增加库存。
					goodsService.ShopEvent(shopEvent)
				})
			}
		}
	}()
}
