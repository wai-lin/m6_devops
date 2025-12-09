pipeline {
    agent any

    tools {
       go "1.24.1"
    }

    stages {
        stage('Test') {
            steps {
                sh "go test ./..."
            }
        }
        stage('Build') {
            steps {
                sh "go build main.go"
            }
        }
        stage('Push Registry') {
            steps {
                sh 'docker build . --tag ttl.sh/myapp:1h'
                sh 'docker push ttl.sh/myapp:1h'
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ssh -i ${FILENAME} -o StrictHostKeyChecking=no ${USERNAME}@docker "docker pull ttl.sh/myapp:1h && docker run -d --restart always --name myapp ttl.sh/myapp:1h"'
                }
            }
        }
    }
}
