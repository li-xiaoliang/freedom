package aggregate

import (
	"errors"
	"time"

	"github.com/8treenet/freedom/example/fshop/domain/dependency"
	"github.com/8treenet/freedom/example/fshop/domain/entity"
	"github.com/8treenet/freedom/example/fshop/domain/event"
	"github.com/8treenet/freedom/example/fshop/domain/po"
	"github.com/8treenet/freedom/infra/transaction"
)

//GoodsShopCmd 购买商品聚合根
type GoodsShopCmd struct {
	entity.Order
	userEntity  *entity.User
	goodsEntity *entity.Goods

	orderRepo dependency.OrderRepo
	goodsRepo dependency.GoodsRepo
	tx        transaction.Transaction
	goodsNum  int
}

// Shop 购买
func (cmd *GoodsShopCmd) Shop() error {
	if cmd.goodsNum > cmd.goodsEntity.Stock {
		return errors.New("库存不足")
	}
	//扣库存
	cmd.goodsEntity.AddStock(-cmd.goodsNum)

	//设置订单总价格
	totalPrice := cmd.goodsEntity.Price * cmd.goodsNum
	cmd.SetTotalPrice(totalPrice)
	//设置订单的用户
	cmd.SetUserID(cmd.userEntity.ID)
	//增加订单的商品详情
	cmd.AddOrderDetal(&po.OrderDetail{OrderNo: cmd.OrderNo, GoodsID: cmd.goodsEntity.ID, GoodsName: cmd.goodsEntity.Name, Num: cmd.goodsNum, Created: time.Now(), Updated: time.Now()})

	//增加领域事件
	cmd.Order.AddPubEvent(&event.ShopGoods{
		UserID:    cmd.UserID,
		OrderNO:   cmd.OrderNo,
		GoodsID:   cmd.goodsEntity.ID,
		GoodsNum:  cmd.goodsNum,
		GoodsName: cmd.goodsEntity.Name,
	})
	//事务执行 创建 订单表、订单详情表，修改商品表的库存
	e := cmd.tx.Execute(func() error {
		if e := cmd.orderRepo.Save(&cmd.Order); e != nil {
			return e
		}
		if e := cmd.goodsRepo.Save(cmd.goodsEntity); e != nil {
			return e
		}
		return nil
	})

	if e != nil {
		cmd.RemoveAllPubEvent()
	}
	return e
}
