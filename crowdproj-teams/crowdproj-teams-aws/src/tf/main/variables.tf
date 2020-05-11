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
variable "remote_state" {
  type = map(string)
}
