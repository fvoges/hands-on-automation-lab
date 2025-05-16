output "instance_uno_id" {
  value = aws_instance.instance_uno.id
}

output "instance_dos_id" {
  value = aws_instance.instance_dos.id
}

output "instance_tres_id" {
  value = aws_instance.instance_tres.id
}

output "instance_quatro_id" {
  value = aws_instance.instance_quatro.id
}

output "instance_cinco_id" {
  value = aws_instance.instance_cinco.id
}

output "sg_uno_id" {
  value = aws_security_group.sg_uno.id
}
# ... add other SG IDs if neededcheck "name" {
output "sg_dos_id" {
  value = aws_security_group.sg_dos.id
}

output "sg_tres_id" {
  value = aws_security_group.sg_tres.id
}

output "sg_quatro_id" {
  value = aws_security_group.sg_quatro.id
}

output "sg_cinco_id" {
  value = aws_security_group.sg_cinco.id
}