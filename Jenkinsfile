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
        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'k8key', serverUrl: 'https://kubernetes:6443']) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
}
