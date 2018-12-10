variable "setup-scripts" {
  type = "list"
  default = [
    "scripts/docker.sh",
  ]
}
variable "ssh-keys" {
  type = "list"
}
variable "username" {
  type = "string"
  default = "user"
}
variable "token" {
  type = "string"
}
variable "cloud_id" {
  type = "string"
}
variable "folder_id" {
  type = "string"
}