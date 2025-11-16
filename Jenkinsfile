pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo "Étape Build OK"
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
                echo "Étape Tests : exécution d'un script Python"
                sh """
                    python3 -c "print('Tests Python OK ✓')"
                """
            }
        }

        stage('Docker Build') {
            steps {
                sh """
                    echo "Construction de l'image Docker"
                    docker build -t jenkins_demo_nozha:latest .
                """
            }
        }

        stage('Docker Run') {
            steps {
                sh """
                    echo "Lancement du conteneur Docker"
                    docker run --rm jenkins_demo_nozha:latest
                """
            }
        }

    }

    post {
        always {
            echo "Pipeline terminé ✓"
        }
    }
}
