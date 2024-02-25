# Infrastructure using Terraform
1- Go to terraform/prod/ .
2- Deploy Terraform code using init, plan, apply.

# Setup Github actions pipeline
1- Add your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to github actions secrets.

# Deploy 
1- Push all your changes to your repo, pipeline should trigger automatically.
2- You can Access the app using the load balancer dns name using HTTP.

.......................................................

# Assumptions
1- HTTPS wasn't used as it will  cost a certificate from ACM.
2- Local terraform state file was used and was added to .gitignore file. 




