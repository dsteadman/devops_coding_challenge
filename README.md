# The Coding Challenge

1. Fork this repo into your own Github repository.
2. Develop a very simple RESTful API that listens on a publicly accessible HTTP endpoint for GET calls at `api/resources` and returns the `resources` from `data/ebbcarbon.yaml`. Use whatever language and framework you like - be prepared to tell us why you chose what you did.
3. Containerize this application, unless you have a good justification for why not.
4. Use the Infrastructure as Code (IaC) tool of your choice to deploy this API onto AWS. If you don't have an AWS account you can use free tier AWS resources for this test. Be prepared to tell us why you chose what you did.
5. Create a PR and tag us on that when you're done.

---
# Dan Steadman - Notes

## IaC
I'm using Terraform and leveraging the popular and very well maintained modules from the `terraform-aws-modules` namespace. They're nice in that they are quite versatile and take care of much of the boilerplate. They leave us with a clean module where we are only writing `resources` where services have to be knit together for our specific use case.
This was designed with multi-repo / Terraform Enterprise in mind. The directories `modules/` and `environments/` would typically live in their own repositories and be references via remote `source` parameters, but for the demo they are just directories. Ideally, each of the `environments` is protected by Terraform Enterprise permissions. What those would be is open to discussion based on the teams that develop and use them.

## Framework
The couple serverless frameworks I looked into felt ill-suited to this task. They either used technologies I wasn't interested in (CloudFormation) and/or took too much control of the infrastructure. In our case, I want to completely separate the responsibilities of infrastructure and app code from one another. Chalice came closest to being used (you can see in my commit history I actually implemented it quickly before backing out) because it can output Terraform. However, I have used apps that generate terraform and none of the code they output is especially useful as it has to be heavily refactored for neatness and best practices, so I went back to a simple, frameworkless Python function built on Terraform I could directly control. The only place where Infrastructure is modified from outside Terraform is by the Github Action that bumps our Lambda's `image_url` to the latest version.

## Containerization
It will be nice to have it containerized so it can be included in local development environments without having to install dependencies, as well as in orchesteration tools like docker-compose or Garden.io.  

I used the pre-built Lambda base image for this project. It's a little bloated compared to something like Alpine but I think it's an overall win as it gives us access to AWS's fast deployment of security updates and accurately simulates the native Lambda environment.   
