pipeline {
    agent any

    tools {
       nodejs "NodeJS_24"
    }

    stages {
        stage('Prepare') {
            steps {
                sh "npm ci"
            }
        }
        stage('Test') {
            steps {
                sh "npm run test"
            }
        }
        stage('Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'target_key', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ansible-playbook -u ${USERNAME} --key-file ${FILENAME} --inventory hosts.ini playbook.yaml'
                }
            }
        }
    }
}
