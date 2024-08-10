pipeline {
  agent {
    docker { image 'hatilima/arm_toolchain:latest' }
  }
    stages {
        stage('Prepare Env') {
            steps {
                echo 'Hello world!' 
            }
        }
        stage('Unit Testing') {
            steps {
                sh 'ls -a'
            }
        }
        stage('Build') {
            steps {
                sh 'arm-none-eabi-gcc --version'
                sh 'make'
            }
        }
        stage('Integration Testing') {
            steps {
                sh 'ls -a' 
            }
        }
        stage('Archiving') {
            steps {
                echo 'Hello world!' 
            }
        }
    }
}