pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="666665132412"
        AWS_DEFAULT_REGION="ap-southeast-1" 
        IMAGE_REPO_NAME_NGINX="jenkins-build-nginx"
        IMAGE_NGINX_TAG="latest"
        REPOSITORY_NGINX_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME_NGINX}"
        IMAGE_REPO_NAME_PHP="jenkins-build-php"
        IMAGE_PHP_TAG="latest"
        REPOSITORY_PHP_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME_PHP}"
    }
   
    stages {
        
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
                 
            }
        }
        
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          sh "docker-compose -f docker-compose.yml build"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{  
         script {
                sh "docker tag ${IMAGE_REPO_NAME_NGINX}:${IMAGE_NGINX_TAG} ${REPOSITORY_NGINX_URI}:$IMAGE_NGINX_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME_NGINX}:${IMAGE_NGINX_TAG}"
                sh "docker tag ${IMAGE_REPO_NAME_PHP}:${IMAGE_PHP_TAG} ${REPOSITORY_PHP_URI}:$IMAGE_PHP_TAG"
                sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME_PHP}:${IMAGE_PHP_TAG}"
         }
        }
      }
    }
}