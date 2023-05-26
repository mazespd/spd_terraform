terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.60.0"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-state-bucket-spd"
    region     = "ru-central1-a"
    key        = "spd.tfstate-new"
    access_key = "YCAJE_w7gGF7x8PPOWhvsK9nH"
    secret_key = "YCM_tARp2pPWOZ5T0hjBvmdk_JGv5ohwaghDw3oo"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
provider "yandex" {
  token     = "y0_AgAAAAAicE9NAATuwQAAAADjkWIeTh7XqphlQr-70OsqPaPlJNsy7_M"
  cloud_id  = "b1gnhe9up3k3i3m6k06v"
  folder_id = var.folder_id
  zone      = "ru-central1-b"
}

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "subnet2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}


module "ya_instance_1" {
  source                = "./instance"
  instance_family_image = "lemp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet1.id
}

module "ya_instance_2" {
  source                = "./instance"
  instance_family_image = "lamp"
  vpc_subnet_id         = yandex_vpc_subnet.subnet2.id
}

#группa для балансировщика

resource "yandex_lb_target_group" "test" {
  name           = "test"
  
  target {
    subnet_id    = "${yandex_vpc_subnet.subnet1.id}"
    address   = "${module.ya_instance_1.internal_ip_address_vm}"

  }

  target {
    subnet_id    = "${yandex_vpc_subnet.subnet2.id}"
    address   = "${module.ya_instance_2.internal_ip_address_vm}"
  }
}

#сетевой балансировщик

resource "yandex_lb_network_load_balancer" "foo" {
  name = "my-network-load-balancer"

  listener {
    name        = "test-listener"
    port        = 80
    target_port = 81
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

attached_target_group {
    target_group_id = "${yandex_lb_target_group.test.id}"

    healthcheck {
      name                = "http"
      interval            = 2
      timeout             = 1
      unhealthy_threshold = 2
      healthy_threshold   = 2
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

# Создаем сервис-аккаунт SA
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "sa-skillfactory"
}

# Даем права на запись для этого SA
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = "b1gbpfhk2frqd3fdjnui"
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Создаем ключи доступа Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

# Создаем хранилище
resource "yandex_storage_bucket" "state" {
  bucket     = "tf-state-bucket-spd"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
}