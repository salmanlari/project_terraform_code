# project_terraform_code

a)   clone github-repo  by using command "git clone <https_repo_url>".

b)   configure aws by using command "aws configure" and add aws_access_key_id & aws_secret_access_key.

c)   ensure you have a key in your region and update the key name in line 66 in main.tf file 

d)   run command "terraform init" to Initializing modules, Initializing the backend , Initializing provider plugins. 

e)   run command "terraform plan" to check resurces. 

f)   run command "terraform apply --auto-approve" to create aws infrastructure 

g)   run command "terraform destroy --auto-approve" if you want to destroy infrastructure. 
