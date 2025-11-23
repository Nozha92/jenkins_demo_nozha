pipeline {
    agent any

    environment {
        // Pour que Jenkins trouve docker et kubectl
        PATH = "/usr/local/bin:${env.PATH}"
        IMAGE_NAME = "nozha92/jenkins_demo_nozha"
        DOCKER_CLI_AGGREGATE_ERRORS = "1"
    }

    stages {
        stage('Checkout du projet') {
            steps {
                echo "📥 Checkout depuis GitHub"
                checkout scm
            }
        }

        stage('Build Docker image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub_creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }

        stage('Push image') {
            steps {
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }

        stage('Deploiement sur Kubernetes') {
            steps {
                sh """
                kubectl apply -f deployment.yaml
                kubectl rollout status deployment/mon-deployment
                """
            }
        }
    }

    post {
        always {
            echo "Nettoyage : logout Docker (si connecté)"
            sh "/usr/local/bin/docker logout || true"
        }
    }
}
