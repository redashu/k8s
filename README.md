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


# link ('https://docs.projectcalico.org/getting-started/kubernetes/hardway/the-calico-datastore')
