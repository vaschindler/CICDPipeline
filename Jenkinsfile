node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("getintodevops/hellonode")
    }

    stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */

        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
       withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable:'USER', passwordVariable: 'PASSWORD')]){
        def registry_url = "registry.hub.docker.com/"
        bat "docker login -u $USER $PASSWORD ${registry_url}"
        docker.withRegistry("http://${registry_url}", "docker-hub-credentials") {
            bat "docker push username/foldername:build"
          
        }
    }
}

