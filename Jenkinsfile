pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "dhanush541/netflix-static"  // your Docker Hub repo name
    }

    stages {
        stage('Build Docker Image') {
            steps {
                echo "🚀 Building Docker image..."
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "🔑 Logging into Docker Hub & pushing image..."
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',  // must match the credentials ID in Jenkins
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo "🚢 Deploying container..."
                sh '''
                    docker rm -f netflix-container || true
                    docker run -d -p 8888:80 --name netflix-container $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}
