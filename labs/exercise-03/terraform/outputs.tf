# output "all_instance_details" {
#   description = "Details of all created EC2 instances."
#   value = {
#     for k, inst in module.ec2_instances : k => {
#       instance_id = inst.instance_id
#       public_ip   = inst.public_ip
#       private_ip  = inst.private_ip
#       sg_id       = inst.security_group_id
#       ami_id_used = inst.ami_id_used
#     }
#   }
# }

# output "instance_uno_compute_id" {
#   value       = module.ec2_instances["instance_uno_compute"].instance_id
#   description = "ID of instance_uno_compute"
# }

# output "application_server_dos_sg_id" {
#   value       = module.ec2_instances["application_server_dos"].security_group_id
#   description = "Security Group ID for application_server_dos"
# }
