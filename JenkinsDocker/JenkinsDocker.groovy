node{
    def buildNumber = BUILD_NUMBER
    stage("Git clone"){
        git url: 'https://github.com/MithunTechnologiesDevOps/java-web-app-docker.git', branch:'master'
    }
    stage("Maven Clean Package"){
    def mavenHome tool name: "Maven",type:"maven"
    sh "${mavenHome}/bin/mvn clean package"
    }
    stage("Build Docker Image"){
    sh "docker build -t yogmicroservices/java-web-app-docker:${buildNumber} ."
    }

    stage("Docker login and Push"){
        withCredentials([string(credentialsId: 'DOCKER_HUB_PWD', variable: 'DOCKER_HUB_PWD')]) {
             sh "docker login -u yogmicroservices -p ${DOCKER_HUB_PWD}" 
        }
        sh "docker push yogmicroservices/java-web-app-docker:${buildNumber}"
    }
    stage("Deploy Application on Deployment server"){
        sshagent(['DOCKER_DEV_SSH'])
        sh "ssh -o StrictHostKeyChecking=no ubuntu@<<private-ip-of-deployment-server>> docker rm -f web_container || true"
        sh "-o StrictHostKeyChecking=no ubuntu@<<private-ip-of-deployment-server>> docker run -d -p 8080:8080 --name web_container yogmicroservices/java-web-app-docker:${buildNumber}"
    }



}