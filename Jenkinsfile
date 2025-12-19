pipeline {
    agent any

    stages {
        stage('Prepare') {
            steps {
                nodejs(nodeJSInstallationName: 'NodeJS 24') {
                    sh "npm ci"
                }
            }
        }
        stage('Test') {
            steps {
                nodejs(nodeJSInstallationName: 'NodeJS 24') {
                    sh "npm run test"
                }
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
                withCredentials([sshUserPrivateKey(credentialsId: 'docker_key', keyFileVariable: 'FILENAME', usernameVariable: 'USERNAME')]) {
                    sh 'ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -u ${USERNAME} --key-file ${FILENAME} --inventory hosts.ini playbook.yaml'
                }
            }
        }
    }
}
