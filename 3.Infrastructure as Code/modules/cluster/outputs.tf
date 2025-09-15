# Output local IP
output "my_public_ip" {
  value = trimspace(data.http.my_ip.body)
}