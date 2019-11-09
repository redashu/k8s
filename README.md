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

## Kubernetes multinode setup 
###  we have 4 machine , 1 master and 3 worker
## Pre-requisite 

### Disable selinux in all the nodes

```
  [root@master ~]# setenforce  0
  [root@master ~]# sed -i 's/SELINUX=enforcing/SELINUX=disabled/'  /etc/selinux/config
  
 ```
 
 ### Enable the kernel bridge for every system
 ```
 [root@master ~]# modprobe br_netfilter
 [root@master ~]# echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
 ```
 ### Disable the swap 
 ```
 [root@master ~]# swapoff  -a
 ```
 ## Installing  docker and kubeadm in all the nodes 
 ```
 [root@master ~]# yum  install  docker kubeadm  -y
 ```
 ## Start service of docker & kubelet in all the nodes 
 ```
 [root@master ~]# systemctl enable --now  docker kubelet
 ```
 ## Do this only on Kubernetes Master 
 We are here using Calico Networking so we need to pass some parameter 
 you can start [Kubernetes_networking](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) from this  <br/>
 
```
[root@master ~]# kubeadm  init --pod-network-cidr=192.168.0.0/16
```
### Use the output of above command and paste it to all the worker nodes

## Do this step in master node 
```
[root@master ~]# mkdir -p $HOME/.kube
[root@master ~]#  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
[root@master ~]# chown $(id -u):$(id -g) $HOME/.kube/config
```

##  Now apply calico project 
```
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml
```
After this all nodes will be ready in state

## Now you can check nodes status
```
[root@master ~]# kubectl get nodes
NAME                 STATUS   ROLES    AGE     VERSION
master.example.com   Ready    master   11m     v1.12.2
node1.example.com    Ready    <none>   9m51s   v1.12.2
node2.example.com    Ready    <none>   9m25s   v1.12.2
node3.example.com    Ready    <none>   9m3s    v1.12.2
```

Good luck guys !!

## Scheduling  in  KUbernetes
###  By default pods are schedule automatically by <b> kube-schedular </b> on behalf of some steps 
<ul>
	<li> filtering  </li>
	<li> scoring   </li>
</ul>

###  Filtering -- to find the set of nodes where pods can be scheduled on behalf of multiple parameter like resources , pods and many more 
### then it will give score to nodes on behalf of filtering , nodes with highest score will get the pods
### if the score is same for all the nodes then it will randomly schedule :
### you can find more on  kube-schedular  [kubernetes_schedular](https://kubernetes.io/docs/concepts/scheduling/kube-scheduler) <br/>

## Scheduling a POd on a particular node 
```
 kubectl create -f  schedule_at_create.yml
```

## Using NodeSelector to schedule to pod
```
[root@station132 k8s]# kubectl label nodes node3.example.com  name1=ssd1  --overwrite
```

###  Step 1  add  nodeSelector in yaml file 
```
[root@station132 k8s]# cat  schedule_at_create.yml 
apiVersion: v1
kind: Pod
metadata:
 name: pod1
 labels:
  name: helloapp

spec:
 containers:
  - image: nginx
    name: c1
    ports:
     - containerPort: 80
    imagePullPolicy: IfNotPresent
 nodeSelector:           # added line 
  name1: ssd1             # added line 
 restartPolicy: Always
```

### Use kubectl apply  command 
```
[root@station132 k8s]# kubectl replace --force -f  schedule_at_create.yml 
pod "pod1" deleted
pod/pod1 replaced
```

###  check the pod1 now is rescheduled 
```
[root@station132 k8s]# kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE   IP                NODE                NOMINATED NODE
counter                1/1     Running   0          54m   192.168.11.80     node1.example.com   <none>
counter1               1/1     Running   0          49m   192.168.221.2     node2.example.com   <none>
de                     1/1     Running   0          83m   192.168.178.235   node3.example.com   <none>
de1-65c4d85d96-n7d2k   1/1     Running   0          82m   192.168.11.84     node1.example.com   <none>
de2-6675f9dbf8-72sc4   1/1     Running   0          82m   192.168.178.239   node3.example.com   <none>
de3                    1/1     Running   0          81m   192.168.221.6     node2.example.com   <none>
pod1                   1/1     Running   0          13s   192.168.178.236   node3.example.com   <none>
```

