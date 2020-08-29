package server

import (
	"fmt"
	"github.com/go-http-utils/logger"
	"github.com/rapatao/h2tp/internal/config"
	"log"
	"net/http"
	"os"
)

func Start(definition config.Definition) {

	fs := http.FileServer(http.Dir(definition.Path))

	log.Printf("Serving %s on port %d", definition.Path, definition.Port)

	addr := fmt.Sprintf(":%d", definition.Port)
	handler := logger.Handler(fs, os.Stdout, logger.CombineLoggerType)

	err := http.ListenAndServe(addr, handler)

	if err != nil {
		log.Fatal(err)
	}
}
