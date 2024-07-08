package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: ./myapp <command> [arguments]")
		os.Exit(1)
	}

	switch os.Args[1] {
	case "greet":
		greetCmd := flag.NewFlagSet("greet", flag.ExitOnError)
		name := greetCmd.String("name", "World", "name to greet")
		greetCmd.Parse(os.Args[2:])
		fmt.Printf("Hello, %s!\n", *name)
	default:
		fmt.Printf("%q is not valid command.\n", os.Args[1])
		os.Exit(2)
	}
}
