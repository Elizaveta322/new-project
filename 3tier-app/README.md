# Sample 3tier app
This repo contains code for a Node.js multi-tier application.

The application overview is as follows

```
web <=> api <=> db
```

The folders `web` and `api` respectively describe how to install and run each app.

# Requirements to Build and Deploy the Application

- The application must use a microservices architecture and run on Kubernetes.
- The Kubernetes components must be deployed using Argo CD.
- A CDN must be placed in front of the application for caching and performance.
- Infrastructure must be deployed as code using Terraform (manual `terraform apply` from terminal is acceptable).
- CDN logs must be collected and sent to S3 bucket or other storage solution.
- Any cloud provider and any VCS (e.g., GitHub, GitLab, etc.) can be used.

