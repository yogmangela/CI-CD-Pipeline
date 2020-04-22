# Install jenkins on Ubuntu 18

- install Jenkins repo

```
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -

sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
```
 - Updade
 ```
sudo apt-get update
sudo apt-get install jenkins
```

- enable service at bootstrap
```
systemctl status jenkins
```
- Get Jenkins PWD
```
cat /var/lib/jenkins/secrets/initialAdminPassword
```

## Install Docker on Jenkins server
```
curl -fsSL get.docker.com | /bin/bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```