#### vpc variables
variable "name-prefix" {
  type        = string
  description = "Common name used across all resources"
}

variable "common-tags" {
  description = "A map of common tags to be added to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}


variable "enable_nat_gateway" {
  default = true
}

variable "instance_tenancy" {
  default = "default"
}

variable "cidr_block" {
  description = "CIDR block range"
  default     = "10.0.0.0/16"
}

### provider variables
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "azs" {
  type    = list(string)
  default = []
}
