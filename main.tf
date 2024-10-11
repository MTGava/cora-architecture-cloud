#main.tf
#defining the provider as aws
provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    token      = "${var.session_token}"
}

# Criar um S3 bucket para armazenar imagens/audio para o Rekognition e Polly processar
resource "aws_s3_bucket" "cora_image_bucket" {
  bucket = "cora-image-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = 30
    }
  }
}