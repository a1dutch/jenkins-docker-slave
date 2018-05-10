@Library('pipeline@master') _

pipeline {
  agent { label 'docker' }
  options {
    skipDefaultCheckout()
    disableConcurrentBuilds()
    timeout(time: 1, unit: 'HOURS')
  }
  parameters {
    string(defaultValue: "a1dutch", description: '', name: 'REPOSITORY')
    string(defaultValue: "", description: '', name: 'VERSION')
  }
  environment {
    ARTIFACT="jenkins-docker-slave"
  }
  stages {
    stage('Checkout') {
      steps {
        checkout(scm)
      }
    }
    stage('Docker Build') {
      steps {
        script {
          dockerBuild(repository: REPOSITORY, artifact: ARTIFACT, version: VERSION)
        }
      }
    }
  }
}
