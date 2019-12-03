module "aws_vpc" {
  source                        = "app.terraform.io/re-invent/vpc/aws"
  name                          = "${var.name}"
  azs                           = "${var.azs}"
  internet_gateway              = "${var.internet_gateway}"
  single_nat_gateway            = "${var.single_nat_gateway}"
  one_nat_gateway_per_az        = "${var.one_nat_gateway_per_az}"
  vpc_cidr_block                = "${var.vpc_cidr_block}"
  vpc_public_subnet_cidr_block  = "${var.vpc_public_subnet_cidr_block}"
  vpc_private_subnet_cidr_block = "${var.vpc_private_subnet_cidr_block}"
  tags                          = "${var.tags}"
}

module "aws_route53_public" {
  source           = "app.terraform.io/re-invent/route53/aws"
  public_zone_name = "${var.public_zone_name}"
  comment          = "${var.comment_public}"
}

module "aws_route53_private" {
  source            = "app.terraform.io/re-invent/route53/aws"
  private_zone_name = "${var.private_zone_name}"
  vpc_id            =  "${module.aws_vpc.vpc_id}"
  comment           = "${var.comment_private}"
}