package config

import (
	"encoding/json"
	"flag"
	"io/ioutil"
	"log"
)

func Load() Definition {
	var filename string
	flag.StringVar(&filename, "config", "./config.json", "the config location")

	params := Definition{}

	flag.IntVar(&params.Port, "port", 0, "the server port")
	flag.StringVar(&params.Path, "path", "", "path to serve")

	flag.Parse()

	file, err := ioutil.ReadFile(filename)

	config := Definition{}

	if err == nil {
		log.Printf("Using configuration defined into the config file \"%s\"", filename)
		err = json.Unmarshal(file, &config)

		if err != nil {
			log.Fatal(err)
		}

	} else {
		log.Printf("Failed to load config file \"%s\"... Using the default configuration...", filename)
	}

	config.consolidate(&params)

	return config
}
