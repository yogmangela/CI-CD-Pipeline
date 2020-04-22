node{
    stage("Git Clone"){
        git credentialsId: 'GIT_CREDENTIALS', url: 'https://github.com/yogmangela/spring-boot-mongo-docker.git'
    }
    stage("Maven Clean Build"){
        def mavenHome = tool name: "Maven-3.6.3", type: "maven"
        def mavenCMD = "${mavenHome}/bin/mvn "
        sh "${mavenCMD} clean package"
    }
    stage("Build Docker Image"){
        sh "docker build -t yogmicroservices/spring-boot-mongo ."
    }
    stage("Docker Push"){
         withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'DOCKER_HUB_CREDENTIALS')]) {
             sh "winpty docker login -it -u yogmicroservices -p {DOCKER_HUB_CREDENTIALS}"
        } 
            sh "docker push yogmicroservices/spring-boot-mongo"   
    }
    stage("Deploy Application in k8's"){
    kubernetesDeploy(
        configs:'sprintBootMongo.yml',
        kubeconfigId:'k8s_configu',
        enableConfigSubstitution: ture)     
    }
    stage("Deploy onto k8's cluster"){
        sh 'kubectl apply -f springBootMongo.yml'
    }
}