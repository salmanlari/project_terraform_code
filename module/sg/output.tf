output "sg_output_id" {
    value={for k , v in aws_security_group.sg: k => v.id}  
}