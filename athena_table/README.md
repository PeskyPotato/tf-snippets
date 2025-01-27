# Athena tables for CSV data 

This snippet deploys an S3 bucket, Athena database and a Glue catalogue table which can be used to query CSV data from the S3 bucket. A sample CSV file is provided to test the deployment. 

## Resources

### S3 bucket
An S3 bucket is defined to store the CSV files and to be used as the query output location for Athena. An existing S3 bucket with data can be imported instead.

### Athena database
An Athena database is defined, which can hold multiple tables. Each database must specify a query output location, the S3 bucket previously created is used for this purpose although another bucket can also be set.

### Glue Catalog table
Since Terraform is unable to create native Athena tables, a Glue catalog table is defined as part of the Athena database. Paramters for this resource should be set according to the CSV files schema. The `skip.header.line.count` is set since the sample file includes headers.

Next the Serializer/Deserializer (`ser_de_info`) parameters are set within the `storage_descriptor`. This includes the [serialization library](https://docs.aws.amazon.com/athena/latest/ug/serde-csv-choices.html), comma delimeter and expected schema of the data. Both `serliazation.format` and `field.delim` are used to set the delimeter as this what I've seen Glue crawlers automatically set when creating a similar table, I cannot find any documentation with perferences on which paramter to set.

## Inputs

## Outputs
