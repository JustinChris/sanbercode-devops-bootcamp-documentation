package main

import "fmt"

var name string

func init() {
	fmt.Println("Init function")
	name = "Gopher"
}

func main() {
	// ada dua package yang reserved di go, main() dan init()
	// setiap package harus ada function main
	// function init dipake untuk setup, dia jalan sebelum main.
	fmt.Println("Hello, World!", name)

}
