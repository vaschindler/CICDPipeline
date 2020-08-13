# CICDPipeline

- Jenkins is locally installed and running
- The Pipeline job was created in Jenkins with Pipeline script from SCM and a repository url to the git repository
- The Jenkinsfile is a scripted Pipeline
- Kubernetes is deployed locally with minikube and deployment.yaml
- The Secret, which Kubernetes needs to access the private docker image on docker hub is in my-secret.yaml
- The Secret is provided on the command line for kubectl

1. The Repository is cloned and Jenkins reads the Jenkinsfile in
2. The node programm is tested
3. The image is build with the tag for dockerhub
4. The image is pushed to a private docker hub
5. Jenkins executes locally kubectl and creates the pod as described in deployment.yaml
6. The Workspace is cleaned up

On localhost:3000 the deployed kubernetes pod shows a Hello World message
