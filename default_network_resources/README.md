# AWS default network resources

This snippet retrieves default network resources from an AWS region in an account. This includes the default VPC, subnets, internet gateway and security group. Pass a region for the `aws_region` variable to return its network resources when running `terraform plan`.

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.default_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/internet_gateway) | data source |
| [aws_security_group.default_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_subnets.default_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

### VPC
The default VPC is retrieved using the [`aws_vpc` data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) and the default argument. This the defaulkt VPC ID will be used to retrieve all other default network resources.

```hcl
data "aws_vpc" "default_vpc" {
  default = true
}
```

### Subnets
The [`aws_subnet` data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) retrieves subnets which are filtered by the default VPC ID returning a list of default subnets.

```hcl
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}
```

### Security groups
With the default VPC ID the [`aws_security_group` data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) and the `vpc_id` and `name` arguments can be used to get the default security group.

```hcl
data "aws_security_group" "default_security_group" {
  vpc_id = data.aws_vpc.default_vpc.id
  name   = "default"
}
```
### Internet gateway
By filtering the [`aws_internet_gateway` data source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/internet_gateway) with the VPC ID the default internet gateway can be retrieved.

```hcl
data "aws_internet_gateway" "default_internet_gateway" {
  filter {
    name   = "attachment.vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to retrieve network resources from. | `string` | `"eu-central-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_internet_gatway_id"></a> [default\_internet\_gatway\_id](#output\_default\_internet\_gatway\_id) | n/a |
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | n/a |
| <a name="output_default_subnet_ids"></a> [default\_subnet\_ids](#output\_default\_subnet\_ids) | n/a |
| <a name="output_default_vpc_id"></a> [default\_vpc\_id](#output\_default\_vpc\_id) | n/a |
