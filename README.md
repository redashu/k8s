# Kubernetes :- The Production grade container orchestration  Engine 
## Info about Kubernetes
Kubernetes in the most powerfull container orchestration engine <br/>
Its free for everyone <br/>
## Developement  info 
<ul>
	<li> Developed by Google and CNCF  </li>
	<li> 7 June 2014 is the Release date  </li>
	<li> written in Go lang  </li>
	
</ul>

## Kubernetes multinode 
###  we have 4 machines; 1 master and 3 worker nodes
## Pre-requisite 

# Calico 

## As we have deployded the project calico so here we are going to explore more about calico

## calic client installation 

```
wget https://github.com/projectcalico/calicoctl/releases/download/v3.14.0/calicoctl
chmod +x calicoctl
sudo mv calicoctl /usr/local/bin/
```

## configure calicoctl environment 

```
export KUBECONFIG=/root/.kube/config 
export DATASTORE_TYPE=kubernetes
```

## creating new ip Pool using calico 

```
calicoctl  apply -f pool.yml 
```

## checking ip Pool 

```
[root@k8smaster ~]# calicoctl get ippools 
NAME                  CIDR             SELECTOR   
default-ipv4-ippool   192.168.0.0/16   all()      
pool1                 10.20.0.0/16     all()      
pool2                 192.167.0.0/16   all()  

```

## deploy pod in custom ipPOOL 

```
kubectl apply -f podnnew.yml

```


# link ('https://docs.projectcalico.org/getting-started/kubernetes/hardway/the-calico-datastore')

## Note: if we want to deploy more than one CNI plugin in same k8s cluster like -- in our case 

### we already have Calico 

### lets deploy flannel but wait we need to change cidr in flannel YAML  

```
wget https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
```

### now change flannel yaml network range to default pod-cidr range then deploy it 

```
fire@ashutoshhs-MacBook-Air /tmp % grep -in subnet kube-flannel.yml 
158:        - --kube-subnet-mgr
fire@ashutoshhs-MacBook-Air /tmp % vim kube-flannel.yml +150       
fire@ashutoshhs-MacBook-Air /tmp % kubectl apply -f kube-flannel.yml 
namespace/kube-flannel created
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.apps/kube-flannel-ds created

```

### lets verify 

```
fire@ashutoshhs-MacBook-Air /tmp % kubectl  get  po -n kube-flannel
NAME                    READY   STATUS    RESTARTS   AGE
kube-flannel-ds-2xxmk   1/1     Running   0          36s
kube-flannel-ds-lkql8   1/1     Running   0          36s
kube-flannel-ds-mc9pf   1/1     Running   0          36s
fire@ashutoshhs-MacBook-Air /tmp % 

```

### now create pod with Flannel cni 

```
apiVersion: v1
kind: Pod
metadata:
  annotations: 
    cni: "flannel"
  creationTimestamp: null
  labels:
    run: ashupodx3
  name: ashupodx3
   
spec:
  containers:
  - image: nginx
    name: ashupodx3
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```

### deploy and see 

```
fire@ashutoshhs-MacBook-Air kubernetes % kubectl  get po 
NAME        READY   STATUS    RESTARTS   AGE
ashupod1    1/1     Running   0          53m
ashupodx3   1/1     Running   0          10s
fire@ashutoshhs-MacBook-Air kubernetes % kubectl describe pod ashupodx3 
Name:             ashupodx3
Namespace:        ashu-space
Priority:         0
Service Account:  default
Node:             worker1/172.31.32.194
Start Time:       Wed, 16 Nov 2022 18:26:14 +0530
Labels:           run=ashupodx3
Annotations:      cni: flannel
                  cni.projectcalico.org/containerID: cd9d170f191ce8ac3e3179d670ca8ba0d1d76b0b209464be76d03a1bb89c2924
                  cni.projectcalico.org/podIP: 192.168.235.149/32
                  cni.projectcalico.org/podIPs: 192.168.235.149/32
Status:           Running
IP:               192.168.235.149
IPs:
  IP:  192.168.235.149
Containers:
  ashupodx3:
    Container ID:   containerd://a8279ee1713e1a632cd333ece435f0b8b20a297e8c65a0e70d829eddc84643f5
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:e209ac2f37c70c1e0e9873a5f7231e91dcd83fdf1178d8ed36c2ec09974210ba
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 16 Nov 2022 18:26:22 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zgdk8 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
```

### enjoy the learning 
