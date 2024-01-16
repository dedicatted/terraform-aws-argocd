output "random_password" {
  description = "admin password for argoccd"
  value       = random_password.random.result
}
