node {
    def app

    properties([
            disableConcurrentBuilds(),
            buildDiscarder(logRotator(numToKeepStr: '1'))
    ])

    stage('Clone repository') {
        checkout scm
    }
    stage('Test repository') {
         env.NODE_ENV = "test"
         print "Environment will be : ${env.NODE_ENV}"
         sh 'node -v'
         sh 'npm prune'
         sh 'npm install'
         sh 'npm test &'
    }

    stage('Build image') {
        app = docker.build("dockerbuildapp/test")
    }

    stage('Test image') {
         /*test*/
    }

    stage('Push image') {
      docker.withRegistry('http://registry.hub.docker.com/', 'docker-hub-credentials') {
      app.push("${env.BUILD_NUMBER}")
      app.push("latest")
   }
    }

    stage('Deployment'){
        echo 'locally deploy docker to kubernetes'
        sh'/usr/bin/kubectl apply -f deployment.yaml'
        sh'/usr/bin/kubectl describe pods'
    }

    stage('Cleanup'){
      echo 'prune and cleanup'
      sh 'npm prune'
      sh 'rm node_modules -rf'

    }
}
