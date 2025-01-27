terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">=1.9.3"
}

provider "aws" {
  region = var.aws_region
}

# S3 bucket that will be used by Athena CSV data
resource "aws_s3_bucket" "data_bucket" {
  bucket = var.data_bucket
}

# Athena database with the query output location, a different
# bucket other than the data bucket can be selected here.
resource "aws_athena_database" "athena_database" {
  name   = "${var.project_name}_database"
  bucket = aws_s3_bucket.data_bucket.id
}

# A Glue catalog table is created since native Athena
# tables cannot be created through Terraform.
resource "aws_glue_catalog_table" "athena_table" {
  name          = "${var.project_name}_table"
  database_name = aws_athena_database.athena_database.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL                 = "TRUE"
    "skip.header.line.count" = 1
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.data_bucket.id}/input"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    ser_de_info {
      name                  = "${var.project_name}_data"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"

      parameters = {
        "serialization.format" = ","
        "field.delim"          = ","
      }
    }

    columns {
      name = "start"
      type = "timestamp"
    }

    columns {
      name = "end"
      type = "timestamp"
    }

    columns {
      name = "route"
      type = "string"
    }

    columns {
      name = "reason"
      type = "string"
    }
  }
}
 