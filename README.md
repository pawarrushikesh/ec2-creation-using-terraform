# ec2-creation-using-terraform
creating a ec2 instance using terraform - private and public subnet , sg group, startup script, 1 instance in public and 2 instance in private subnet. printing output of IP

 Command to List IPs of All Instances
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].{Name:Tags[?Key=='Name']|[0].Value,PrivateIP:PrivateIpAddress,PublicIP:PublicIpAddress}" \
  --output table


 Option 1: Use terraform show
 terraform show -json | jq '.values.root_module.resources[] | select(.type=="aws_instance") | {name: .name, public_ip: .values.public_ip, private_ip: .values.private_ip}'

 
Option 2: Use terraform output
terraform output
