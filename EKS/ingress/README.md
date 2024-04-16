## URL FOR eks Ingress controller by Nginx 

[click_here](https://aws.amazon.com/blogs/opensource/network-load-balancer-nginx-ingress-controller-eks/)

## Demo 
### creating a 2 deployment 

```
kubectl apply -f https://raw.githubusercontent.com/cornellanthony/nlb-nginxIngress-eks/master/apple.yaml
===
kubectl apply -f https://raw.githubusercontent.com/cornellanthony/nlb-nginxIngress-eks/master/banana.yaml
```

### verify 

```
 kubectl get po,svc
NAME             READY   STATUS    RESTARTS   AGE
pod/apple-app    1/1     Running   0          49m
pod/banana-app   1/1     Running   0          49m
pod/pod1         1/1     Running   0          65m

NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/apple-service    ClusterIP   10.100.226.165   <none>        5678/TCP   49m
service/banana-service   ClusterIP   10.100.53.22     <none>        5678/TCP   49m
```

### creating self singed SSL 

```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes -subj "/O=adhoc/CN=test11.adhocnet.org"
```
### Creating ingress rule 

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "false"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - test11.adhocnet.org
    secretName: tls-secret    
  rules:
  - host: test11.adhocnet.org
    http:
      paths:
      - path: /apple
        pathType: Prefix
        backend:
          service:
            name: apple-service
            port:
              number: 5678
      - path: /banana
        pathType: Prefix
        backend:
          service:
            name: banana-service
            port:
              number: 5678



```

### Now you can test it 

```
 kubectl get ing
NAME              CLASS   HOSTS                 ADDRESS                                                                          PORTS     AGE
minimal-ingress   nginx   test11.adhocnet.org   afc84ba82878844afbfa26c4c1967fd0-4cf1c0df31c15694.elb.ap-south-1.amazonaws.com   80, 443   11m
➜  ~ 

```