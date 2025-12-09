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
        stage('Deploy') {
            steps {
                sh 'docker build . --tag myapp'
                // withCredentials([sshUserPrivateKey(credentialsId: 'mykey', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                // }
            }
        }
    }
}
