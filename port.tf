terraform {
  required_providers {
    port = {
      source  = "port-labs/port-labs"
      version = "~> 1.0.0"
    }
  }
}

provider "port" {
  client_id = "PORT_CLIENT_ID.var"     # or set the environment variable PORT_CLIENT_ID
  secret    = PORT_CLIENT_SECRET.var" # or set the environment variable PORT_CLIENT_SECRET
}
