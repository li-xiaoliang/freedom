package controllers

import (
	"github.com/8treenet/freedom"
)

func init() {
	freedom.Prepare(func(initiator freedom.Initiator) {
		initiator.BindController("/shop", &ShopController{})
	})
}

// ShopController .
type ShopController struct {
	Worker freedom.Worker
}

// GetBy handles the GET: /shop/:id route.
func (s *ShopController) GetBy(id int) string {
	// data, _ := json.Marshal(dto.Goods{
	// 	ID:     id,
	// 	Amount: 10,
	// })
	return "ok"
}
