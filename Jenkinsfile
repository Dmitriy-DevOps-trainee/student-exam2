pipeline {
  environment {
    registry = "dimitrii89/exam-images"
    registryCredential = 'dockerHub'
    dockerImage = ''
  }
  agent {
     node {
      label 'jenkins-agent' 
      }
    }
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/Dmitriy-DevOps-trainee/student-exam2.git'
      }
    }  
    stage('Application testing') {
      steps {
        sh """

        python3 -m venv venv

        . venv/bin/activate

        pip install -e .

        export FLASK_APP=js_example

        pip install coverage

        flask run &

        pip install -e '.[test]'

        coverage run -m pytest

        coverage report

        deactivate

        """
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":web-app"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push( "web-app-$BUILD_NUMBER" )
            dockerImage.push( "web-app-latest" )
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
