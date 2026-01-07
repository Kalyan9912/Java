pipeline {
    agent any

    tools {
        jdk 'jdk-21'
        maven 'mymaven'
    }

    environment {
        IMAGE_NAME = 'kalyan123'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {

        stage("code") {
            steps {
                git branch: 'main', url: 'https://github.com/Kalyan9912/Java.git'
            }
        }

        stage("Build") {
            steps {
                sh 'java -version'
                sh 'javac -version'
                sh 'mvn -version'
                sh 'mvn clean package'
            }
        }

        stage('IMAGEBUILD') {
            steps {
                sh 'docker build -t kalyanrelangii/$IMAGE_NAME:$IMAGE_TAG .'

            }
        }

        stage('imagepush') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker-cred',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh 'docker login -u $DOCKER_USER -p $DOCKER_PASS'
                    sh 'docker push kalyanrelangii/$IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
        stage('Deploy'){
            steps{
                sh 'docker run -itd --name myapp-$BUILD_NUMBER -p $BUILD_NUMBER:8080 kalyanrelangii/$IMAGE_NAME:$IMAGE_TAG'
            }
            
        }
    }
}
