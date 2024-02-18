resource "random_pet" "bucket_suffix" {
  length = 5
  separator = "-"
}

module "tags" {
  source = "app.terraform.io/thelostsons/tags/aws"
  version = "0.0.2"

    tags = {
      Owner = "mybucket${random_pet.bucket_suffix.id}"
      Environment = "dev"
      Project = "myproject"
    }
}

module "s3" {
  source = "../"

  bucket = var.bucket + random_pet.bucket_suffix.id

  tags = module.tags.tags
}