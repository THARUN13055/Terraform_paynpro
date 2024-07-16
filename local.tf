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
  
}