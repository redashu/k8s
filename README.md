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

##  PODS 

### To check existing pods in default namespace 
```
[root@station132 k8s]# kubectl get  pods
No resources found.
```

###  to create a new pod from yaml file 
```
[root@station132 k8s]# kubectl create -f  sample.yml 
pod/ashusamplepod created

[root@station132 k8s]# kubectl get  pods
NAME            READY   STATUS    RESTARTS   AGE
ashusamplepod   1/1     Running   0          4s

```

###  To check more details about pod

####  details about pods with their respective nodes 
```
[root@station132 k8s]# kubectl get  pods -o wide 
NAME            READY   STATUS    RESTARTS   AGE    IP               NODE                NOMINATED NODE
ashusamplepod   1/1     Running   0          104s   192.168.11.125   node1.example.com   <none>
```

####  To check only pods name 
```
[root@station132 k8s]# kubectl get  pods -o name
pod/ashusamplepod

```

####  Pods output in yaml or  json format 
```
[root@station132 k8s]# kubectl get  pods -o yaml 
apiVersion: v1
items:
- apiVersion: v1
  kind: Pod
  metadata:
    annotations:
      cni.projectcalico.org/podIP: 192.168.11.125/32
    creationTimestamp: 2019-11-07T23:15:11Z
    name: ashusamplepod
    namespace: default
    resourceVersion: "42534"
-----more
```
<b> So above you can replcae  -o yaml with -o json to get json output format </b>


