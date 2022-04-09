name                       = "kubernetes"
kubernetes_version         = "1.20.13"
agent_count                = 3
vm_size                    = "Standard_DS2_v2"

addons = {
  oms_agent                   = true
  ingress_application_gateway = true
}