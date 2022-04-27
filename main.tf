module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "ec2" {
  source     = "./modules/ec2"
  namespace  = var.namespace
  vpc        = module.networking.vpc
  sg_pub_id  = module.networking.sg_pub_id
#  sg_priv_id = module.networking.sg_priv_id
  key_name   = module.ssh-key.key_name
}


/*
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-up-and-running-statefiles"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-south-1"
    # Replace this with your DynamoDB table name!
  #  dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
*/