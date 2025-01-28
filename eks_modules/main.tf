provider "aws" {
  region = "east-us-1"
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.id
     ingress = {
        from_port = 22
        to_port = 22
        protocol = tcp
     }
}

resource "aws_eks_cluster" "eks" {
  name = var.eks_name
  role_arn = ""
  vpc_config {
    subnet_ids = ["aws_subnet.sub1.id"]
    security_group_ids = aws_security_group.sg.id
  }
}

resource "aws_eks_node_group" "example" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "example"
  node_role_arn   = aws_iam_role.example.arn
  subnet_ids      = aws_subnet.sub1.id
  instance_types = [ "t3.medium" ]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}
