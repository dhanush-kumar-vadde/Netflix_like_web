pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "your-dockerhub-username/netflix-static"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/netflix-like-web.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f netflix-container || true
                    docker run -d -p 8888:80 --name netflix-container $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}
