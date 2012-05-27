package main

import (
	//e "errors"
	"log"
	"time"
)

func main() {
	room := newChatroom("room")
	user1 := NewUser("user1")
	room.Register(user1)
	user2 := NewUser("user2")
	room.Register(user2)
	go room.Start()
	go user1.Start()
	go user2.Start()
	user2.Send("hello from 2")
	user1.Send("hello from 1")
	time.Sleep(2 * 1e9)
}

type Chatroom struct {
	Name     string
	received chan string
	users    map[string](chan string)
}

func newChatroom(name string) *Chatroom {
	room := new(Chatroom)
	room.Name = name
	room.users = make(map[string](chan string))
	room.received = make(chan string)
	return room
}

type User struct {
	Name     string
	received chan string
	chatroom *Chatroom
}

func NewUser(name string) *User {
	user := new(User)
	user.Name = name
	user.received = make(chan string)
	return user
}

func (this *User) Send(text string) {
        log.Println(this.Name + " -> " + this.chatroom.Name + " : " + text)
	this.chatroom.received <- makeMessage(this, text)
}

func (this User) Start() {
	select {
	case msg := <-this.received:
		log.Println(this.Name + " <- " + msg)
	}
}

func (this *Chatroom) Register(user *User) (bool, error) {
	this.users[user.Name] = user.received
	user.chatroom = this
	return true, nil
}

func (this *Chatroom) Receive() string {
	return <-this.received
}

func (this *Chatroom) Relay(text string) {
	log.Println(this.users)
	for name, ch := range this.users {
		log.Println(this.Name + " -> " + name + " : " + text)
		ch <- text
	}

}

func (this Chatroom) Start() {
	log.Println("Waiting...")
	for {
		select {
		case msg := <-this.received:
			//log.Println("room received : " + msg)
			this.Relay(msg)
		}
	}
}
