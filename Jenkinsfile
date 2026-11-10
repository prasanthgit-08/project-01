                    
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Source code pulled from GitHub'
            }
        }

       stage('Check Node & Docker') {
          steps {
              bat '''
                echo Current Jenkins PATH:
                echo %PATH%

                echo Checking Windows:
                echo %SystemRoot%

                dir C:\\Windows\\System32\\where.exe
                dir "C:\\Program Files\\nodejs\\node.exe"
                dir "C:\\Program Files\\nodejs\\npm.cmd"
                dir "C:\\Users\\Prasanth\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe"
            '''
          }
      }

      stage('Check Node & Docker') {
          steps {
              bat '''
                  where node
                  node --version
                  where npm
                  npm --version
                  where docker
                  docker --version
            '''
        }
    }
        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'build/**',
                                 fingerprint: true
            }
        }

        stage('Docker Compose') {
            steps {
            bat '''
                docker --version
                docker-compose up -d --build
           '''
          }
       }
    }
}
