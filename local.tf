locals {
  tags = {
    "Environment" = "test",
    "Project"     = "paynpro"
    "CreatedBy"   = "Tharun"
  }
  subnet_map = {
    "10.0.1.0/24" = "us-east-1a", #public subnet webserver
    "10.0.2.0/24" = "us-east-1b", #public subnet webserver
    "10.0.3.0/24" = "us-east-1a", #private subnet appserver
    "10.0.4.0/24" = "us-east-1b", #private subnet appserver
    "10.0.5.0/24" = "us-east-1a", #private subnet db
    "10.0.6.0/24" = "us-east-1b", #private subnet db
  }
  certificate_arn = "arn:aws:acm:ap-south-1:058264519347:certificate/6cfeb000-2d2f-4038-9055-38815bd2f92f"
}