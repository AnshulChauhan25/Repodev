# # Define the Azure provider
# provider "azurerm" {
#   features {}
# }
# data "azurerm_api_management" "main" {
#   name                = "dc-apim-01"
#   resource_group_name = "apim-test"
# }

# locals {
#   named_value = [
#     {
#         name = "name1"
#         display_name = "display_name1"
#         value = "value1"
#     },
#     {
#         name = "name2"
#         display_name = "display_name2"
#         value = "value2"
#     },
#     {
#         name = "name3"
#         display_name = "display_name3"
#         value = "value3"
#     },
#     {
#         name = "name4"
#         display_name = "display_name4"
#         value = "value4"
#     }
#   ]
# }

# resource "azurerm_api_management_named_value" "main" {
#   count               = length(local.named_value)
#   name                = local.named_value[count.index].name
#   resource_group_name = data.azurerm_api_management.main.resource_group_name
#   api_management_name = data.azurerm_api_management.main.name
#   display_name        = local.named_value[count.index].display_name
#   value               = local.named_value[count.index].value
# }

provider "azurerm" {
  features {}
}

data "azurerm_api_management" "main" {
  name                = "dc-apim-01"
  resource_group_name = "apim-test"
}

locals {
  named_values = [
    {
      name        = "name1"
      display_name = "display_name1"
      value       = "value1"
    },
    {
      name        = "name2"
      display_name = "display_name2"
      value       = "value2"
    },
    {
      name        = "name3"
      display_name = "display"
      value       = "value3"
    },
    {
      name        = "name4"
      display_name = "display_name4"
      value       = "value4"
    },
    {
      name        = "name5"
      display_name = "display_name5"
      value       = "value5"
    }
  ]
}

resource "azurerm_api_management_named_value" "main" {

  for_each = {
    for nv in local.named_values : nv.name => nv
  }
  name                = each.value.name
  resource_group_name = data.azurerm_api_management.main.resource_group_name
  api_management_name = data.azurerm_api_management.main.name
  display_name        = each.value.display_name
  value               = each.value.value
}
