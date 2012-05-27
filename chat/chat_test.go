package main

import (
	"testing"
	"log"
)

func Test_ChatroomInitialization(t *testing.T) {
	expected := "testroom"
	room := newChatroom(expected)
	if room.Name != expected || room.received == nil {
		t.Error("Chatroom not instantiated.")
	}
}

func Test_UserInitialization(t *testing.T) {
	expected := "name"
	user := NewUser("name")
	if user.Name != expected {
		t.Error("User not instantiated")
	}
}

func Test_Register(t *testing.T) {
	room := newChatroom("room")
	user := NewUser("user")
	room.Register(user)
	if room.users[user.Name] == nil {
		t.Error("User not registered")
	}
}

func Test_SendReceive(t *testing.T) {
	room := newChatroom("room")
	user := NewUser("user")
	room.Register(user)
	sentValue := "hello"
	go func() {
		user.Send(sentValue)
	}()
	select {
	case val := <-user.chatroom.received:
		if val != sentValue {
		        log.Println(val, makeMessage(user, sentValue))
			t.Error("Channel failed.")
		}
	}
}
