# Affinity in Kubernetes 

## This is advanced scheduling concept in kubernetes 

### So Kubernetes 1.6 offers four advanced scheduling features: node affinity/anti-affinity, taints and tolerations, pod affinity/anti-affinity, and custom schedulers.

### Here we can decide which pod to be schedule on which worker node 

```
kubectl label nodes <your-node-name> disktype=ssd

```

##  add node affinity in pod 

### Schedule a Pod using required node affinity

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:  # Required Node affinity 
        nodeSelectorTerms:
        - matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd            
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
    
```

### Schedule a Pod using preferred node affinity

```

apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  affinity:
    nodeAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 1
        preference:
          matchExpressions:
          - key: disktype
            operator: In
            values:
            - ssd          
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent

```

### YOu can also do the same with node selector 

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  nodeSelector:
    disktype: ssd
```



