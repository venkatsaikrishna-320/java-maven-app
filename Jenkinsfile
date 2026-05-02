pipeline {
    agent any

    tools {
        maven "Maven3"
    }

    stages {

        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Blujaytech/java-maven-app.git'
            }
        }

        stage('Build Maven WAR') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Remove old Docker container/image') {
            steps {
                script {
                    sh '''
                        docker stop blujaytech_container || true
                        docker rm blujaytech_container || true
                        docker rmi blujaytech/javamavenapp:v1 || true
                    '''
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker') {
                        sh '''
                            docker build -t blujaytech/javamavenapp:v1 .
                            docker push blujaytech/javamavenapp:v1
                        '''
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                sh '''
                    docker run -d -p 9000:8080 --name blujaytech_container blujaytech/javamavenapp:v1
                '''
            }
        }
    }
}
