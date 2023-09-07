######### AWS VARIABLES #########

variable "aws_environment" {
  type    = string
  default = "test"
}

variable "aws_vpc_name" {
  type    = string
  default = "custom-vpc"
}

variable "aws_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "aws_az_count" {
  type    = number
  default = 1
}

variable "aws_ssh_key" {
  type = string
  default = "/home/serhat/.ssh/id_rsa.pub"
}

variable "aws_ec2_instance_image" {
  type = string
  # default = "ami-0d527b8c289b4af7f"
  default = "ami-08daca216d2bde943"
}

variable "aws_ec2_instance_type" {
  type = string
  default = "t2.nano"
}

variable "aws_nat_ips" {
  type = list
  default = ["0.0.0.0"]
}

variable "aws_bastion_ip" {
  type = list
  default = ["0.0.0.0"]
}