### Define a região
variable "server_region" {
  description = "Region to deploy server"
  type        = string
  default     = "sa-east-1"
}
### User p/ openVPN Client
variable "server_username" {
  description = "Admin Username to access server"
  type        = string
  default     = "openvpn"
}
### Password p/ openVPN Client
variable "server_password" {
  description = "Admin Password to access server"
  type        = string
  default     = "password"
}

### Define a AZ
variable "AWS_REGION_AZ_WEB_1" {
  default = "sa-east-1a"
}