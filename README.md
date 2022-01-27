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

## Kubernetes SSL based application Hosting --

### Cert-manager 

<img src="cert.png">

### kubernetes Nativ controller for SSL 

<img src="cert1.png">

##  SSL SETUP for webapp

### Deploy ingress 

```
kubectl apply -f  nginx-ingress-controller.yaml 
```

### create self sign certificate --

```
openssl req -x509 -newkey rsa:4096  -keyout key.pem -out cert.pem -days 365 -nodes

```

### secret create and ingress rule 

```
kubectl create secrete tls secure-ingress --cert=cert.pe --key=key.pem 

```

### ingress rule 

```
kubectl apply -f secure-ingress-step2.yaml
```

