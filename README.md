# Kubernetes :- The Production grade container orchestration  Engine 

## Scheduling  in  KUbernetes
###  By default pods are schedule automatically by <b> kube-schedular </b> on behalf of some steps 
<ul>
	<li> filtering  </li>
	<li> scoring   </li>
</ul>

###  Filtering -- to find the set of nodes where pods can be scheduled on behalf of multiple parameter like resources , pods and many more 
### then it will give score to nodes on behalf of filtering , nodes with highest score will get the pods
### if the score is same for all the nodes then it will randomly schedule :
### you can find more on  kube-schedular  [kubernetes_schedular](https://kubernetes.io/docs/concepts/scheduling/kube-scheduler) <br/>

## Scheduling a POd on a particular node 
```
 kubectl create -f  schedule_at_create.yml
```

## Using NodeSelector to schedule to pod
```
[root@station132 k8s]# kubectl label nodes node3.example.com  name1=ssd1  --overwrite
```

###  Step 1  add  nodeSelector in yaml file 
```
[root@station132 k8s]# cat  schedule_at_create.yml 
apiVersion: v1
kind: Pod
metadata:
 name: pod1
 labels:
  name: helloapp

spec:
 containers:
  - image: nginx
    name: c1
    ports:
     - containerPort: 80
    imagePullPolicy: IfNotPresent
 nodeSelector:           # added line 
  name1: ssd1             # added line 
 restartPolicy: Always
```

### Use kubectl apply  command 
```
[root@station132 k8s]# kubectl replace --force -f  schedule_at_create.yml 
pod "pod1" deleted
pod/pod1 replaced
```

###  check the pod1 now is rescheduled 
```
[root@station132 k8s]# kubectl get pods -o wide
NAME                   READY   STATUS    RESTARTS   AGE   IP                NODE                NOMINATED NODE
counter                1/1     Running   0          54m   192.168.11.80     node1.example.com   <none>
counter1               1/1     Running   0          49m   192.168.221.2     node2.example.com   <none>
de                     1/1     Running   0          83m   192.168.178.235   node3.example.com   <none>
de1-65c4d85d96-n7d2k   1/1     Running   0          82m   192.168.11.84     node1.example.com   <none>
de2-6675f9dbf8-72sc4   1/1     Running   0          82m   192.168.178.239   node3.example.com   <none>
de3                    1/1     Running   0          81m   192.168.221.6     node2.example.com   <none>
pod1                   1/1     Running   0          13s   192.168.178.236   node3.example.com   <none>
```

