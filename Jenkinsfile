node {
    def app
    
    properties([
            disableConcurrentBuilds(),
            buildDiscarder(logRotator(numToKeepStr: '0'))
    ])

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("dockerbuildapp/test")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

         env.NODE_ENV = "test"

         print "Environment will be : ${env.NODE_ENV}"

         sh 'node -v'
         sh 'npm prune'
         sh 'npm install'
         sh 'npm test'
    }

    stage('Push image') {
      docker.withRegistry('http://registry.hub.docker.com/', 'docker-hub-credentials') {
      app.push()
   
          
        
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
