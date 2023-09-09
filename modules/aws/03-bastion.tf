######### INSTANCES #########

resource "aws_eip" "bastion" {
  depends_on = [module.ec2_bastion_host, module.vpc]
  instance = module.ec2_bastion_host.id
  vpc      = true

  tags = {
      Name = "bastion"
  }
}

module "ec2_bastion_host" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.5.0"

  name = "BastionHost"

  ami                    = var.aws_ec2_instance_image
  instance_type          = var.aws_ec2_instance_type
  key_name               = aws_key_pair.custom_aws_ssh_key.key_name
  vpc_security_group_ids = [module.public_bastion_security_group.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  get_password_data      = "true"

  user_data = <<-EOF
              <powershell>
              $Path = $env:TEMP
              $Installer = "chrome_installer.exe"
              Invoke-WebRequest "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path$Installer
              Start-Process -FilePath $Path$Installer -Args "/silent /install" -Verb RunAs -Wait
              Remove-Item $Path$Installer
              </powershell>
              EOF

  tags = {
    Name = "BastionHost"
  }
}

output "bastion" {
  value = aws_eip.bastion
}

// Password çekebilmek için direkt olarak baz ec2 kaynağını kullanıyoruz. Yukarıdaki işimize yaramıyor malesef.
// Bunu da Parent/Main içinde kullanıyoruz.
output "base_bastion" {
  value = module.ec2_bastion_host
}