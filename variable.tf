variable "region" {
  type = string
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "ami" {
  type = string
}
variable "port" {
  type = list(number)
}
variable "username" {
  type = string
}
variable "password" {
}

variable "instance_type" {
  type = string
}

variable "WORKSPACE_NAME" {
  type = string
}

# variable "workspace" {
#   default = $env:WORKSPACE_NAME
# }

