
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
                    call npm ci

                    set "CI=true"
                    call npm test -- --watchAll=false --passWithNoTests

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
                bat 'docker compose up -d --build'
            }
        }
    }
}
