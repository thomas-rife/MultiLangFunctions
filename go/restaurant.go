package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
)

func do(seconds int, action ...any) {
    log.Println(action...)
    randomMillis := 500*seconds + rand.Intn(500*seconds)
    time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

type Order struct {
    id         uint64
    customer   string
    preparedBy string
    reply      chan *Order
}

var orderID atomic.Uint64

func newOrder(customer string) *Order {
    id := orderID.Add(1)
    return &Order{
        id:       id,
        customer: customer,
        reply:    make(chan *Order, 1),
    }
}

func cook(name string, waiter chan *Order) {
    log.Println(name, "starting work")
    for order := range waiter {
        do(10, name, "cooking order", order.id, "for", order.customer)
        order.preparedBy = name
        order.reply <- order
    }
}

func customer(name string, waiter chan *Order, wg *sync.WaitGroup) {
    defer wg.Done()
    for meals := 0; meals < 5; {
        order := newOrder(name)
        log.Println(name, "placed order", order.id)
        select {
        case waiter <- order:
            meal := <-order.reply
            do(2, name, "eating cooked order", meal.id, "prepared by", meal.preparedBy)
            meals++
        case <-time.After(7 * time.Second):
            do(5, name, "waiting too long, abandoning order", order.id)
        }
    }
    log.Println(name, "going home")
}

func main() {
    waiter := make(chan *Order, 3)
    cooks := []string{"Remy", "Colette", "Linguini"}

    for _, cookName := range cooks {
        go cook(cookName, waiter)
    }

    customers := []string{"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai"}
    var wg sync.WaitGroup
    wg.Add(len(customers))

    for _, customerName := range customers {
        go customer(customerName, waiter, &wg)
    }

    wg.Wait()
    log.Println("Restaurant closing")
}
