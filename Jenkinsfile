                    
pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo 'Source code pulled from GitHub'
            }
        }

       stage('Build & Test') {
          steps {
              bat '''
              set "PATH=C:\\Program Files\\nodejs;%PATH%"
              call npm ci
              call npm test -- --watchAll=false --passWithNoTests
              set "CI=false"
              call npm run build:uat:Horizon
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
