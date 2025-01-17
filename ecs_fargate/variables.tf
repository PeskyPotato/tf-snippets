variable "project_name" {
  description = "Name of your project, this will be used to prefix resources."
  type        = string
  default     = "Demo"
}
variable "aws_region" {
  description = "AWS region for the project."
  type        = string
}

variable "account_id" {
  description = "The 12-digit AWS account ID"
  type        = string
  default     = ""
  validation {
    condition     = can(regex("^\\d{12}$", var.account_id))
    error_message = "String must be a 12-digit number."
  }
}

variable "task_name" {
  description = "Name for the ECS task definition."
  type        = string
  default     = "DemoTaskDefinition"
}

variable "image_url" {
  description = "URL for the container image to be used in the task."
  type        = string
}

variable "log_group_name" {
  description = "Name for the CloudWatch Log Group created for ECS task logs, this will be prefixed by /ecs/."
  type        = string
  default     = "DemoLogGroup"
}

variable "task_count" {
  description = "Desried task count in the ECS service."
  type        = number
  default     = 1
}
