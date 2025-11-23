pipeline {
    agent any

    environment {
        // Très important : on ajoute /usr/local/bin pour que Jenkins trouve docker & kubectl
        PATH = "/usr/local/bin:${env.PATH}"

        IMAGE_NAME = "nozha92/jenkins_demo_nozha"
        DOCKER_CLI_AGGREGATE_ERRORS = "1"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo "Checkout automatique du repo via Jenkins (SCM)"
                // Jenkins fait déjà le checkout automatiquement, on laisse juste un echo
            }
        }

        stage('Build') {
            steps {
                echo "Étape build (placeholder)"
                // exemple : sh 'python -m py_compile app.py'
            }
        }

        stage('Clone GitHub') {
            steps {
                echo "Code déjà cloné par Jenkins, étape surtout illustrative"
            }
        }

        stage('Tests') {
            steps {
                echo "Lancement des tests (placeholder)"
                // exemple : sh 'pytest -q'
            }
        }

        stage('Docker Build') {
            steps {
                echo "Construction de l'image Docker"
                sh "docker version"
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Docker Push') {
            steps {
                echo "Push de l'image vers Docker Hub"
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub_creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      docker push ${IMAGE_NAME}:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "Déploiement sur Kubernetes"
                sh '''
                  kubectl apply -f deployment.yaml
                  kubectl apply -f service.yaml || true
                  kubectl apply -f ingress.yaml || true
                '''
            }
        }
    }

    post {
        always {
            echo "Nettoyage : docker logout"
            sh '/usr/local/bin/docker logout || true'
        }
    }
}
