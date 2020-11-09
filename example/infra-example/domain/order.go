package domain

import (
	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/infra-example/adapter/repository"
	"github.com/8treenet/freedom/example/infra-example/domain/dto"
	"github.com/8treenet/freedom/infra/transaction"
)

func init() {
	freedom.Prepare(func(initiator freedom.Initiator) {
		initiator.BindService(func() *OrderService {
			return &OrderService{}
		})
		initiator.InjectController(func(ctx freedom.Context) (service *OrderService) {
			initiator.GetService(ctx, &service)
			return
		})
	})
}

// OrderService .
type OrderService struct {
	Worker    freedom.Worker
	GoodsRepo *repository.GoodsRepository
	OrderRepo *repository.OrderRepository
	Tx        transaction.Transaction
}

// Get .
func (srv *OrderService) Get(ID, userID int) (result dto.OrderRep, e error) {
	entity, e := srv.OrderRepo.Get(ID, userID)
	if e != nil {
		return
	}
	goodsEntity, e := srv.GoodsRepo.Get(entity.GoodsID)
	if e != nil {
		return
	}
	result.ID = entity.ID
	result.GoodsID = entity.GoodsID
	result.Num = entity.Num
	result.DateTime = entity.Created.Format("2006-01-02 15:04:05")
	result.GoodsName = goodsEntity.Name
	return
}

// GetAll .
func (srv *OrderService) GetAll(userID int) (result []dto.OrderRep, e error) {
	entitys, e := srv.OrderRepo.GetAll(userID)
	if e != nil {
		return
	}

	for _, obj := range entitys {
		goodsEntity, err := srv.GoodsRepo.Get(obj.GoodsID)
		if err != nil {
			e = err
			return
		}

		result = append(result, dto.OrderRep{
			ID:        obj.ID,
			GoodsID:   obj.GoodsID,
			GoodsName: goodsEntity.Name,
			Num:       obj.Num,
			DateTime:  obj.Created.Format("2006-01-02 15:04:05"),
		})
	}
	return
}

// Add .
func (srv *OrderService) Add(goodsID, num, userID int) (resp string, e error) {
	goodsEntity, e := srv.GoodsRepo.Get(goodsID)
	if e != nil {
		return
	}
	if goodsEntity.Stock < num {
		resp = "库存不足"
		return
	}
	goodsEntity.AddStock(-num)

	e = srv.Tx.Execute(func() error {
		if err := srv.GoodsRepo.Save(&goodsEntity); err != nil {
			return err
		}

		return srv.OrderRepo.Create(goodsEntity.ID, num, userID)
	})
	return
}
