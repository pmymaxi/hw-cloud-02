vpc_network = {
  develop = {
    name = "network-hw-cloud"
    labels = {
      network = "develop"
    }
  }
}

vpc_subnet = {
  develop = {
    public = {
      description = "Публичная подсеть"
      labels = {
        subnet = "public"
      }
      zone           = "ru-central1-a"
      v4_cidr_blocks = "192.168.10.0/24"
    }

    private = {
      description = "Приватная подсеть"
      labels = {
        subnet = "private"
      }
      zone           = "ru-central1-a"
      v4_cidr_blocks = "192.168.20.0/24"
      route_table    = "private"
    }
  }
}

/* gateway = {
  main = {
    name = "hw-gateway"
    labels = {
      gateway = "main"
    }
  }
}*/
route_table = {
  develop = {
    private = {
      labels = {
        route_table = "private"
      }

      static_route = {
        destination_prefix = "0.0.0.0/0"
        next_hop_address   = "192.168.10.254"
      }
    }
  }
}
/*
security_group = {
  develop = {
    name        = "develop-sg"
    description = "Security group for develop network"
    labels = {
      security_group = "develop"
    }
  }
} */