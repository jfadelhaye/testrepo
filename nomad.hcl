job "demo" {
  datacenters = ["dc1"]

  namespace = "default"

  type = "service"

  group "redis" {

    count = 1

    network {
      port "db" {
        static = 6379
        to = 6379
      }
    }

    task "redis" {

      driver = "docker"

      config {
        image = "redis:latest"

        ports = ["db"]
      }

      resources {
        cpu    = 256
        memory = 256
      }
    }
  }

  group "echo" {

    count = 1

    network {
      port "http" {
        static = 8080
        to = 8080
      }
    }

    task "echo" {

      driver = "docker"

      config {
        image = "hashicorp/http-echo:latest"
        ports = ["http"]
        args  = [
          "-text", "Hi, this is Nomad :)",
          "-listen", ":8080"
        ]
      }

      resources {
        cpu    = 128
        memory = 128
      }

    }
  }
}
