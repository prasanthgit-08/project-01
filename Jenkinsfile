                    
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Source code pulled from GitHub'
            }
        }

        stage('Check Jenkins Account') {
            steps {
            bat '''
            echo Username:
            echo %USERNAME%

            echo User Domain:
            echo %USERDOMAIN%

            echo User Profile:
            echo %USERPROFILE%

            echo Windows Identity:
            C:\\Windows\\System32\\whoami.exe

            echo Node:
            "C:\\Program Files\\nodejs\\node.exe" --version

            echo Docker:
            "C:\\Users\\Prasanth\\AppData\\Local\\Programs\\DockerDesktop\\resources\\bin\\docker.exe" --version
        '''
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

          stage('Build & Test') {
              steps {
                  bat '''
                    call npm ci
                    call npm test -- --watchAll=false --passWithNoTests
                    set "CI=false"
                    call npm run build:uat:Horizon
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
