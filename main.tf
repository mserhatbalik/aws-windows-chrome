######### BACKEND & MODULES #########

module "aws" {
    source = "./modules/aws"

    aws_vpc_name = "win-server-vpc"
    aws_vpc_cidr = "10.0.0.0/16"
    # aws_region = "eu-central-1"
    aws_region = "us-west-1"
    aws_az_count = 2
    aws_ssh_key = var.aws_ssh_key
    aws_ec2_instance_image = var.aws_ec2_instance_image
    aws_ec2_instance_type = "t2.medium"
    aws_eks_cluster_name = "trio-eks"
    aws_environment = "dev"
    # eks_oidc_root_ca_thumbprint = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
    # eks_ecr_addon_registry = "602401143452.dkr.ecr.eu-central-1.amazonaws.com"
}

output "bastion" {
  value = module.aws.bastion["public_ip"]
}