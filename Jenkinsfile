//Pipeline for Windows Node by Amir@Mindef v1.00

pipeline {
    agent {
        label 'jenkins-windows-agent-TLS'
    }

    environment {
       
         // GitHub Packages configuration
        GITHUB_REPOSITORY = 'amundead/jenkins-agent-winsvcrcore'  // GitHub repository (user/repo format)
        IMAGE_NAME_GITHUB = "ghcr.io/${GITHUB_REPOSITORY}"  // Full image name for GitHub Packages
         // Common tag
        TAG = 'latest'  // Tag for the Docker image
        DOCKERFILE_LOCATION = './Dockerfile'     // Dockerfile in root location './tot/lab-01/Dockerfile'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from your repository 
                git branch: 'main', url: "https://github.com/amundead/jenkins-agent-winsvcrcore.git"
            }
        }
        
        stage('Check Dockerfile Location') {
            steps {
                script {
                    // Check if the Dockerfile exists in the root location
                    if (fileExists(DOCKERFILE_LOCATION)) {
                        echo "Dockerfile found at ${DOCKERFILE_LOCATION}"
                    } else {
                        error "Dockerfile not found at ${DOCKERFILE_LOCATION}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using docker.build with --no-cache option
                    docker.build("${IMAGE_NAME_GITHUB}:${TAG}", "--no-cache -f ${DOCKERFILE_LOCATION} .")
                }
            }
        }

        stage('Tag and Push Docker Image to GitHub Packages') {
            steps {
                script {
                   
                    // Authenticate to GitHub Packages and push
                    docker.withRegistry('https://ghcr.io', 'github-credentials-amir') {
                        docker.image("${IMAGE_NAME_GITHUB}:${TAG}").push()
                    }
                }
            }
        }

        stage('Clean up') {
            steps {
                script {
                    // Remove unused Docker images to free up space
                    bat "docker rmi ${IMAGE_NAME_GITHUB}:${TAG}"
                }
            }
        }
    }

    post {
        always {
            // Clean up workspace after the pipeline
            cleanWs()
        }
    }
}
