pipeline {
    agent { label 'docker' } 

    stages{
        stage("Clone Code"){
            steps {
                echo "Cloning the code"
                git url:"https://github.com/caplearazvan/DevOps_project.git", branch: "main"
            }
        }
        stage("Build"){
            steps {
                echo "Building the image"
                sh "cd Weather-app && pwd && docker build -t jenkins_wether_app ."
            }
        }
        stage("Push to Docker Hub"){
            steps {
                echo "Push to Docker Hub"
                echo "Pushing the image to docker hub"
                withCredentials([usernamePassword(credentialsId:"dockerhub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
                  sh "docker tag jenkins_wether_app ${env.dockerHubUser}/jenkins_wether_app:latest"
                  sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                  sh "docker push ${env.dockerHubUser}/jenkins_wether_app:latest"
                }
            }
        }
        
        stage("Deploy"){
            steps {
                echo "Deploying the container"
                sh "docker run jenkins_wether_app"

            }
        }
    }
    
}
