resource "random_pet" "bucket_suffix" {
  length = 5
  separator = "-"
}

module "tags" {
  source = "app.terraform.io/thelostsons/tags/aws"
  version = "0.0.2"

    owner = "mybucket${random_pet.bucket_suffix.id}"
    environment = "dev"
    project = "myproject"
}

module "s3" {
  source = "./s3"

  bucket = var.bucket + random_pet.bucket_suffix.id

  tags = module.tags.tags
}