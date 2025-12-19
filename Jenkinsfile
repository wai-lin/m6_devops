pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                nodejs(nodeJSInstallationName: 'NodeJS_24') {
                    sh "npm ci"
                }
            }
        }
        stage('Test') {
            steps {
                nodejs(nodeJSInstallationName: 'NodeJS_24') {
                    sh "npm run test"
                }
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
