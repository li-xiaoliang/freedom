package event

import "encoding/json"

// ChangePassword 修改密码事件
type ChangePassword struct {
	id          int
	UserID      int    `json:"userID"`
	NewPassword string `json:"newPassword"`
	OldPassword string `json:"oldPassword"`
}

// Name .
func (password *ChangePassword) Name() string {
	return "ChangePassword"
}

// SetPrototype .
func (password *ChangePassword) SetPrototype(prototype string, id interface{}) {
	if prototype == "id" {
		password.id = id.(int)
	}
}

// GetPrototype .
func (password *ChangePassword) GetPrototype(prototype string) interface{} {
	if prototype == "id" {
		return password.id
	}
	return nil
}

// Marshal .
func (password *ChangePassword) Marshal() []byte {
	data, _ := json.Marshal(password)
	return data
}
