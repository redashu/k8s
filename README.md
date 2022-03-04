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


# Getting started with RBAC 

## create a service account 

```
 kubectl  create sa  test
```

## creating a role 

```
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods

```

## Bind role to service account 

```

### connecting from pod to apiserver
```
 curl https://kubernetes -k  -H "Authorization: Bearer token-of-svc-acc"
```

### In max of the cases service account token doesn't require to be mounted inside the pod (default is mounting..)

'''
apiVersion: v1
kind: ServiceAccount
metadata:
  name: build-robot
automountServiceAccountToken: false
'''

## k8s api server FLow 

<img src="apiworkflow.png">

### API-request with respect to users

<img src="users.png">

### Restrictions

<img src="restriction.png">

### block anonymous users 

```
root@node155:/etc/kubernetes/manifests# pwd
/etc/kubernetes/manifests
root@node155:/etc/kubernetes/manifests# cat kube-apiserver.yaml 
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.168.1.155:6443
  creationTimestamp: null
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=192.168.1.155
    - --allow-privileged=true
    - --anonymous-auth=false # this line added 
```

### sending request to secure port of apiserver

```
curl https:/ip:6443 --cacert ca.crt --cert client.crt --key client.key 
```


