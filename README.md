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

## Limit Ranges 

### Note: LimitRange support has been enabled by default since Kubernetes 1.10 

### A LimitRange provides constraints that can

<ol>
	<li> Enforce minimum and maximum compute resources usage per Pod or Container in a namespace </li>
	
	<li> Enforce minimum and maximum storage request per PersistentVolumeClaim in a namespace </li>
	<li> Enforce a ratio between request and limit for a resource in a namespace </li>
	<li> Set default request/limit for compute resources in a namespace and automatically inject them to Containers at runtime </li>
	
</ol>

## Enable LimitRanges in Namespace 

### creating namespace 

```
kubectl  create  namespace  restricted
```
### YAML for cpu restriction to container 

```
cat /tmp/limitcpu.yaml 
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-min-max-demo
  namespace: restricted
spec:
  limits:
  - max:
      cpu: "800m"
    min:
      cpu: "200m"
    type: Container


```
### apply yaml 

```
kubectl apply -f /tmp/limitcpu.yaml
```
### checking after apply 

```
kubectl get limits  -n restricted 
NAME               CREATED AT
cpu-min-max-demo   2021-12-03T03:07:50Z
 fire@ashutoshhs-MacBook-Air  ~  kubectl  describe  limits  -n restricted 
Name:       cpu-min-max-demo
Namespace:  restricted
Type        Resource  Min   Max   Default Request  Default Limit  Max Limit/Request Ratio
----        --------  ---   ---   ---------------  -------------  -----------------------
Container   cpu       200m  800m  800m             800m           -

```

