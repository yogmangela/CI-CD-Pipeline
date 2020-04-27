- Run [jupyter](/JenkinsK8s/real-life-projects/jupyter.yml) 

- vi ``jupyter.yml`` and copy past content from jupyter.yml file.

- use ``kubectl apply -f jupyter.yml`` to create

- you can watch by
```
watch kubectl get pods --namespace jupyter
```
- - you should get below output:
```
Every 2.0s: kubectl get pods --namespace jupyter                                                    ip-172-31-31-212: Sun Apr 26 17:37:07 2020

NAME                       READY   STATUS    RESTARTS   AGE
jupyter-7dcd5cb48b-2ksgw   0/1     Evicted   0          12m
jupyter-7dcd5cb48b-49drd   0/1     Evicted   0          2m45s
jupyter-7dcd5cb48b-5tkxh   0/1     Evicted   0          2m45s
jupyter-7dcd5cb48b-878mr   1/1     Running   0          2m41s
jupyter-7dcd5cb48b-9k8bq   0/1     Evicted   0          2m45s
jupyter-7dcd5cb48b-gxtpj   0/1     Evicted   0          2m42s
         
```
- Once the Jupyter container is up and running, you need to obtain the initial login
token. 
- You can do this by looking at the logs for the container:
```
ubuntu@ip-172-31-31-212:~$ pod_name=$(kubectl get pods --namespace jupyter --no-headers | awk '{print $1}') kubectl logs --namespace jupyter jupyter-7dcd5cb48b-prhxn
```
- you get below output with tocken to access jupyter

```
Executing the command: jupyter notebook
[I 08:54:52.293 NotebookApp] Writing notebook server cookie secret to /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret
[I 08:54:53.688 NotebookApp] JupyterLab extension loaded from /opt/conda/lib/python3.7/site-packages/jupyterlab
[I 08:54:53.688 NotebookApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
[I 08:54:53.690 NotebookApp] Serving notebooks from local directory: /home/jovyan
[I 08:54:53.690 NotebookApp] The Jupyter Notebook is running at:
[I 08:54:53.690 NotebookApp] http://(jupyter-7dcd5cb48b-prhxn or 127.0.0.1):8888/?token=6f3137eb3ec42072949123e1ab034cd2aa38e647ada1ba3f
[I 08:54:53.690 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 08:54:53.694 NotebookApp]

    To access the notebook, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/nbserver-7-open.html
    Or copy and paste one of these URLs:
        http://(jupyter-7dcd5cb48b-prhxn or 127.0.0.1):8888/?token=6f3137eb3ec42072949123e1ab034cd2aa38e647ada1ba3f

```
- You should then copy the token (it will look something like /?
token=088650fdd8b599db).
- use:
```
kubectl port-forward ${pod_name} 8888:8888

kubectl port-forward jupyter-7dcd5cb48b-prhxn 8888:8888
```

- here's some more details on jupyter node

```
ubuntu@ip-172-31-31-212:~$ kubectl describe pods --namespace jupyter
Name:         jupyter-7dcd5cb48b-prhxn
Namespace:    jupyter
Priority:     0
Node:         ip-172-31-18-107/172.31.18.107
Start Time:   Mon, 27 Apr 2020 08:54:50 +0000
Labels:       pod-template-hash=7dcd5cb48b
              run=jupyter
Annotations:  <none>
Status:       Running
IP:           10.46.0.2
IPs:
  IP:           10.46.0.2
Controlled By:  ReplicaSet/jupyter-7dcd5cb48b
Containers:
  jupyter:
    Container ID:   docker://0570709a0aadd513697a9bf331ed967bc1e61ae7ce682009aa72d7c11bbd5bde
    Image:          jupyter/scipy-notebook:abdb27a6dfbb
    Image ID:       docker-pullable://jupyter/scipy-notebook@sha256:a2518b3a15c207dbe4997ac94c91966256ac94792b09844fbdfe53015927136f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Mon, 27 Apr 2020 08:54:51 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-fl6cf (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-fl6cf:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-fl6cf
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age        From                       Message
  ----    ------     ----       ----                       -------
  Normal  Scheduled  <unknown>  default-scheduler          Successfully assigned jupyter/jupyter-7dcd5cb48b-prhxn to ip-172-31-18-107
  Normal  Pulled     24m        kubelet, ip-172-31-18-107  Container image "jupyter/scipy-notebook:abdb27a6dfbb" already present on machine
  Normal  Created    24m        kubelet, ip-172-31-18-107  Created container jupyter
  Normal  Started    23m        kubelet, ip-172-31-18-107  Started container jupyter
ubuntu@ip-172-31-31-212:~$

```