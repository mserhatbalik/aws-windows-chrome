######### BACKEND & MODULES #########

module "aws" {
    source = "./modules/aws"

    aws_vpc_name = "win-server-vpc"
    aws_vpc_cidr = "10.0.0.0/16"
    aws_region = "us-west-1"
    aws_az_count = 2
    aws_ssh_key = var.aws_ssh_key
    aws_ec2_instance_image = var.aws_ec2_instance_image
    aws_ec2_instance_type = "t2.medium"
    aws_eks_cluster_name = "trio-eks"
    aws_environment = "dev"
}

output "bastion" {
  value = module.aws.bastion["public_ip"]
}

// Yukarıdaki "bastion" output ile password çekemediğimiz için aws/bastion modülü içerisinde "base bastion" diye ek output yaratıp onu kullandım.
output "windows_password" {
  value = rsadecrypt(module.aws.base_bastion.password_data, file(var.aws_ssh_key_private))
  sensitive = false
}