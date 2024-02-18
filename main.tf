resource "random_pet" "bucket_suffix" {
  length = 5
  separator = "-"
}

module "tags" {
  source = "app.terraform.io/thelostsons/tags/aws"
  version = "0.0.3"

    owner = "mybucket${random_pet.bucket_suffix.id}"
    environment = "dev"
    project = "myproject"
}

module "s3" {
  source = "app.terraform.io/thelostsons/s3/aws"
  version = "0.0.4"

  bucket = "${var.bucket}${random_pet.bucket_suffix.id}"

  tags = module.tags.tags
}