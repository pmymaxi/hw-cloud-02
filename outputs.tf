# NETWORK VPC
output "vpc" {
  description = "VPC module output"
  value       = module.vpc.network
}
output "route_table" {
  description = "Route tables VPC"
  value       = module.vpc.route_table
}

# NETWORK LOAD BALANCER
output "network_load_balancer" {
  value = module.load_balancer.network_load_balancer
}

# APPLICATION LOAD BALANCER
output "application_load_balancer" {
  value = module.load_balancer.application_load_balancer
}