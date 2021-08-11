# Put in your profile name here.  It might be that you want to use the "default" profile.
# see your profiles in ~/.aws/credentials
# if you don't have credentials set in ~/.aws/credentials you can also put in 
# access_key = "...."
# secret_key = "...."
# you can also use environment variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION
# more details are found here: 
# https://www.terraform.io/docs/providers/aws/index.html
# select the region you want to perform this operation in. 
provider "aws" {
  profile = "default" 
  region = "us-west-2"
}


# The below variable is my pgp public key base64 encoded.  This is used to create the password
# and secret_key of the iam user below.  You can change this to be your own key. 
variable "pgp_key" {
  type = string
  default = "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"
}

########################################################
# Create the EKS Full Access Policy
########################################################

data "aws_iam_policy_document" "EKSFullAccess" {
  statement {
    sid = "EKSFullAccess"
    actions = [
      "eks:*",
      "ecr:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "EKSFullAccess" {
  name = "EKSFullAccess"
  path = "/"
  policy = data.aws_iam_policy_document.EKSFullAccess.json
}


########################################################
# Create the EKS Demo Group
########################################################

resource "aws_iam_group" "EKSDemoGroup" {
  name = "EKSDemoGroup"
  path = "/"
}

########################################################
# Attach AWS managed policies to the group
########################################################

resource "aws_iam_group_policy_attachment" "AmazonEC2FullAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
resource "aws_iam_group_policy_attachment" "AmazonS3FullAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_group_policy_attachment" "AmazonSNSReadOnlyAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonSNSReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "AmazonVPCFullAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}
resource "aws_iam_group_policy_attachment" "IAMReadOnlyAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}
resource "aws_iam_group_policy_attachment" "AWSCloudFormationFullAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"
}

resource "aws_iam_group_policy_attachment" "DynamoFullAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_group_policy_attachment" "EKSFullAccess" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = aws_iam_policy.EKSFullAccess.arn
}



########################################################
# Attach AWS inline policy to the group
########################################################

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iamPassRole" {
  statement {
    actions = [
      "ssm:GetParameter",
      "iam:PassRole",
      "iam:CreateServiceLinkedRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:CreateInstanceProfile",
      "iam:CreateOpenIDConnectProvider",
      "iam:DeleteOpenIDConnectProvider"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.us-west-2.amazonaws.com",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.us-west-2.amazonaws.com/*",
      "arn:aws:ssm:*"
    ]
  } 
}

resource "aws_iam_group_policy" "iamPassRole" {
  group = aws_iam_group.EKSDemoGroup.name
  name = "iamPassRole"
  policy = data.aws_iam_policy_document.iamPassRole.json
}


########################################################
# Create EKS Demo user and add to group
########################################################

resource "aws_iam_user" "eksdude" {
  name = "eksdude"
  force_destroy = "true"
}

resource "aws_iam_user_group_membership" "eksdude" {
  user = aws_iam_user.eksdude.name
  groups = [
    aws_iam_group.EKSDemoGroup.name
  ]
}

data "aws_iam_policy_document" "eksdude" {
  statement {
    actions = [
      "iam:ChangePassword",
      "iam:GetAccountPasswordPolicy"
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.eksdude.name}"
    ]
  }
}

resource "aws_iam_user_policy" "eksdude" {
  name = "ConsolePolicy"
  user = aws_iam_user.eksdude.name
  policy = data.aws_iam_policy_document.eksdude.json
  
}

resource "aws_iam_user_login_profile" "eksdude" {
  user = aws_iam_user.eksdude.name
  pgp_key = var.pgp_key
  password_length = 10

  lifecycle {
    ignore_changes = [password_length, password_reset_required, pgp_key]
  }
}

output "password" {
  value = aws_iam_user_login_profile.eksdude.encrypted_password
}

resource "aws_iam_access_key" "eksdude" {
  user = aws_iam_user.eksdude.name
  pgp_key = var.pgp_key
}

output "secret" {
  value = aws_iam_access_key.eksdude.encrypted_secret
}

output "key" {
  value = aws_iam_access_key.eksdude.id
}

########################################################
# Create EKS Service Role for Manual Kubernetes Clusters
########################################################

resource "aws_iam_role" "EKSServiceRole" {
  name = "EKSServiceRole"
  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "eks.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}

resource "aws_iam_role_policy_attachment" "EKSServiceRoleAttachmentsCluster" {
  role = aws_iam_role.EKSServiceRole.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "EKSServiceRoleAttachmentsService" {
  role = aws_iam_role.EKSServiceRole.name
  policy_arn  = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}


########################################################
# Create Cluster Autoscaling Policy
########################################################

data "aws_iam_policy_document" "EKSClusterAutoscaling" {
  statement {
    sid = "EKSClusterAutoscaling"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "EKSClusterAutoscaling" {
  name = "EKSClusterAutoscaling"
  path = "/"
  policy = data.aws_iam_policy_document.EKSClusterAutoscaling.json
}



########################################################
# Create Serverless Policy and attach to the EKSDemoGroup
########################################################

data "aws_iam_policy_document" "Serverless" {
  statement {
    sid = "Serverless"
    actions = [
      "apigateway:*",
      "logs:*",
      "lambda:*"
    ]
    resources = [
      "*"
    ]
  }
}
resource "aws_iam_policy" "Serverless" {
  name = "Serverless"
  path = "/"
  policy = data.aws_iam_policy_document.Serverless.json
}

resource "aws_iam_group_policy_attachment" "EKSDemoGroupServerless" {
  group = aws_iam_group.EKSDemoGroup.name
  policy_arn  = aws_iam_policy.Serverless.arn
}


########################################################
# Create KubeLambda Role and attach Policies
########################################################

resource "aws_iam_role" "kubeLambda" {
  name = "kubeLambda"
  description = "Allows Lambda functions to make kubernetes calls on our cluster."
  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
    }
EOF
}


resource "aws_iam_role_policy_attachment" "kubeLambdaEKSFullAccess" {
  role = aws_iam_role.kubeLambda.name
  policy_arn  = aws_iam_policy.EKSFullAccess.arn
}

resource "aws_iam_role_policy_attachment" "kubeLambdaServerless" {
  role = aws_iam_role.kubeLambda.name
  policy_arn  = aws_iam_policy.Serverless.arn
}

resource "aws_iam_role_policy_attachment" "kubeLambdaLambda" {
  role = aws_iam_role.kubeLambda.name
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

########################################################
# Add Dynamo Role 
########################################################


