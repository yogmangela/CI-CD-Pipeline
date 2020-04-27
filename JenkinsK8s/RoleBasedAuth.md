## Role Based Authentication Control (RBAC)

- can see default list of Roles get's created when runing K8's

```
ubuntu@ip-172-31-31-212:~$ kubectl get clusterroles
NAME                                                                   CREATED AT
admin                                                                  2020-04-25T13:48:08Z
cluster-admin                                                          2020-04-25T13:48:08Z
contour                                                                2020-04-26T10:05:34Z
edit                                                                   2020-04-25T13:48:08Z
kubeadm:get-nodes                                                      2020-04-25T13:48:10Z
system:certificates.k8s.io:certificatesigningrequests:nodeclient       2020-04-25T13:48:08Z
.
.
.
system:controller:clusterrole-aggregation-controller                   2020-04-25T13:48:08Z

system:discovery                                                       2020-04-25T13:48:08Z
system:heapster                                                        2020-04-25T13:48:08Z
system:kube-aggregator                                                 2020-04-25T13:48:08Z
system:kube-controller-manager                                         2020-04-25T13:48:08Z
system:kube-dns                                                        2020-04-25T13:48:08Z
system:kube-scheduler                                                  2020-04-25T13:48:08Z
system:kubelet-api-admin                                               2020-04-25T13:48:08Z
.
.
system:volume-scheduler                                                2020-04-25T13:48:08Z
view                                                                   2020-04-25T13:48:08Z
weave-net
```