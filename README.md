# Yandex Cloud — Terraform

Проект выполнен с использованием Terraform и Yandex Cloud.

## Цель

Развернуть веб-инфраструктуру в Yandex Cloud с использованием:

- Object Storage;
- Instance Group;
- LAMP;
- Network Load Balancer (NLB);
- Application Load Balancer (ALB);
- проверки состояния виртуальных машин.

## Выполненные задания

### 1. Object Storage

Создан бакет Object Storage.

В бакет загружено изображение, которое сделано доступным из интернета.

Изображение используется на стартовой веб-странице виртуальных машин.

Формирование ссылки на изображение 

```bash
https://storage.yandexcloud.net/<ИМЯ_БАКЕТА>/<KEY_ОБЪЕКТА>
```
В проекте по умолчанию
```bash
https://storage.yandexcloud.net/hw-cloud-02-test-20260929/img/picture.jpg
```

### 2. Instance Group

Создана фиксированная Instance Group из **3 виртуальных машин**.

Для ВМ используется LAMP-образ.

При создании ВМ через `user_data` автоматически:

- создаётся стартовая веб-страница;
- на страницу добавляется изображение из Object Storage.

Для Instance Group настроена проверка состояния ВМ.

При выходе ВМ из строя Instance Group может автоматически восстановить её.

### 3. Network Load Balancer

Создан Network Load Balancer (NLB), подключенный к Instance Group.

NLB распределяет входящие HTTP-запросы между доступными ВМ.

Работоспособность проверялась удалением ВМ из Instance Group. После удаления неисправная ВМ автоматически восстанавливается, а трафик продолжает обслуживаться оставшимися экземплярами.

### 4. Application Load Balancer

Дополнительно создан Application Load Balancer (ALB).

ALB использует Instance Group в качестве backend и выполняет проверку состояния backend-ВМ.

Для ALB настроены:

- Load Balancer;
- HTTP listener;
- Target Group;
- Backend Group;
- HTTP Router;
- Virtual Host.

## Terraform-модули

### `vpc`

Создаёт сетевую инфраструктуру:

- VPC;
- подсети;
- таблицы маршрутизации.

### `storage`

Создаёт Object Storage и настраивает размещение изображения.

### `instance-group`

Создаёт Instance Group и виртуальные машины с LAMP.

Также отвечает за:

- шаблон ВМ;
- `user_data`;
- health check;
- Target Group.

### `load-balancer`

Отвечает за балансировку трафика.

Поддерживает:

- Network Load Balancer;
- Application Load Balancer;
- Target Group;
- Listener;
- Backend Group;
- HTTP Router;
- Virtual Host.

## Важное ограничение

В рамках данной конфигурации **NLB и ALB одновременно не назначаются к одной Instance Group через механизм интеграции группы**.

Поэтому в Terraform предусмотрены переключатели:

```hcl
network_load_balancer_enabled     = false
application_load_balancer_enabled = true
```

Для использования NLB:

```hcl
network_load_balancer_enabled     = true
application_load_balancer_enabled = false
```

Для использования ALB:

```hcl
network_load_balancer_enabled     = false
application_load_balancer_enabled = true
```

Таким образом, можно переключать используемый тип балансировщика без изменения структуры проекта.

## Результат

В результате Terraform разворачивает веб-инфраструктуру в Yandex Cloud:

```text
                    Internet
                        │
                        ▼
                 Load Balancer
                   NLB / ALB
                        │
              ┌─────────┼─────────┐
              ▼         ▼         ▼
             VM        VM        VM
              │         │         │
              └─────────┼─────────┘
                        │
                  Instance Group
                        │
                        ▼
                Object Storage
                   (image.jpg)
```

