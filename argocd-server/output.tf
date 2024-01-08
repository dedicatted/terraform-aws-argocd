output "random_string" {
  description = "admin password for argoccd"
  value       = random_string.random.result
}
