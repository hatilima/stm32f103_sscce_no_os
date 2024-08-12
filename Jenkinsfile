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
                echo 'Some CMakeLists.txt GoogleTest/GoogleMock stuff'
                sh 'make clean'
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
                echo 'Some openocd/st-flash and PyTest stuff'
            }
        }
        stage('Archiving') {
            steps {
                rtUpload (
                    serverId: 'jfrog_server_01',
                    spec: '''{
                        "files": [
                            {
                            "pattern": "*.bin",
                            "target": "generic-local/"
                            }
                        ]
                    }''',

                    // Optional - Associate the uploaded files with the following custom build name and build number,
                    // as build artifacts.
                    // If not set, the files will be associated with the default build name and build number (i.e the 
                    // the Jenkins job name and number).
                    buildName: 'holyFrog',
                    buildNumber: '42',
                    // Optional - Only if this build is associated with a project in Artifactory, set the project key as follows.
                    project: 'my-project-key'
                ) 
            }
        }
        stage('Publishing Build Info') {
            steps {
                rtPublishBuildInfo(
                    serverId: "jfrog_server_01"
                )
            }
        }
    }
}