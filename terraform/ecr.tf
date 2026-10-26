resource "aws_ecr_repository" "events_app" {
  name                 = "events-app"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "events_app" {
  repository = aws_ecr_repository.events_app.name
  policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Garder les 50 dernieres images"
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 50
      }
      action = { type = "expire" }
    }]
  })
}