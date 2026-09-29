# NETWORK LOAD BALANCER
network_load_balancer_enabled                  = false
network_load_balancer_name                     = "lamp-network-lb"
network_load_balancer_target_group_name        = "lamp-nlb-tg"
network_load_balancer_target_group_description = "Target group Instance Group for Network Load Balancer"

network_load_balancer_listener = {
  name        = "http"
  port        = 80
  target_port = 80
  protocol    = "tcp"
  ip_version  = "ipv4"
}

network_load_balancer_healthcheck = {
  name                = "http"
  interval            = 5
  timeout             = 3
  unhealthy_threshold = 3
  healthy_threshold   = 2
  http_options = {
    port = 80
    path = "/"
  }
}

# APPLICATION LOAD BALANCER
application_load_balancer_enabled                  = true
application_load_balancer_name                     = "lamp-application-lb"
application_load_balancer_target_group_name        = "lamp-alb-tg"
application_load_balancer_target_group_description = "Target group Instance Group for Application Load Balancer"

# HTTP ROUTER
application_load_balancer_http_router = {
  name = "lamp-application-router"
}

# BACKEND GROUP
application_load_balancer_backend = {
  name         = "lamp-application-backend"
  backend_name = "http"
  port         = 80
  weight       = 1
  healthcheck = {
    timeout             = "5s"
    interval            = "5s"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    healthcheck_port    = 80

    http_healthcheck = {
      path = "/"
    }
  }
}

# VIRTUAL HOST
application_load_balancer_virtual_host = {
  name = "lamp-application-host"
  route = {
    name    = "default"
    timeout = "10s"
  }
}

# LISTENER
application_load_balancer_listener = {
  name = "http"
  port = 80
}