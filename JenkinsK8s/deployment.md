### Create Deployment
```
kubectl create -f yogs-deployment.yml
```
```
 vi yogs-deployment.yml
 kubectl create -f yogs-deployment.yml 
 kubectl get deployments
 kubectl get deployments yogs -o jsonpath --template {.spec.selector.matchLabels}
 kubectl get replicasets --selector=run=yogs
 kubectl scale deployments yogs --replicas=2
 kubectl get replicasets --selector=run=yogs
```
### Deployment config
```
kubectl get deployments kuard --export -o yaml > yogs-deployment.yaml
kubectl get deployments yogs --export -o yaml > yogs-deployment.yaml
ls
vi yogs-deployment.yaml
kubectl replace -f yogs-deployment.yaml --save-config
```
### Managing Deployments /roll
```
ubuntu@ip-172-31-31-212:~$ kubectl rollout status deployments yogs
deployment "yogs" successfully rolled out

ubuntu@ip-172-31-31-212:~$ kubectl get replicasets -o wide
NAME              DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES                               SELECTOR
yogs-759c95b4bc   2         2         2       19m   yogs         gcr.io/kuar-demo/kuard-amd64:green   pod-template-hash=759c95b4bc,run=yogs

ubuntu@ip-172-31-31-212:~$ kubectl rollout pause deployments yogs
deployment.apps/yogs paused

ubuntu@ip-172-31-31-212:~$ kubectl rollout resume deployments yogs
deployment.apps/yogs resumed

ubuntu@ip-172-31-31-212:~$ kubectl rollout history deployment yogs
deployment.apps/yogs
REVISION  CHANGE-CAUSE
1         <none>
```
### Chaneg replicaSet to 3 in yogs-deployment.yaml not .yml


```
ubuntu@ip-172-31-31-212:~$ ls
yog-pod-full.yml      yogs-deployment.yml  yogs-rc.yml
yogs-deployment.yaml  yogs-pod.yml
```

```
ubuntu@ip-172-31-31-212:~$ vi yogs-deployment.yaml
```

```
ubuntu@ip-172-31-31-212:~$ kubectl apply -f yogs-deployment.yaml
deployment.apps/yogs configured
```

```
ubuntu@ip-172-31-31-212:~$ kubectl get deployments yogs
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
yogs   3/3     3            3           30m
ubuntu@ip-172-31-31-212:~$
```
###  Rollback deployment

```
ubuntu@ip-172-31-31-212:~$ kubectl rollout history deployment yogs
deployment.apps/yogs
REVISION  CHANGE-CAUSE
1         <none>
2         <none>

ubuntu@ip-172-31-31-212:~$ kubectl rollout undo deployments yogs --to-revision=1
deployment.apps/yogs rolled back

ubuntu@ip-172-31-31-212:~$ kubectl rollout history deployment yogs
deployment.apps/yogs
REVISION  CHANGE-CAUSE
2         <none>
3         <none>

```
### Delete Deployments
```
kubectl delete deployments yogs

or 

kubectl delete -f yogs-deployment.yaml
```
