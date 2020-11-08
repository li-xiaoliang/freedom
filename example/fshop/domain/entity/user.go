package entity

import (
	"errors"
	"strconv"

	"github.com/8treenet/freedom"
	"github.com/8treenet/freedom/example/fshop/domain/event"
	"github.com/8treenet/freedom/example/fshop/domain/po"
)

//User 用户实体
type User struct {
	freedom.Entity
	po.User
}

// Identity 唯一
func (u *User) Identity() string {
	return strconv.Itoa(u.ID)
}

// ChangePassword 修改密码
func (u *User) ChangePassword(newPassword, oldPassword string) error {
	if u.Password != oldPassword {
		return errors.New("Password error")
	}
	u.SetPassword(newPassword)

	// AddEvent 会加入Worker.events 请求结束会发布或手动发布
	u.AddPubEvent(&event.ChangePassword{
		UserID:      u.User.ID,
		NewPassword: u.Password,
		OldPassword: oldPassword,
	})
	return nil
}
