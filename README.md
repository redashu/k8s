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

## you can check nodes status
```
[root@master ~]# kubectl get nodes
NAME                 STATUS   ROLES    AGE     VERSION
master.example.com   Ready    master   11m     v1.12.2
node1.example.com    Ready    <none>   9m51s   v1.12.2
node2.example.com    Ready    <none>   9m25s   v1.12.2
node3.example.com    Ready    <none>   9m3s    v1.12.2
```

## Note : Not all CNI are supporting Network policy so check about your CNI in kubernetes Docs 
## Check for CNI 

```
[root@ip-172-31-47-137 ~]# kubectl get po -n kube-system
NAME                                                    READY   STATUS    RESTARTS   AGE
calico-kube-controllers-7d569d95-wpfww                  1/1     Running   0          23m
calico-node-cmjt7                                       1/1     Running   0          23m
calico-node-lcwvv                                       1/1     Running   0          23m
calico-node-xt2qw                                       1/1     Running   0          23m

```


# Kubernetes Network policy 

## Its like firewall for your pods

## Some points to remember 

### There are 3 different ways to apply network policy in Pods 

<ol>
	<li> Using PodSelector -: Pod to Pod rules  </li>
	<li> Namespace Selector 🕙  From some namespace  </li>
	<li> Using IpBlock </li>
</ol>

## There are two type ot network policy
<ol>
	<li> Ingress </li>
	<li> Egress </li>
</ol>

<h2> Ingress  </h2>
--
When traffic is comming towards pods means from outside to pods

<h2> Egress  </h2>
--
When traffic is going outside to Pods 

# Network policies works on behalf of labels on pod and it is also restricted to Namespace 

# Deny all traffic to pod

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: web-deny-all
  namespace: kube-public
spec:
  podSelector:
    matchLabels:
      app: exam
  ingress: []

```

### kubectl  create -f netpolicy_deny.yml 


# ONly allow from a specfic Pod 

```
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: api-allow
  namespace: kube-public
spec:
  podSelector:
    matchLabels:
      app: exam  #  label of pods where we want to apply policy 
  ingress:
  - from:
      - podSelector:
          matchLabels:
            x: hello             #from this pod we can only access
```
### kubectl create  -f  limit_access.yml

## One More example 

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
        - 172.17.1.0/24
    - namespaceSelector:
        matchLabels:
          project: myproject
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - protocol: TCP
      port: 6379
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
    ports:
    - protocol: TCP
      port: 5978
```

