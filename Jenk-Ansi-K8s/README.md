# CI/CD Project using Jenkins,Ansible,Docker ans K8's

## Steps1: install Ansible

## Steps2: install Jenkins

## Steps3: install Docker

## Steps4: install K8's
### Steps4.1: Create and Ubuntu Instance and follow execute below command

```
 sudo -i
 sudo apt update
 curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
 apt install unzip python
 unzip awscli-bundle.zip
 sudo apt-get install unzip - if you dont have unzip in your system
 ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
```
### Steps4.2: Install K8's

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
 chmod +x ./kubectl
 sudo mv ./kubectl /usr/local/bin/kubectl
 ```

### Steps4.3: Install KOPS
```
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
```
### Steps4.4 Create IAM Role with Route53, EC2, IAM and s3 full access


### Steps4.5 Attach Created IAM role to Ubuntu instance.
- Once IAM Created "K8S_ROLE" then go back to EC2 instance.
- Click ''Action'' >> ``Instance Settings`` >> ``Attach/Replace IAM Role``>>
- Select the role you have created and click ``Apply``

### Step4.5.1 : Only allow K8's to create instance in Ireland region . 
- on EC2 instance type ``aws configure`` Only add Region = ``eu-west-1`` rest leave blank

- Check to see if role has appropriate access by ``aws s3 ls`` should list all the s3 bucket you have.

### Steps4.6 Use Route53 to create Private DNS 
- i have created ``devops.cocm``
- Create S3 bucket  ``aws s3 mb s3://sandbox.k8s.devops.com``
- Export to KOPS : ``export KOPS_STATE_STORE=s3://sandbox.k8s.devops.com``

### Steps4.7 Create .ssh-keygen
``ssh-keygen`` should see key generated.
```
root@ip-172-31-18-190:~# ls .ssh
authorized_keys  id_rsa  id_rsa.pub
```

### Steps4.8  Create a cluster
```
kops create cluster --cloud=aws --zones=eu-west-1b --name=sandbox.k8s.devops.com --dns-zone=devops.com --dns private
```
check this file: (AWS Cluster)[/KOPS_Cluster.cmd] for outputa

Cluster configuration has been created.

### This is very important:

Suggestions:
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster sandbox.k8s.devops.com
 * edit your node instance group: kops edit ig --name=sandbox.k8s.devops.com nodes
 * edit your master instance group: kops edit ig --name=sandbox.k8s.devops.com master-eu-west-1b
Finally configure your cluster with: kops update cluster --name sandbox.k8s.devops.com --yes

** To change master configuration **

```
kops edit ig --name=sandbox.k8s.devops.com master-eu-west-1b
```
change instance to ``t2.micro`` we really don't need c4, t3 type.

to validate : ``kops validate cluster`` it take 5-10minutes for cluster to complete setup. 

to change it will ask you to run ``kops rolling-update cluster``

### Steps4.9 Login into Cluster by
```
ssh -i ~/ .ssh/id_rsa admin@api.sandbox.k8s.devops.com
```
if you can't connect
try below

go tp ec2>>select masre mode>> click connect and run 
```
 ssh -i "kubernetes.sandbox.k8s.devops.com-0a:26:0b:10:58:a9:ce:38:7a:1c:8f:9d:b9:05:88:99.pem" admin@ec2-34-247-13-250.eu-west-1.compute.amazonaws.com
```
 you should get access to it.

 - check kubectl version: ``kubectl version``
 - update version: 
 
 ```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl
 ```

### Steps4.10 Add deploy files
devops-deploy.yml