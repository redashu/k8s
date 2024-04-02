### Creating cluster 

```
eksctl create cluster -f cluster.yaml

```

### listing cluster info 

```
eksctl get clusters
eksctl get clusters --region nameof-region
```

## getting kubeconfig file 

```
eksctl utils write-kubeconfig --cluster=jpmc-cluster --kubeconfig=~/.kube/config
```


### delete clustering 

```
eksctl delete cluster --name jpmc-cluster --region us-east-1  --force
```

## Note: you may get pod eviction message while deleting 

### solution 

```
eksctl delete cluster -f cluster.yaml --disable-nodegroup-eviction
```

### scaling nodegroup -- autoscale 

```
eksctl scale nodegroup --cluster jpmc-cluster  --name nodepool-1 --nodes-min 1 --nodes-max 4 --nodes 2
```

### checking status

```
eksctl get nodegroup --cluster jpmc-cluster --region us-east-1 --name nodepool-1
```
