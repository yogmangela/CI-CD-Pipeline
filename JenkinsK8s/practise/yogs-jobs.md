```
kubectl run -i oneshot \
--image=gcr.io/kuar-demo/kuard-amd64:blue \
--restart=OnFailure \
-- --keygen-enable \
--keygen-exit-on-complete \
--keygen-num-to-gen 10
```