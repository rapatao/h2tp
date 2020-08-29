package config

import (
	"log"
	"os"
)

type Definition struct {
	Port int
	Path string
}

func (config *Definition) consolidate(params *Definition) {
	if params.Port != 0 {
		config.Port = params.Port
	}
	if config.Port == 0 {
		config.Port = 5000
	}

	if params.Path != "" {
		config.Path = params.Path
	}
	if config.Path == "" {
		workDir, err := os.Getwd()

		if err != nil {
			log.Fatal(err)
		}

		config.Path = workDir
	}
}
