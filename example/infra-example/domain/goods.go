package domain

import (
	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/infra-example/adapter/repository"
	"github.com/8treenet/freedom/example/infra-example/domain/dto"
)

func init() {
	freedom.Prepare(func(initiator freedom.Initiator) {
		initiator.BindService(func() *GoodsService {
			return &GoodsService{}
		})
		initiator.InjectController(func(ctx freedom.Context) (service *GoodsService) {
			initiator.GetService(ctx, &service)
			return
		})
	})
}

// GoodsService .
type GoodsService struct {
	Worker    freedom.Worker
	GoodsRepo *repository.GoodsRepository
}

// Get .
func (srv *GoodsService) Get(ID int) (rep dto.GoodsRep, e error) {
	entity, e := srv.GoodsRepo.Get(ID)
	if e != nil {
		return
	}
	rep.ID = entity.ID
	rep.Name = entity.Name
	rep.Stock = entity.Stock
	rep.Price = entity.Price
	return
}

// GetAll .
func (srv *GoodsService) GetAll() (result []dto.GoodsRep, e error) {
	entitys, e := srv.GoodsRepo.GetAll()
	if e != nil {
		return
	}
	for _, goodsModel := range entitys {
		result = append(result, dto.GoodsRep{
			ID:    goodsModel.ID,
			Name:  goodsModel.Name,
			Price: goodsModel.Price,
			Stock: goodsModel.Stock,
		})
	}
	return
}

// AddStock .
func (srv *GoodsService) AddStock(goodsID, num int) error {
	entity, e := srv.GoodsRepo.Get(goodsID)
	if e != nil {
		return e
	}

	entity.AddStock(num)
	return srv.GoodsRepo.Save(&entity)
}
