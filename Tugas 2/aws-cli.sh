#!/bin/bash

aws configure

aws ec2 create-security-group --group-name aws-cli-security --description "security group for aws cli"

aws ec2 create-key-pair --key-name aws-cli

# The Amazon Machine Image (AMI) ID that you want to use for the instance.
# ami-0588c11374527e516
# The instance type you want to launch (e.g., t2.micro).
# t2.micro
# The key pair name for SSH access to the instance.
# aws-cli
# The security group ID to apply to the instance.
# sg-0c3e6a3d7c5f56dce
# The subnet ID where you want to launch the instance.
# subnet-0302ac7a9ca64db72
aws ec2 run-instances \
  --image-id ami-0588c11374527e516 \
  --instance-type t2.micro \
  --key-name aws-cli \
  --security-group-ids sg-0c3e6a3d7c5f56dce \
  --subnet-id subnet-0302ac7a9ca64db72

aws ec2 create-volume --availability-zone ap-southeast-1b --size 2

aws ec2 attach-volume --instance-id i-08954fc1693059720 --volume-id vol-047e984006f3d2d7b --device /dev/xvdh