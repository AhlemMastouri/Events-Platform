data "aws_iam_role" "lab" {
  name = "LabRole"
}
data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = data.aws_iam_role.lab.arn
  version  = "1.31"
  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "events-nodes"
  node_role_arn   = data.aws_iam_role.lab.arn
  subnet_ids      = data.aws_subnets.default.ids
  instance_types  = [var.node_instance_type]
  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 3
  }
}