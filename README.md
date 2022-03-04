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


# ETCD :- the brain of kubernetes 

## etcd pod is running inside kube-system namespace 


```
❯ kubectl get po -n kube-system
NAME                                       READY   STATUS    RESTARTS   AGE
calico-kube-controllers-78d6f96c7b-hqtfg   1/1     Running   5          7d23h
calico-node-44n8k                          1/1     Running   5          7d23h
calico-node-65tg8                          1/1     Running   5          7d23h
calico-node-68j78                          1/1     Running   5          7d23h
calico-node-xb28f                          1/1     Running   5          7d23h
coredns-558bd4d5db-68pph                   1/1     Running   5          7d23h
coredns-558bd4d5db-ctk7b                   1/1     Running   5          7d23h
etcd-masternode                            1/1     Running   5          7d23h

```

## Taking a backup of etcd cluster 

```
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=<trusted-ca-file> --cert=<cert-file> --key=<key-file> \
  snapshot save <backup-file-location>
  
```

### Note: here about these certfication information will be given when you do etcd pod describe command 

### connecting to etcd and checking health --

```
etcdctl endpoint health   --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt  --key=/etc/kubernetes/pki/apiserver-etcd-client.key
127.0.0.1:2379 is healthy: successfully committed proposal: took = 10.274018ms
```

### creating secret and checking from backend 

```
 kubectl create secret generic  sec1  --from-literal  x=hLlo
secret/sec1 created
[root@ip-172-31-90-99 ~]# 
[root@ip-172-31-90-99 ~]# etcdctl get  /registry/secrets/default/sec1 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/apiserver-etcd-client.crt  --key=/etc/kubernetes/pki/apiserver-etcd-client.key
/registry/secrets/default/sec1
k8s


v1Secret?
?
sec1default"*$2c37c282-3cc7-4567-b869-96a9d3db2cb52????z?^
kubectl-createUpdatev????FieldsV1:*
({"f:data":{".":{},"f:x":{}},"f:type":{}}B	
xhLloOpaque"

```
### Note: as you can see above we can see the content so -- we need to encrypt this content 

### EncrypintionConfiguration --- a new API resources in k8s 

