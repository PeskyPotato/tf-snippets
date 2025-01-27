variable "aws_region" {
  description = "AWS region for the project."
  type        = string
}

variable "project_name" {
  description = "Name of your project, this will be used to prefix resources."
  type        = string
  default     = "disruptions"
}

variable "data_bucket" {
  description = "Name of the S3 bucket, if left blank a random unique name will be assigned."
  type        = string
  default     = ""
}
