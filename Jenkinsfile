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
                echo 'Hello world!' 
            }
        }
        stage('Build') {
            steps {
                sh 'arm-none-eabi-gcc --version'
            }
        }
        stage('Integration Testing') {
            steps {
                echo 'Hello world!' 
            }
        }
        stage('Archiving') {
            steps {
                echo 'Hello world!' 
            }
        }
    }
}