## Implementing service mesh using Istio 

### prerequisite 
<ol>
  <li> You need to have a kubernetes cluster </li>
  <li> kubectl installed and configured in k8s client system </li>
</ol>

### checking k8s cluster info 

```
[root@ip-172-31-22-131 ~]# kubectl get ns
NAME              STATUS   AGE
default           Active   47h
istio-system      Active   2m34s
kube-node-lease   Active   47h
kube-public       Active   47h
kube-system       Active   47h
```

## Installation :- there are various methods to install istio in k8s 

### installing istioctl in k8s client machine  -- Method 1 

```
 curl -L https://istio.io/downloadIstio | sh -
  mv /opt/istio-1.17.1/ /opt/istio117
```
### update .bashrc file 

```
ISTIO_HOME=/opt/istio117
PATH=$PATH:$ISTIO_HOME/bin
export PATH
```

### lets install istio using istioctl 

```
[root@ip-172-31-22-131 ~]# istioctl install 
This will install the Istio 1.17.1 default profile with ["Istio core" "Istiod" "Ingress gateways"] components into the cluster. Proceed? (y/N) y
✔ Istio core installed                                                                                                            
✔ Istiod installed                                                                                                                
✔ Ingress gateways installed                                                                                                      
✔ Installation complete                                                                                                           Making this installation the default for injection and validation.

Thank you for installing Istio 1.17.  Please take a few minutes to tell us about your install/upgrade experience!  https://forms.gle/hMHGiwZHPU7UQRWe9

```

### lets verify it 

```
[root@ip-172-31-22-131 ~]# kubectl get ns
NAME              STATUS   AGE
default           Active   47h
ingress-nginx     Active   47h
istio-system      Active   43s
kube-node-lease   Active   47h
kube-public       Active   47h
kube-system       Active   47h
```

### 

```
[root@ip-172-31-22-131 ~]# kubectl get all -n istio-system 
NAME                                        READY   STATUS    RESTARTS   AGE
pod/istio-ingressgateway-54746c69cf-fmlhh   1/1     Running   0          4m32s
pod/istiod-d5bc8669c-4b7vw                  1/1     Running   0          4m42s

NAME                           TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                      AGE
service/istio-ingressgateway   LoadBalancer   10.100.90.35     <pending>     15021:31233/TCP,80:32696/TCP,443:32709/TCP   4m31s
service/istiod                 ClusterIP      10.107.201.215   <none>        15010/TCP,15012/TCP,443/TCP,15014/TCP        4m42s

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/istio-ingressgateway   1/1     1            1           4m32s
deployment.apps/istiod                 1/1     1            1           4m42s

NAME                                              DESIRED   CURRENT   READY   AGE
replicaset.apps/istio-ingressgateway-54746c69cf   1         1         1       4m32s
replicaset.apps/istiod-d5bc8669c                  1         1         1       4m42s

NAME                                                       REFERENCE                         TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/istio-ingressgateway   Deployment/istio-ingressgateway   <unknown>/80%   1         5         1          4m32s
horizontalpodautoscaler.autoscaling/istiod                 Deployment/istiod                 <unknown>/80%   1         5         1          4m42s
[root@ip-172-31-22-131 ~]# 

```

## checking few more details 

### version 

```
[root@ip-172-31-22-131 ~]# istioctl version 
client version: 1.17.1
control plane version: 1.17.1
data plane version: 1.17.1 (1 proxies)
```

### verify installation 

```
[root@ip-172-31-22-131 ~]# istioctl verify-install 
1 Istio control planes detected, checking --revision "default" only
✔ HorizontalPodAutoscaler: istio-ingressgateway.istio-system checked successfully
✔ Deployment: istio-ingressgateway.istio-system checked successfully
✔ PodDisruptionBudget: istio-ingressgateway.istio-system checked successfully
✔ Role: istio-ingressgateway-sds.istio-system checked successfully

```





