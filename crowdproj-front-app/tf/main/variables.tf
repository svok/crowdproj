variable "sourcePath" {
  default = ""
}
variable "bucketPublic" {
  default = ""
}
variable "region" {
  default = ""
}
variable "mime_types" {
  type = map(string)
  default = {}
}
variable "corsOrigins" {
  type = list(string)
  default = []
}
variable "baseName" {
  default = ""
}
variable "remote_state" {
  type = map(string)
}
