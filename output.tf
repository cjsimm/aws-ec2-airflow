output "instance_id" {
  description = "IDs of the EC2 instance"
  value       = aws_instance.app.id
}