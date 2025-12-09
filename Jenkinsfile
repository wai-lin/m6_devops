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
                sh 'docker build . --tag registry.iximiuz.com/myapp:latest'
                // sh 'docker push registry.iximiuz.com/myapp:latest'
                // sh 'docker build . --tag ttl.sh/myapp:1h'
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ansible-playbook -u ${USERNAME} --key-file ${FILENAME} --inventory hosts.ini playbook.yaml'
                }
            }
        }
    }
}
