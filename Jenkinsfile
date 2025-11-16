pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo "Étape Build OK ✓"
            }
        }

        stage('Clone GitHub') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Nozha92/jenkins_demo_nozha.git'
            }
        }

        stage('Tests') {
            steps {
                sh '''
                  echo "Étape Tests : exécution d'un script Python"
                  python3 -c "print('Tests Python OK ✓')"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                  echo "Construction de l'image Docker"
                  docker build -t nozha92/jenkins_demo_nozha:latest .
                '''
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                      echo "Connexion à Docker Hub…"
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                      echo "Push de l'image sur Docker Hub…"
                      docker push nozha92/jenkins_demo_nozha:latest

                      docker logout
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                  set -e

                  APP_NAME=jenkins_demo_nozha_app
                  IMAGE_NAME=nozha92/jenkins_demo_nozha:latest
                  HOST_PORT=5002        # port sur ton Mac
                  CONTAINER_PORT=5000   # port dans le conteneur

                  echo "🛑 Stop & remove éventuel conteneur ${APP_NAME}…"
                  OLD_ID=$(docker ps -aq -f name="^${APP_NAME}$" || true)
                  if [ -n "$OLD_ID" ]; then
                    echo "Conteneur existant trouvé : $OLD_ID → stop & rm"
                    docker stop "$OLD_ID" || true
                    docker rm "$OLD_ID" || true
                  else
                    echo "Aucun conteneur existant"
                  fi

                  echo "⬇️ Pull de la dernière image ${IMAGE_NAME}…"
                  docker pull "$IMAGE_NAME"

                  echo "🚀 Lancement du nouveau conteneur sur le port ${HOST_PORT}…"
                  docker run -d --name "$APP_NAME" -p ${HOST_PORT}:${CONTAINER_PORT} "$IMAGE_NAME"

                  echo "✅ Deployment DONE → ouvre http://localhost:${HOST_PORT}"
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé ✔"
        }
    }
}
