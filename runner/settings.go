package runner

import (
	"encoding/json"
	"io/ioutil"
	"os"
)

func WriteSettings(data string) {
	if err := ioutil.WriteFile("scriptfiles/data/settings.ini", []byte(data), os.ModePerm); err != nil {
		panic(err)
	}
}

// SetConfigRconPassword updates the rcon.password field in open.mp's config.json
// while preserving every other setting and the file's structure.
func SetConfigRconPassword(password string) error {
	data, err := ioutil.ReadFile("config.json")
	if err != nil {
		return err
	}

	var cfg map[string]interface{}
	if err := json.Unmarshal(data, &cfg); err != nil {
		return err
	}

	rcon, ok := cfg["rcon"].(map[string]interface{})
	if !ok {
		rcon = map[string]interface{}{}
		cfg["rcon"] = rcon
	}
	rcon["password"] = password

	out, err := json.MarshalIndent(cfg, "", "    ")
	if err != nil {
		return err
	}

	return ioutil.WriteFile("config.json", append(out, '\n'), 0644)
}
