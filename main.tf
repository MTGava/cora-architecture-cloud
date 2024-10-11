#main.tf
#defining the provider as aws
provider "aws" {
    region     = "${var.region}"
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    token      = "${var.session_token}"
}

# Cria S3 buckets para armazenar imagens (para o AWS Rekognition processar) e áudio (para a AWS Polly processar)
variable "buckets" {
  type = map(object({
    acl          = string
    versioning  = bool
    expiration_days = number
  }))
  default = {
    image = {
      acl              = "private"
      versioning      = true
      expiration_days = 30
    }
    audio = {
      acl              = "private"
      versioning      = true
      expiration_days = 30
    }
  }
}

resource "aws_s3_bucket" "cora_buckets" {
  for_each = var.buckets

  bucket = "cora-${each.key}-bucket"
  acl    = each.value.acl

  versioning {
    enabled = each.value.versioning
  }

  lifecycle_rule {
    enabled = true

    expiration {
      days = each.value.expiration_days
    }
  }
}