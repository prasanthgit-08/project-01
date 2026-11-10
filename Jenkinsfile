                    
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
                  echo Checking Node.js:
                  where node
                  node --version

                 echo Checking npm:
                  where npm
                  npm --version

                  echo Checking Docker:
                  where docker
                  docker --version
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
