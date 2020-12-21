
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = "Quill-Terraform-TestBed"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a"]
  public_subnets = ["10.0.1.0/24"]
  intra_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = false
}

resource "aws_eip" "website_ip" {
  instance   = aws_instance.quillTerraformServer.id
  vpc        = true
  depends_on = [module.vpc.igw_id]
}
