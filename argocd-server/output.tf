output "random_string" {
  description = "admin password for argoccd"
  value       = random_password.random.result
}
