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

## Updatig cluster 

## In k8s This is really important in production grade cluster to understand and follow the steps for

<ul>
	<li> maintaince mode </li>
	<li> remove node from cluster </li>
	<li> join a new cluster  </li>
	
</ul>

# putting a node in maintaince mode 

## Important points : 

i) make sure you have pods managed by RS|RC|statefulsets|deployments 
ii) 

```
404  kubectl get no
  405  kubectl drain  ip-172-31-69-50.ec2.internal 
  406  kubectl get all -n ashu-space 
  407  kubectl drain  ip-172-31-69-50.ec2.internal  --ignore-daemonsets 
  408  kubectl drain  ip-172-31-69-50.ec2.internal  --ignore-daemonsets --force
  409  kubectl get no
  410  kubectl get po -n ashu-space 
  411  kubectl get po -n ashu-space  -o wide
  412  history 
ashutoshhs-MacBook-Air:~ fire$ kubectl get no
NAME                            STATUS                     ROLES    AGE     VERSION
ip-172-31-69-50.ec2.internal    Ready,SchedulingDisabled   <none>   2d18h   v1.19.2
ip-172-31-69-53.ec2.internal    Ready                      <none>   2d18h   v1.19.2
ip-172-31-73-197.ec2.internal   Ready                      <none>   2d18h   v1.19.2
ip-172-31-78-86.ec2.internal    Ready                      master   2d18h   v1.19.2

```

## Now you can delete the nodes if you don't want to use it any more

```
ashutoshhs-MacBook-Air:~ fire$ kubectl delete nodes  ip-172-31-69-50.ec2.internal 
node "ip-172-31-69-50.ec2.internal" deleted

```

# Note : Before deleting if you want to rejoin it 

```
kubectl uncordon  ip-172-31-69-50.ec2.internal
```


	
	
