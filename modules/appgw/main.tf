resource "azurerm_public_ip" "appgw_pip" {
  name                = "pip-${var.appgw_name}"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_application_gateway" "appgw" {
  name                = var.appgw_name
  location            = var.location
  resource_group_name = var.rg_name

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  ssl_policy {
  policy_type = "Predefined"
  policy_name = "AppGwSslPolicy20220101"
}

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_appgw_id
  }

  frontend_ip_configuration {
    name                 = "appgw-frontend-ip"
    public_ip_address_id = azurerm_public_ip.appgw_pip.id
  }

  frontend_port {
    name = "appgw-frontend-port"
    port = 80
  }

  backend_address_pool {
    name         = "appgw-backend-pool"
    ip_addresses = []
  }

  probe {
    name                = "appgw-health-probe"
    protocol            = "Http"
    path                = "/"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true
}

  backend_http_settings {
    name                  = "appgw-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "appgw-listener"
    frontend_ip_configuration_name = "appgw-frontend-ip"
    frontend_port_name             = "appgw-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "appgw-routing-rule"
    rule_type                  = "Basic"
    priority                   = 1
    http_listener_name         = "appgw-listener"
    backend_address_pool_name  = "appgw-backend-pool"
    backend_http_settings_name = "appgw-backend-http-settings"
  }
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "appgw_assoc" {
  for_each                = var.nic_ids
  network_interface_id    = each.value
  ip_configuration_name   = "internal"
backend_address_pool_id = tolist(azurerm_application_gateway.appgw.backend_address_pool)[0].id
}

