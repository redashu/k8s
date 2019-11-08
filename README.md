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

## Namespace in Kubernetes 
This entity is basically for making isolation for different users and services in kubernetes <br/>
different users can create their seperate pods, deployment , services and many those are isolated from each other <br/>

##  Namespace facts :
There are 3 namespace which are by default created 
<ul>
	<li> default </li>
	<li> kube-system  </li>
	<li> kube-public </li>
<ul/>

```
[ec2-user@ip-172-31-89-188 ~]$ kubectl get namespaces 
NAME              STATUS   AGE
default           Active   96m
kube-public       Active   96m
kube-system       Active   96m
```

###  Not everything is inside namespaces like  <i> namespaces  </i>  
####  To check list of  api-resources which are present in namespace and which are not
```
[ec2-user@ip-172-31-89-188 ~]$ kubectl api-resources 
NAME                              SHORTNAMES   APIGROUP                       NAMESPACED   KIND
bindings                                                                      true         Binding
componentstatuses                 cs                                          false        ComponentStatus
configmaps                        cm                                          true         ConfigMap
endpoints                         ep                                          true         Endpoints
events                            ev                                          true         Event
limitranges                       limits                                      true         LimitRange
namespaces                        ns                                          false        Namespace
nodes                             no                                          false        Node
persistentvolumeclaims            pvc                                         true         PersistentVolumeClaim
persistentvolumes                 pv                                          false        PersistentVolume
pods                              po                                          true         Pod
```

###  By default we create all resources in default namespace as a kubernetes client  


## Creating namespaces 
###  using  yaml file  
```
[ec2-user@ip-172-31-89-188 ~]$ kubectl create  -f  creans.yml 
namespace/myspace created
[ec2-user@ip-172-31-89-188 ~]$ kubectl get  namespaces 
NAME              STATUS   AGE
default           Active   114m
kube-node-lease   Active   114m
kube-public       Active   114m
kube-system       Active   114m
myspace           Active   6s
```

###  creating namespace using command line 
```
[ec2-user@ip-172-31-89-188 ~]$ kubectl create   namespace  cmdname
namespace/cmdname created
[ec2-user@ip-172-31-89-188 ~]$ kubectl get ns
NAME              STATUS   AGE
cmdname           Active   5s
default           Active   116m
kube-node-lease   Active   116m
kube-public       Active   116m
kube-system       Active   116m
myspace           Active   100s

```

###  Changing namespace permanently 
```
kubectl config set-context   $(kubectl  config  current-context)   --namespace=myspace 
```

## Namespcae and DNS

whenever we create a service  it creates a corresponding DNS entry like <b> servicename.namespace.svc.cluster.local </b> <br/>
here  <b> cluster.local  </b>  is the default domain name  which means now pods can access each other by their service name
under same namespace 
