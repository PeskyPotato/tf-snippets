# ECS using Fargate

This snippet deploys ECS on Fargate using an existing image and the default network resources in an AWS region.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.ecs_task_definition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.ecs_task_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ecs_execution_iam_attachement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task_iam_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.default_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

### ECS task role

A sample [ECS task IAM role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html) is created with a policy. This role is assumed by the containers in a task to access AWS resources, and is an optional parameter. In this demo the policy allows the containers to list objects in an S3 bucket.

### ECS task execution role

A sample [ECS task execution role](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html) is create with `AWSECSTaskExecutionRolePolicy` AWS managed policy. This role is assumed by the agent to setup tasks, and is an optional parameter. The AWS managed policy allows the agent to authenticate and pull ECR images, create a CloudWatch log stream and put log events.

### ECS task definition

An [ECS task definition](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html) is defined which contains the requirements of a task. The JSON contains information such as CPU, memory and CPU architecture requirements, mount points, port mappings and more. Apart from the JSON file, other parameters such as `cpu`, `network_mode`, `runtime_platform` and other arguments are passed including the IAM roles previously created. Some these arguemtns are required if using Fargate, these are described in the [Terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition).

### ECS cluster

An [ECS cluster](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html) which groups deployed tasks and services.

### ECS service

An [ECS service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html) defines instances of the tasks including health checks and replacements. The service is defined with a desired count, network configuration with the default subnets and security groups among other arguments.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | The 12-digit AWS account ID | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region for the project. | `string` | n/a | yes |
| <a name="input_image_url"></a> [image\_url](#input\_image\_url) | URL for the container image to be used in the task. | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | Name for the CloudWatch Log Group created for ECS task logs, this will be prefixed by /ecs/. | `string` | `"DemoLogGroup"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of your project, this will be used to prefix resources. | `string` | `"Demo"` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | Desried task count in the ECS service. | `number` | `1` | no |
| <a name="input_task_name"></a> [task\_name](#input\_task\_name) | Name for the ECS task definition. | `string` | `"DemoTaskDefinition"` | no |
