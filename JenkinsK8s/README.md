# CI/CD pipeline project

### Step 1 : Install Jenkins
follow [Jenkins installation here](https://github.com/yogmangela/jenkins)

### Step 2 : Install Docker on  Jenkins server

#### Step 2.1: Update the installed packages and package cache on your instance.
```
sudo yum update -y
```
#### Step 2.2: Install the most recent Docker Community Edition package.
```
sudo amazon-linux-extras install docker
```
#### Step 2.3: Start the Docker service.
```
sudo service docker start
```
#### Step 2.4: Add the ec2-user and jenkins to the docker group so you can execute Docker commands without using sudo.
```
sudo usermod -a -G docker ec2-user
```

```
sudo usermod -a -G docker jenkins
```
``
Log out and log back in again to pick up the new docker group permissions. You can accomplish this by closing your current SSH terminal window and reconnecting to your instance in a new one. Your new SSH session will have the appropriate docker group permissions.
``
#### Step 2.5: Verify that the ec2-user can run Docker commands without sudo.

```
docker info
```

#### Step 2.5: Restarting Jenkins
```
sudo systemctl restart jenkins
```

### Step 3 : Install K8's Cluster:
Requirements for Master and Workernode

Master :
Worker-node:

| Machine type         | RAM           | CPU    |
| ------------- |:-------------:| -----: |
| Master        | 2GB           | 2 core processer |
| Worker-node   | 1GB           | 1 core processer |

#### Step 3.1 create one master + two worker-nodes

- [follow steps to install docker](https://github.com/yogmangela/K8s/blob/master/DockerInstallation.md)

- [follow steps to install K8's](https://github.com/yogmangela/K8s/blob/master/K8_installation.md)

#### Step 3.2 Bootstrap K8's All machines Master+Worker-nodes
``
so You don't have to restart K8's 
`` 
```
sudo -i
systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service
```

[make sure to follow step1 - step4 here](https://github.com/yogmangela/K8s/blob/master/K8_installation.md) then follwo below:

** if you ever loose token here is the command to retrive it back:
```
 kubeadm token create --print-join-command
 ```

========================================================
RUN below commands on MASTER nodes
========================================================

#### Step 3.3 To start using your cluster, you need to run the following as a regular user on MASTER node:
  - switch to regualr user:
```
  su ubuntu
```

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

- check to see nodes created: Master machine <not ready>
```
kubectl get nodes
```

- check to see namespace created: 
```
kubectl get pods --all-namespaces
```

``
all components of K8's are up and running except network.
``

#### Step 3.4 You should now deploy a pod network to the cluster.
Run 
```
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" 
```
- now see weave-net creted:
```
ubuntu@ip-172-31-22-158:~$ kubectl get pods --all-namespaces
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
kube-system   coredns-66bff467f8-dx7ls                   1/1     Running   0          19h
kube-system   coredns-66bff467f8-pqmxc                   1/1     Running   0          19h
kube-system   etcd-ip-172-31-22-158                      1/1     Running   1          19h
kube-system   kube-apiserver-ip-172-31-22-158            1/1     Running   1          19h
kube-system   kube-controller-manager-ip-172-31-22-158   1/1     Running   1          19h
kube-system   kube-proxy-f6vfj                           1/1     Running   1          19h
kube-system   kube-scheduler-ip-172-31-22-158            1/1     Running   1          19h
kube-system   weave-net-jxm66                            2/2     Running   0          43s
ubuntu@ip-172-31-22-158:~$
```
- now your master machine should also be ready:
```
ubuntu@ip-172-31-22-158:~$ kubectl get nodes
NAME               STATUS   ROLES    AGE   VERSION
ip-172-31-22-158   Ready    master   19h   v1.18.2
ubuntu@ip-172-31-22-158:~$
```


==========================================================
Run Below commands on Worker nodes
==========================================================
#### Step 3.4: RUN kubectl token join command on all Worker-nodes

```
ubuntu@ip-172-31-17-106:~$ sudo kubeadm join 172.31.22.158:6443 --token y03amb.qxkq6mfmtvzgqh4m --discovery-token-ca-cert-hash sha256:c24c6c2c3511f2c1e7ffd66f392fceee6c5aebb1a03d9dd3f3f7230b4ccec5d0
W0421 12:51:15.106031   12937 join.go:346] [preflight] WARNING: JoinControlPane.controlPlane settings will be ignored when control-plane flag is not set.
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.18" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...

This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the control-plane to see this node join the cluster.

ubuntu@ip-172-31-17-106:~$
```
- now you should be able to see all nodes
```
ubuntu@ip-172-31-22-158:~$ kubectl get nodes
NAME               STATUS     ROLES    AGE     VERSION
ip-172-31-17-106   Ready      <none>   3m49s   v1.18.2
ip-172-31-22-158   Ready      master   19h     v1.18.2
ip-172-31-29-44    NotReady   <none>   16s     v1.18.2
ubuntu@ip-172-31-22-158:~$
```
#### Step 3.5: Make sure you have opened specific PORTS on Master and Worker-nodes >> Security-Groups
``for all the PORTS are open for this demo.`` ALL  

### Step 4: Setup Jenkins Server to deploy app on K8's Cluster
### Step 4.1 : create simple job in Jenkins >> 
- Use [k8's.groovy](k8's.groovy)
- add your Git account credentials by
    - pipeline >> click on ``Pipeline Syntax`` under : Sample Step: git: Git >>
    Click add button >> jenkins >> usr/pwd >>
    add ID ``GIT_CREDENTIAL`` and click add >>
    will genereate Groovy command something like :
    ```
    git credentialsId: 'GIT_CREDENTIALS', url: 'https://github.com/yogmangela/spring-boot-mongo-docker.git'
    ```

- use pipeline script and add

```
node{
    stage("Git Clone"){
        git credentialsId: 'GIT_CREDENTIALS', url: 'https://github.com/yogmangela/spring-boot-mongo-docker.git'
    }
}
```
### Step 4.1 Build code using Maven
- Go to GlobleTool  Configuration>> Maven >> Add Maven>>
>> check ``install automatcally`` >> provide name

### Quick note: I was getting below error when cloning repo.

```
ERROR: Error cloning remote repo 'origin'
hudson.plugins.git.GitException: Could not init /var/lib/jenkins/workspace/pipeline-script-demo
```
### How did i resolve:
- Problem was it was not locating where GIT was installed on Jenkins Server 

- Running `` whereis git`` will give you location as below:

```
[root@ip-172-31-34-194 ~]# whereis git
git: /usr/bin/git /usr/share/man/man1/git.1.gz
[root@ip-172-31-34-194 ~]#
```
then i added ``/usr/bin/git`` under Jenkins >> Global Tool Configuration >> Git >> Path to Git executable ``/usr/bin/git``

then run the job. It should work ok.

### Step 5: Build & Deploy Docker App from Jenkins in K8's cluster using pipeline-script. 

### Step 5.1: There are two way you can deploy k8's using Jenkins:

### 5.1.1. Kube-configue 
    Install "Kubernetes Continues Deploy" plugin 
    add k8'credential>> Jenkins>> Credentials>>
    add id: k8s_configu
    Kind: Kube Config:Enter directly >> 
    copy kube configue content:

- go to K8's master:
```
ls .kube
cat .kube/config
```
copy content and paste into ``enter directly``

### Step 5.1.2: edit groovy script. Add a stage

    stage("Deploy Application in k8's"){
    kubernetesDeploy(
        configs:'sprintBootMongo.yml',
        kubeconfigId:'k8s_configu',
        enableConfigSubstitution: ture
    )    
}

and click ``apply`` and ``save``

got to K8's Master and check pods runing ``kubectl get pods``

no pods runing

got back to jenkins job and build the job.

It should be successful

go to k8's-master and check pods ``kubectl get pods`` tow pods
``kubectl get svc`` two service

jenkins >> downloaded the code>> compile code>>created docker image>> pushed to repository dockerhub >> connected to k8's cluster>> deployed the application.

- so to access application use node-port 
something like : 
```
8080:31574/TCP
```
- <<node-ip>>:<<node-port>>
- 65.241.874.214:31574

you sould see application up and running.

## 5.2 : Install Kubectl on jenkins server

### 5.2.1 install kubectl
 ```
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

sudo apt-get install -y kubectl
```
### 5.2.2 add .kube/config file

- switch too jenkins user
``sudo -i -u jenkins``
- create .kube folder in jenkins home directory
``cd ~``
``mkdir .kube``
- create confige file and copy config filr content from k8's-master machine and save
``vi .kube/config``
- go to k8's-master what you did in step:5.1.1. Kube-configue
- do ``cat .kube/config`` copy and paste save :wq
- now do ``kubectl get pods`` in jenkins server should get pods.

### 5.2.2 Add stage to script pipeline
```
stage("Deploy onto k8's cluster"){
    sh 'kubectl apply -f 'springBootMongo.yml'
}
```

delete both rc

check replication-controller

```
kubectl get rc
```
delete rc
```
kubectl delete rc mongo/spring-controller 
```

delete services too.

``kubectl get svc``
```
kubectl delete svc mongo springboot
```

not try accessing application form browser will not work.
### 5.2.3 Run jenkins job
- buld job should work ok