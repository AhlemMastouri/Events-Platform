variable "region" {
  type    = string
  default = "us-east-1"
}
variable "cluster_name" {
  type    = string
  default = "fst-events"
}
variable "node_instance_type" {
  type    = string
  default = "t3.medium"
}