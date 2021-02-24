## Reason for  using terraforming instaed of terraform-import:
Terraform supports import command to import existing infrastructure into your Terraform state. It will find and import the specified resource into your Terraform state, 
allowing existing infrastructure to come under Terraform management without having to be initially created by Terraform.

    terraform import [options] ADDR ID
    Example: terraform import aws_instance.ubuntu-server-01 i-0421ae392a9e26277
Where:
ADDR is the address of your Terraform’s defined resource to import to.
ID is your AWS object ID.
Currently Terraform does not support to generate the resource’s code automatically. You will have to manually define them before performing the import commands. It is time consuming and might causes problem by human mistakes such as writing invalid syntax, putting wrong object id, etc. So it’s time to play with Terraforming.

## Terraforming:
Terraforming is a free and open-source tool written in Ruby. It helps you to export existing AWS resources to Terraform style (tf, tfstate).
Currently Terraforming requires Ruby 2.1 and supports Terraform v0.9.3 or higher. You can install Terraforming by gem command.

    gem install terraforming

Access Requirements
Just like Terraform, Terraforming requires access to your AWS infrastructure to be able to export the configuration. You can set the AWS credential by exporting environment variables.

    export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxx
    export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    export AWS_REGION=xx-yyyy-0
    
Or you can use ~/.aws/credentials file to manage the profiles then specify --profile <profile-name> in your terraforming commands.
    
    cat ~/.aws/credentials
    [khanh]
    aws_access_key_id = xxxxxxxxxxxxx
    aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    
Terraforming command usage
Terraforming supports to export many type of AWS resrouce. For example EC2 instances, Security Group, Route53, VPC, IAM, etc. You can see the full list of supported options by running

terraforming --help
Commands:
  terraforming alb             # ALB
  terraforming asg             # AutoScaling Group
  terraforming cwa             # CloudWatch Alarm
  terraforming dbpg            # Database Parameter Group
  terraforming dbsg            # Database Security Group
  terraforming dbsn            # Database Subnet Group
  terraforming ec2             # EC2
  terraforming ecc             # ElastiCache Cluster
  terraforming ecsn            # ElastiCache Subnet Group
  terraforming efs             # EFS File System
  terraforming eip             # EIP
  terraforming elb             # ELB
  terraforming help [COMMAND]  # Describe available commands or one specific command
  terraforming iamg            # IAM Group
  terraforming iamgm           # IAM Group Membership
  terraforming iamgp           # IAM Group Policy
  terraforming iamip           # IAM Instance Profile
  terraforming iamp            # IAM Policy
  terraforming iampa           # IAM Policy Attachment
  terraforming iamr            # IAM Role
  terraforming iamrp           # IAM Role Policy
  terraforming iamu            # IAM User
  terraforming iamup           # IAM User Policy
  terraforming igw             # Internet Gateway
  terraforming kmsa            # KMS Key Alias
  terraforming kmsk            # KMS Key
  terraforming lc              # Launch Configuration
  terraforming nacl            # Network ACL
  terraforming nat             # NAT Gateway
  terraforming nif             # Network Interface
  terraforming r53r            # Route53 Record
  terraforming r53z            # Route53 Hosted Zone
  terraforming rds             # RDS
  terraforming rs              # Redshift
  terraforming rt              # Route Table
  terraforming rta             # Route Table Association
  terraforming s3              # S3
  terraforming sg              # Security Group
  terraforming sn              # Subnet
  terraforming snss            # SNS Subscription
  terraforming snst            # SNS Topic
  terraforming sqs             # SQS
  terraforming vgw             # VPN Gateway
  terraforming vpc             # VPC

Options:
  [--merge=MERGE]                                # tfstate file to merge
  [--overwrite], [--no-overwrite]                # Overwrite existing tfstate
  [--tfstate], [--no-tfstate]                    # Generate tfstate
  [--profile=PROFILE]                            # AWS credentials profile
  [--region=REGION]                              # AWS region
  [--assume=ASSUME]                              # Role ARN to assume
  [--use-bundled-cert], [--no-use-bundled-cert]  # Use the bundled CA certificate from AWS SDK


### Export AWS resource into tf:
Following is an example of exporting existing EC2 instances

    terraforming ec2 --profile=khanh
    resource "aws_instance" "ubuntu-server-01" {
        ami                         = "ami-51a7aa2d"
        availability_zone           = "ap-southeast-1b"
        ebs_optimized               = true
        instance_type               = "m5.4xlarge"
        monitoring                  = false
        key_name                    = "khanh"
        subnet_id                   = "subnet-37eada7e"
        vpc_security_group_ids      = ["sg-0a285254743cdcc51"]
        associate_public_ip_address = true
        private_ip                  = "172.16.1.101"
        source_dest_check           = true

        root_block_device {
            volume_type           = "standard"
            volume_size           = 50
            delete_on_termination = true
        }
    }


Once you have tf code definitions above, you can just copy and paste them into your Terraform code. But you haven’t finished yet. You will also have to let Terraform know which AWS resource that code block should map to.

### Mapping Terraform tf to existing AWS resource:
Mapping can be done in two ways:

#### First Method:

       terraforming ec2 --tfstate --profile=khanh
       
#### Second Method:
Back to terrform import command, we will use it to do the mapping.

    terraform import aws_instance.ubuntu-server-01 i-0421ae392a9e26277
    
    aws_instance.ubuntu-server-01: Importing from ID "i-0421ae392a9e26277"...
    aws_instance.ubuntu-server-01: Import complete!
    Imported aws_instance (ID: i-0421ae392a9e26277)
    aws_instance.ubuntu-server-01: Refreshing state... (ID: i-0421ae392a9e26277)
    Import successful!

Note:
ubuntu-server-01 is the resource name you defined in Terraform.
i-0421ae392a9e26277 is the actual EC2 instance ID which you want to map to.

Now you can confirm the new resource definition by running terraform plan. If your Terraform does not show any changes to your AWS infrastructure, it means you imported the resource successfully.

    terraform plan
    ...
    No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between yourconfiguration and real physical resources that exist. As a result, no
actions need to be performed.
That’s all! Now you can do the same steps for other resouces such as Security Group, VPC, Subnet, etc to completely manage your AWS infrastructure under Terraform.

#### Source:
https://blog.ndk.name/import-existing-aws-infrastructure-into-terraform/
