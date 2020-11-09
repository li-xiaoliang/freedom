package repository

import (
	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/fshop/domain/entity"
	"github.com/8treenet/freedom/example/infra-example/domain/po"
	"github.com/jinzhu/gorm"
)

func init() {
	freedom.Prepare(func(initiator freedom.Initiator) {
		initiator.BindRepository(func() *GoodsRepository {
			return &GoodsRepository{}
		})
	})
}

// GoodsRepository .
type GoodsRepository struct {
	freedom.Repository
}

// Get .
func (repo *GoodsRepository) Get(ID int) (result *entity.Goods, e error) {
	result = &entity.Goods{}
	result.ID = ID
	//注入基础Entity 包含运行时和领域事件集合.
	repo.InjectBaseEntity(goodsEntity)

	e = findGoods(repo, result)
	return
}

// GetAll .
func (repo *GoodsRepository) GetAll() (result []*entity.Goods, e error) {
	e = findGoodsList(repo, po.Goods{}, &result)
	if e != nil {
		return
	}

	//注入基础Entity 包含运行时和领域事件集合.
	repo.InjectBaseEntitys(entitys)
	return
}

// Save .
func (repo *GoodsRepository) Save(goods *po.Goods) (e error) {
	_, e = saveGoods(repo, goods)
	return
}

func (repo *GoodsRepository) db() *gorm.DB {
	var db *gorm.DB
	if err := repo.FetchDB(&db); err != nil {
		panic(err)
	}
	db.SetLogger(repo.Worker.Logger())
	return db
}
