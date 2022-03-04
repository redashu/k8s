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

### Understanding -

<img src="object.png">

### 

## create a service account 

```
 kubectl  create sa  test
```

## creating a role 

```
kubectl create role pod-reader --verb=get --verb=list --verb=watch --resource=pods

```

## Bind role to  account 

```
kubectl create rolebind mybind --role pod-reader --user=harry 
```

## accounts in k8s

<img src="accounts.png">

## Normal user

### there are no api-resources in k8s to create users --

### we can integrate with external services or create CSR -- bcz user -- (cert + CN name)

<img src="users.png">

### create a user ashutoshh and CSR and sign it 

<img src="sign.png">

### -- 

```
root@node155:~# mkdir /users/
root@node155:~# cd /users/
root@node155:/users# openssl  genrsa 2048 -out  ashu.key 
Extra arguments given.
genrsa: Use -help for summary.
root@node155:/users# openssl  genrsa  -out  ashu.key 2048 
Generating RSA private key, 2048 bit long modulus (2 primes)
....................................................+++++
...............................................+++++
e is 65537 (0x010001)
root@node155:/users# ls
ashu.key
root@node155:/users# openssl req -new -key ashu.key -out ashu.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:
State or Province Name (full name) [Some-State]:
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:ashu
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:

```

### now we have ashu key and csr 

```
root@node155:/users# ls
ashu.csr  ashu.key

```

### now creating 

```
root@node155:/users# cat  ashu.csr   |  base64 -w 0 
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ21UQ0NBWUVDQVFBd1ZERUxNQWtHQTFVRUJoTUNRVlV4RXpBUkJnTlZCQWdNQ2xOdmJXVXRVM1JoZEdVeApJVEFmQmdOVkJBb01HRWx1ZEdWeWJtVjBJRmRwWkdkcGRITWdVSFI1SUV4MFpERU5NQXNHQTFVRUF3d0VZWE5vCmRUQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQUxhQlNNOEN3K3h6S2c1MVFRN2gKbzY5cE1uNTBXalNNNTNDWnRMY3JxSEo2N091TVpuSTNMdVB1K3NWakE5UUo0bnRXaktDNUdyMksvdnlLdndsOQowcW8rK2xZOW1JUG9vTzVp

```

### copy above data and use in request.csr file 

```

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


