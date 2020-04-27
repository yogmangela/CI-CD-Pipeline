### Creating a Pod
```
$ kubectl run kuard --generator=run-pod/v1 --image=gcr.io/kuar-demo/kuard-amd64:blue
```
### You can see the status of this Pod by running:
```
$ kubectl get pods
```

### Creating Pod menifest file on master
```
kubectl apply -f yogs-pod.yml
```
### kubectl describe

```
ubuntu@ip-172-31-31-212:~$ kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
kuard                     1/1     Running   0          5m32s
mongo-controller-g7f8r    1/1     Running   0          29m
spring-controller-q2dgc   1/1     Running   0          29m
ubuntu@ip-172-31-31-212:~$
```
### kubectl describe pods <<podname>>

### kubectl logs  : 
`` kubectl logs mongo-controller-g7f8r ``
### Health Check menifestfile

##  Applying LABELS

### 1. First, create the alpaca-prod deployment and set the ver, app, and env labels:
```
kubectl run alpaca-prod --image=gcr.io/kuar-demo/kuard-amd64:blue --replicas=2 --labels="ver=1,app=alpaca,env=prod"
```
### 2. Next, create the alpaca-test deployment and set the ver, app, and env labels with the appropriate values:
```
kubectl run alpaca-test --image=gcr.io/kuar-demo/kuard-amd64:green --replicas=1 --labels="ver=2,app=alpaca,env=test"
```
### 3. Finally, create two deployments for bandicoot. Here we name the environments prod and staging:
```
kubectl run bandicoot-prod --image=gcr.io/kuar-demo/kuard-amd64:green --replicas=2 --labels="ver=2,app=bandicoot,env=prod"

kubectl run bandicoot-staging --image=gcr.io/kuar-demo/kuard-amd64:green --replicas=1 --labels="ver=2,app=bandicoot,env=staging"
```

### 4. Deploy
```
kubectl get deployments --show-labels
```

### 5. Services
```
kubectl run alpaca-prod \
--image=gcr.io/kuar-demo/kuard-amd64:blue \
--replicas=3 \
--port=8080 \
--labels="ver=1,app=alpaca,env=prod"
```

```
kubectl expose deployment alpaca-prod
```
