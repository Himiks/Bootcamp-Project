resource "aws_eks_cluster" "eks" {
  name     = "my-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  }
}

resource "aws_launch_template" "eks_worker_template" {
  name_prefix   = "eks-worker-"
  image_id      = "ami-09a9858973b288bdd"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.eks_worker_sg.id]

}



resource "aws_autoscaling_group" "eks_workers" {
  min_size     = 1
  max_size     = 2
  desired_capacity = 1
  vpc_zone_identifier = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  launch_template {
    id      = aws_launch_template.eks_worker_template.id
    version = "$Latest"
  }

}


resource "aws_security_group" "eks_worker_sg" {
  name        = "eks-worker-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

