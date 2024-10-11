#main.tf
#defining the provider as aws
provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    token      = "${var.session_token}"
}

# Cria um S3 bucket para armazenar imagens para o AWS Rekognition processar
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

# Cria um S3 bucket para armazenar audio para a AWS Polly processar
resource "aws_s3_bucket" "cora_audio_bucket" {
  bucket = "cora-audio-bucket"
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