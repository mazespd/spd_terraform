<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.60.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ya_instance_1"></a> [ya\_instance\_1](#module\_ya\_instance\_1) | ./instance | n/a |
| <a name="module_ya_instance_2"></a> [ya\_instance\_2](#module\_ya\_instance\_2) | ./instance | n/a |

## Resources

| Name | Type |
|------|------|
| [yandex_iam_service_account.sa](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/iam_service_account) | resource |
| [yandex_iam_service_account_static_access_key.sa-static-key](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/iam_service_account_static_access_key) | resource |
| [yandex_resourcemanager_folder_iam_member.sa-editor](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/resourcemanager_folder_iam_member) | resource |
| [yandex_storage_bucket.state](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/storage_bucket) | resource |
| [yandex_vpc_network.network](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnet1](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/vpc_subnet) | resource |
| [yandex_vpc_subnet.subnet2](https://registry.terraform.io/providers/yandex-cloud/yandex/0.60.0/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | access-key | `string` | `"YCAJEyysRgel3-2p7dkAuBAI2"` | no |
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | cloud id | `string` | `"b1gnhe9up3k3i3m6k06v"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Default folder ID in yandex cloud | `string` | `"b1gbpfhk2frqd3fdjnui"` | no |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | secret-key | `string` | `"YCOSSdRy1Wi9qZz92TqwFW0jycMwPZBHbUWx_ewM"` | no |
| <a name="input_token"></a> [token](#input\_token) | token | `string` | `"y0_AgAAAAAicE9NAATuwQAAAADjkWIeTh7XqphlQr-70OsqPaPlJNsy7_M"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key"></a> [access\_key](#output\_access\_key) | n/a |
| <a name="output_secret_key"></a> [secret\_key](#output\_secret\_key) | n/a |
<!-- END_TF_DOCS -->