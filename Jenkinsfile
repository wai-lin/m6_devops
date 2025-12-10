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
                sh 'docker build . --tag ttl.sh/app_aung:1h'
                sh 'docker push ttl.sh/app_aung:1h'
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh "ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker 'sudo systemctl restart docker'"
                    sh "ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker 'docker stop myapp || true'"
                    sh "ssh -o StrictHostKeyChecking=no -i ${FILENAME} ${USERNAME}@docker 'docker rm myapp || true'"
                    sh 'ssh -i ${FILENAME} -o StrictHostKeyChecking=no ${USERNAME}@docker "docker pull ttl.sh/app_aung:1h && docker run -d --restart always -p 4444:4444 --name myapp ttl.sh/app_aung:1h"'
                }
            }
        }
    }
}
