variable "handlerJar" {
  default = ""
}
variable "region" {
  default = ""
}
variable "domainZone" {
  default = ""
}
variable "domain" {
  default = ""
}
variable "bucketBackend" {
  default = ""
}
variable "bucketJarName" {
  default = ""
}
variable "handlers" {
  type = map(string)
  default = {}
}
variable "handler" {
  default = ""
}
variable "corsOrigins" {
  type = list(string)
  default = ["*"]
}
variable "corsHeaders" {
  type = list(string)
  default = ["OPTIONS,POST"]
}
variable "corsMethods" {
  type = list(string)
  default = ["*"]
}
variable "parametersPrefix" {
  default = ""
}
variable "parameterCorsOrigins" {
  default = ""
}
variable "parameterCorsHeaders" {
  default = ""
}
variable "parameterCorsMethods" {
  default = ""
}
variable "remote_state" {
  type = map(string)
}
