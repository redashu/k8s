### Creating cluster 

```
eksctl create cluster -f cluster.yaml

```

### listing cluster info 

```
eksctl get clusters
eksctl get clusters --region nameof-region
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
