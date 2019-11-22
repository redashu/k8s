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

## Tips for kubernetres 

###  Kubectl  bashcompletion for autotab working 
```
echo  'source <(kubectl completion bash)'  >>$HOME/.bashrc 
```

####  NOte:  logout and login your current session or use source command 

## Deployments 
This is the way generally people use to deploy application in production grade <br/>
It can container single or more pods & easy to scale and upgrade <br/>
Rolling updates is also very much good feature <br/>
###  Deploy Deployments from YAML 
```
[root@station132 k8s]# kubectl  apply  -f  ashudep1.yml 
deployment.extensions/ashudep1 created

[root@station132 k8s]# kubectl  get  deployments
NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
ashudep1   2         2         2            2           7s
```

### TO show more details like lables of kubernetes containers

```
[root@station132 k8s]# kubectl  get deployments.  -o wide
NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES   SELECTOR
ashudep1   2         2         2            2           3m2s   c1           nginx    app=ashudep1
```

### Describing  deployments 

```
[root@station132 k8s]# kubectl  describe deployments. ashudep1 
Name:                   ashudep1
Namespace:              default
CreationTimestamp:      Thu, 07 Nov 2019 18:35:46 -0500
Labels:                 app=ashudep1
Annotations:            deployment.kubernetes.io/revision: 1
                        kubectl.kubernetes.io/last-applied-configuration:
                          {"apiVersion":"extensions/v1beta1","kind":"Deployment","metadata":{"annotations":{},"name":"ashudep1","namespace":"default"},"spec":{"repl...

```

### Create Deployments using command line 

```
[root@station132 k8s]# kubectl run mydep  --image=nginx  --port=80 --replicas=3
kubectl run --generator=deployment/apps.v1beta1 is DEPRECATED and will be removed in a future version. Use kubectl create instead.
deployment.apps/mydep created
 
[root@station132 k8s]# kubectl  get deployments.
NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
ashudep1   2         2         2            2           11m
mydep      3         3         3            3           11s

```

### Note: in backend replicasets is also created that is actually take care to replication factor of pods

```
[root@station132 k8s]# kubectl  get replicasets.
NAME                  DESIRED   CURRENT   READY   AGE
ashudep1-64875ff59d   2         2         2       12m
mydep-7546bf9d89      3         3         3       77s

[root@station132 k8s]# kubectl  get replicasets.extensions 
NAME                  DESIRED   CURRENT   READY   AGE
ashudep1-64875ff59d   2         2         2       12m
mydep-7546bf9d89      3         3         3       85s

[root@station132 k8s]# kubectl  get replicasets.apps 
NAME                  DESIRED   CURRENT   READY   AGE
ashudep1-64875ff59d   2         2         2       12m
mydep-7546bf9d89      3         3         3       88s
```

##  Updating  new image to deployment 

```
[root@ip-172-31-89-188 ~]# kubectl get deployments.apps 
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
deployment   0/2     2            0           15h
nginx        5/5     5            5           15h


kubectl set image deployment nginx=nginx:1.7.9

```

## checking  rolling updates 
```
[root@ip-172-31-89-188 ~]# kubectl rollout status deployment nginx 
deployment "nginx" successfully rolled out
```

## checking  rolling updates history 
```
[root@ip-172-31-89-188 ~]# kubectl rollout history  deployment nginx 
deployment.apps/nginx 
REVISION  CHANGE-CAUSE
1         <none>
```

## we can set image and rolling updates revision will be new like
```
[root@ip-172-31-89-188 ~]# kubectl rollout history  deployment nginx 
deployment.apps/nginx 
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
```

## TO undo the changes that was just recently happened :- you can use this 
```
[root@ip-172-31-89-188 ~]# kubectl rollout undo  deployment nginx 

```
## TO undo the changes to any revision :- you can use this 
```
[root@ip-172-31-89-188 ~]# kubectl rollout undo  deployment nginx --to-revision=1   #  here 1 is revision number 

```
