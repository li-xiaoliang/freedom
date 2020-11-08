package event

import "encoding/json"

// ShopGoods 购买事件
type ShopGoods struct {
	id        int
	UserID    int    `json:"userID"`
	OrderNO   string `json:"orderNO"`
	GoodsID   int    `json:"goodsID"`
	GoodsNum  int    `json:"goodsNum"`
	GoodsName string `json:"goodsName"`
}

// Name .
func (shop *ShopGoods) Name() string {
	return "ShopGoods"
}

// SetPrototype .
func (shop *ShopGoods) SetPrototype(prototype string, id interface{}) {
	if prototype == "id" {
		shop.id = id.(int)
	}
}

// GetPrototype .
func (shop *ShopGoods) GetPrototype(prototype string) interface{} {
	if prototype == "id" {
		return shop.id
	}
	return nil
}

// Marshal .
func (shop *ShopGoods) Marshal() []byte {
	data, _ := json.Marshal(shop)
	return data
}
