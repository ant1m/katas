package main

import (
	"fmt"
	"time"
)

type Room struct {
	messages chan *Message
	joiners  chan *User
	users    []*User
}

type User struct {
	inbox chan *Message
	login string
}

type Message struct {
	sender *User
	body   string
}

func NewRoom() *Room {
	r := new(Room)
	r.messages = make(chan *Message)
	r.joiners = make(chan *User)
	r.users = make([]*User, 0)
	return r
}

func NewUser(login string) *User {
	return &User{make(chan *Message), login}
}

func (r *Room) Register(u *User) {
	r.joiners <- u
}

func (u *User) Say(c *Room, text string) {
	c.messages <- &Message{u, text}
}

func (m *Message) Print() string {
	return fmt.Sprintf("%s says %s", m.sender.login, m.body)
}

func (r *Room) Serve() {
	for {
		select {
		case joiner := <-r.joiners:
			r.users = append(r.users, joiner)
			fmt.Println("hello ", joiner.login)
		case message := <-r.messages:
			fmt.Println("received ", message.body, "from", message.sender.login)
			for _, user := range r.users {
				user.inbox <-message
			}
		}
	}
}

func (u *User) Wait() {
	for {
		message := <-u.inbox
		fmt.Println(message.Print())
	}
}

func main() {
	room := NewRoom()
	go room.Serve()
	user1 := NewUser("u1")
	user2 := NewUser("u2")
	room.Register(user1)
	room.Register(user2)
	go user1.Say(room, "fuuuu1")
	go user1.Say(room, "fuuuu1 again")
	go user2.Say(room, "FUUUU2")
	go user1.Wait()
	go user2.Wait()
	time.Sleep(1e9)
}
