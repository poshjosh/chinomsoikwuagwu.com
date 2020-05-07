# @todo sync aws_region variable with packer .json
# @todo sync instance_type variable with packer .json
# @todo sync instance_name variable with packer .json
variable "aws_region" {
    description = "The AWS region"
    type        = string
    default     = "us-east-2"
}

variable "instance_type" {
    type        = string
    default     = "t2.micro"
}

variable "security_group_name" {
    description = "The name of the associated resource as will be displayed on AWS"
    type        = string
    default     = "aws_sec_grp_incoming_custom_and_ssh-linux-docker"
}

variable "instance_name" {
    description = "The name of the instance as will be displayed on AWS"
    type        = string
    default     = "awslinux-dockerce-jenkins-sonarqube_1"
}

variable "server_port" {
    description = "The port the jenkins server will use for HTTP requests"
    type        = number
    default     = 8080
}

variable "sonarqube_port" {
    description = "The port the sonarqube server will use for HTTP requests"
    type        = number
    default     = 9000
}

provider "aws" {
    # profile refers to the user profile we are using to connect to AWS
    # It is available after installing AWS CLI and running command aws configure
    profile = "default"
    region  = var.aws_region
}

resource "aws_security_group" "security_group_1" {
    name        = var.security_group_name
    description = "security group that allows all egress traffic, ingress for ssh 22 and tcp 8080, 9000"

    # Terraform removes the default rule
    egress {
      description = "All outgoing to anywhere"
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow tcp jenkins port"
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow tcp sonarqube port"
        from_port   = var.sonarqube_port
        to_port     = var.sonarqube_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow http"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow tls (https) from anywhere"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        # The actual name that will be displayed on AWS
        Name   = var.security_group_name
        Tool   = "Terraform"
        Author = "ChinomsoIkwuagwu"
    }
}

# name refers to ami_name in packer .json file
# Which should have been created by packer before applying this config
data "aws_ami" "ami_1" {
    most_recent = true
    owners      = ["self"]
    filter {
        name   = "name"
        values = ["awslinux-dockerce-jenkins-sonarqube*"]
    }
}

resource "aws_instance" "instance_1" {
    ami           = data.aws_ami.ami_1.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.security_group_1.id]

    user_data = file("user-data.txt")

    tags = {
        # The actual name that will be displayed on AWS
        Name       = var.instance_name
        Tool       = "Terraform"
        OS_version = "amazon linux 2"
        Author = "ChinomsoIkwuagwu"
    }
}

resource "aws_eip" "ip" {
    vpc      = true
    instance = aws_instance.instance_1.id
}

/**
 * Output variables show up in the console after you run terraform apply
 * command. Users of the terraform code may find this usesful. For example,
 * in this case after deploying a web server, we need an ip address to
 * use in accessing that server
 */
output "Public_ip" {
    value       = aws_instance.instance_1.public_ip
    description = "The public IP of the web server"
}

output "Jenkins_security_group_ID" {
    value = aws_security_group.security_group_1.id
}
