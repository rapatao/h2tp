package main

import (
	"github.com/rapatao/h2tp/internal/config"
	"github.com/rapatao/h2tp/internal/server"
)

func main() {
	server.Start(config.Load())
}
