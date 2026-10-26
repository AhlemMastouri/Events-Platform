output "ecr_url" {
  value = aws_ecr_repository.events_app.repository_url
}
output "cluster_name" {
  value = aws_eks_cluster.this.name
}