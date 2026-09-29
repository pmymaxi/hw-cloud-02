variable "access_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "env переменная access_key для статистического ключа сервисного аккаунта"
}

variable "secret_key" {
  type        = string
  default     = null
  sensitive   = true
  description = "env переменная secret_key для статистического ключа сервисного аккаунта"
}


variable "cloud_id" {
  type        = string
  description = "ID облака размещения"
}

variable "folder_id" {
  type        = string
  default     = "ru-central1-a"
  description = "ID каталога размещения"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Регион размещения"
}


variable "each_vm" {
  type = list(object({
    count             = number
    hostname          = string
    vm_name           = string
    user              = string
    group             = optional(string)
    name_network      = string
    name_subnet       = string
    family            = optional(string)
    platform_id       = string
    image_id          = optional(string)
    zone              = string
    cpu               = number
    ram               = number
    disk_size         = number
    disk_type         = string
    disk_auto_delete  = bool
    core_fraction     = number
    preemptible       = bool
    nat               = bool
    ip_address        = optional(string)
    allow_stop_update = bool
  }))
}


variable "vms_resources_metadata" {
  type = map(object({
    serial-port-enable = string
  }))
}



# VPC

variable "vpc_network" {
  description = "Облачные сети"

  type = map(object({
    name        = string
    description = optional(string)
    labels      = optional(map(string), {})
  }))

  default = {}
}


variable "vpc_subnet" {
  description = "Подсети облачных сетей"

  type = map(map(object({
    description    = optional(string)
    labels         = optional(map(string), {})
    zone           = string
    v4_cidr_blocks = string
    route_table    = optional(string)
  })))

  default = {}
}


variable "security_group" {
  description = "Группы безопасности"

  type = map(object({
    name        = string
    description = optional(string)
    labels      = optional(map(string), {})
  }))

  default = {}
}


variable "security_group_ingress" {
  type = map(list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  })))

  default     = {}
  description = "Блок конфигурации правил входящих соединений в группе безопасности"
}


variable "security_group_egress" {
  type = map(list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  })))

  default     = {}
  description = "Блок конфигурации правил исходящих соединений в группе безопасности"
}


variable "gateway" {
  description = "Gateway"

  type = map(object({
    name   = string
    labels = optional(map(string), {})
  }))

  default = {}
}


variable "route_table" {
  description = "Таблицы маршрутизации"

  type = map(map(object({
    labels = optional(map(string), {})

    static_route = object({
      destination_prefix = string
      gateway            = optional(string)
      next_hop_address   = optional(string)
    })
  })))

  default = {}
}


# STORAGE

variable "storage_service_account" {
  description = "Сервисные аккаунты для Object Storage"

  type = map(object({
    name     = string
    role     = optional(string)
    desc_key = optional(string)
  }))

  default = {}
}


variable "storage_kms_key" {
  description = "KMS ключи для Object Storage"

  type = map(object({
    name              = string
    description       = optional(string, "")
    default_algorithm = optional(string, "AES_128")
    rotation_period   = optional(string)
    service_accounts  = optional(list(string), [])
  }))

  default = {}
}


variable "storage_bucket" {
  description = "Object Storage buckets"

  type = map(object({
    max_size   = optional(number)
    versioning = optional(bool, false)

    anonymous_access = optional(object({
      read        = optional(bool, false)
      list        = optional(bool, false)
      config_read = optional(bool, false)
    }), {})

    encryption = optional(object({
      kms_key       = string
      sse_algorithm = optional(string, "aws:kms")
    }))

    objects = optional(map(object({
      key     = string
      source  = optional(string)
      content = optional(string)
      tags    = optional(map(string), {})
      public  = optional(bool, false)
    })), {})

    access = optional(object({
      service_account = string
      role            = optional(string, "storage.viewer")
    }))
  }))

  default = {}
}


# INSTANCE GROUP

variable "instance_group_name" {
  description = "Имя Instance Group"
  type        = string
}

variable "instance_group_service_account" {
  description = "Ключ сервисного аккаунта Instance Group"
  type        = string
}

variable "instance_group_network" {
  description = "Ключ VPC сети Instance Group"
  type        = string
}

variable "instance_group_subnet" {
  description = "Ключ подсети Instance Group"
  type        = string
}

variable "instance_group_zone" {
  description = "Зона Instance Group"
  type        = string
}

variable "instance_group_count" {
  description = "Количество ВМ"
  type        = number
}

variable "instance_group_image_id" {
  description = "ID образа LAMP"
  type        = string
}

variable "instance_group_platform_id" {
  description = "Платформа ВМ"
  type        = string
}

variable "instance_group_cores" {
  description = "Количество CPU"
  type        = number
}

variable "instance_group_memory" {
  description = "RAM в GB"
  type        = number
}

variable "instance_group_core_fraction" {
  description = "Гарантированная доля CPU"
  type        = number
}

variable "instance_group_disk_size" {
  description = "Размер загрузочного диска"
  type        = number
}

variable "instance_group_disk_type" {
  description = "Тип загрузочного диска"
  type        = string
}

variable "instance_group_preemptible" {
  description = "Прерываемые ВМ"
  type        = bool
}

variable "instance_group_ssh_user" {
  description = "Пользователь SSH"
  type        = string
}

variable "instance_group_image_url" {
  description = "URL изображения Object Storage"
  type        = string
}

variable "instance_group_network_nat" {
  description = "Назначать публичный IP"
  type        = bool
}

variable "instance_group_deploy_policy" {
  description = "Политика развёртывания"

  type = object({
    max_unavailable = number
    max_expansion   = number
    strategy        = string
  })
}

variable "instance_group_health_check" {
  description = "Health check Instance Group"

  type = object({
    interval            = number
    timeout             = number
    unhealthy_threshold = number
    healthy_threshold   = number
    port                = number
  })
}

# NETWORK LOAD BALANCER

variable "network_load_balancer_enabled" {
  description = "Включить Network Load Balancer"
  type        = bool
}

variable "network_load_balancer_name" {
  description = "Имя Network Load Balancer"
  type        = string
}

variable "network_load_balancer_target_group_name" {
  description = "Имя Target Group для NLB"
  type        = string
}

variable "network_load_balancer_target_group_description" {
  description = "Описание Target Group для NLB"
  type        = string
}

variable "network_load_balancer_listener" {
  description = "Настройки listener Network Load Balancer"

  type = object({
    name        = string
    port        = number
    target_port = number
    protocol    = string
    ip_version  = string
  })
}

variable "network_load_balancer_healthcheck" {
  description = "Health check Network Load Balancer"

  type = object({
    name                = string
    interval            = number
    timeout             = number
    unhealthy_threshold = number
    healthy_threshold   = number

    http_options = object({
      port = number
      path = string
    })
  })
}


# APPLICATION LOAD BALANCER

variable "application_load_balancer_enabled" {
  description = "Включить Application Load Balancer"
  type        = bool
}

variable "application_load_balancer_name" {
  description = "Имя Application Load Balancer"
  type        = string
}

variable "application_load_balancer_target_group_name" {
  description = "Имя Target Group для ALB"
  type        = string
}

variable "application_load_balancer_target_group_description" {
  description = "Описание Target Group для ALB"
  type        = string
}

variable "application_load_balancer_http_router" {
  description = "Настройки HTTP Router"

  type = object({
    name = string
  })
}

variable "application_load_balancer_backend" {
  description = "Настройки Backend Group"

  type = object({
    name         = string
    backend_name = string
    port         = number
    weight       = number

    healthcheck = object({
      timeout             = string
      interval            = string
      healthy_threshold   = number
      unhealthy_threshold = number
      healthcheck_port    = number

      http_healthcheck = object({
        path = string
      })
    })
  })
}


variable "application_load_balancer_virtual_host" {
  description = "Настройки Virtual Host"
  type = object({
    name = string
    route = object({
      name    = string
      timeout = string
    })
  })
}

variable "application_load_balancer_listener" {
  description = "Настройки ALB listener"
  type = object({
    name = string
    port = number
  })
}
