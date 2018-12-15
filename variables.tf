variable "master_count" {
  default = 3
}

variable "worker_count" {
  default = 3
}

variable "master_scripts" {
  type = "list"
  default = [
    "scripts/docker.sh",
  ]
}

variable "worker_scripts" {
  type = "list"
  default = [
    "scripts/docker.sh",
  ]
}

variable "output_path" {
  type = "string"
  default = "output/"
}

variable "private_key_file" {
  type = "string"
  default = "output/key.pem"
}

variable "username" {
  type = "string"
  default = "user"
}

variable "cluster_name" {
  type = "string"
  default = "cluster"
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