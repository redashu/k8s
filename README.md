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

## Deploy argocd 

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### check deployments 

```
 kubectl get all -n argocd 
NAME                                                    READY   STATUS    RESTARTS   AGE
pod/argocd-application-controller-0                     1/1     Running   0          15m
pod/argocd-applicationset-controller-6bcdf77b87-pl87q   1/1     Running   0          15m
pod/argocd-dex-server-65947c9f94-prfnq                  1/1     Running   0          15m
pod/argocd-notifications-controller-7b8f9484db-qvl2r    1/1     Running   0          15m
pod/argocd-redis-558cfbbf7-pql6c                        1/1     Running   0          15m
pod/argocd-repo-server-5669dc5db8-9wbb4                 1/1     Running   0          15m
pod/argocd-server-8876766d6-l6cfz                       1/1     Running   0          15m

NAME                                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/argocd-applicationset-controller          ClusterIP   10.107.25.204    <none>        7000/TCP,8080/TCP            15m
service/argocd-dex-server                         ClusterIP   10.104.119.199   <none>        5556/TCP,5557/TCP,5558/TCP   15m
service/argocd-metrics                            ClusterIP   10.101.131.49    <none>        8082/TCP                     15m
service/argocd-notifications-controller-metrics   ClusterIP   10.105.129.98    <none>        9001/TCP                     15m
service/argocd-redis                              ClusterIP   10.104.63.11     <none>        6379/TCP                     15m
service/argocd-repo-server                        ClusterIP   10.100.15.201    <none>        8081/TCP,8084/TCP            15m
service/argocd-server                             NodePort    10.106.147.27    <none>        80:31020/TCP,443:32491/TCP   15m
service/argocd-server-metrics                     ClusterIP   10.100.220.33    <none>        8083/TCP                     15m

NAME                                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/argocd-applicationset-controller   1/1     1            1           15m
deployment.apps/argocd-dex-server                  1/1     1    

```

### change service argocd-server to nodeport 


### get the password 

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

