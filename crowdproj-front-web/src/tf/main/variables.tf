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
variable "remote_state" {
  type = map(string)
}
