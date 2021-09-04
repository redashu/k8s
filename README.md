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

## Kubernetes multinode setup 
###  we have 4 machines; 1 master and 3 worker nodes

# HELM -- THis Docs is for Helm v3 only 

## After k8s 1.16 concept of tiller account gone so helm 3 doesn't required tiller account 

## INstall Helm3 

###  Prerequisite 

<ul>
	<li> You need k8s cluster running </li>
	<li> You need install helm on k8s client side </li>
	<li> Make sure you have kubectl and config file configure on client machine </li>
	
</ul>

### Helm alternatives 

<ul>
	<li> kustomize </li>
	<li> Draft </li>
	<li> GitKube </li>
	<li> ksonnet  </li>
	<li> Metaparticle </li>
	<li> Skaffold </li>

</ul>

### TO read more about them 

[Link](https://hasura.io/blog/draft-vs-gitkube-vs-helm-vs-ksonnet-vs-metaparticle-vs-skaffold-f5aa9561f948/)


### Helm public repositories 

[Artifcats](https://artifacthub.io/)
[jfrog repo](https://www.jfrog.com/confluence/display/JFROG/Kubernetes+Helm+Chart+Repositories)


### Helm things  to know 

<ul>
	<li> helm v3 don't need tiller account  </li>
	<li> we can use helm as template engine  </li>
	<li> public and private repo both we can configue  </li>
	<li> ksonnet  </li>
	<li> Metaparticle </li>
	<li> Skaffold </li>

</ul>


### HElm v2 architecture 

<img src="helm2arch.png">

### till account need alot of power so in v2 tiller got removed 

<img src="tillerv2.png">



## HElm 3 installation on client side 

```
brew install helm
```

## Some basic commands 

### checking version 

```
helm version
version.BuildInfo{Version:"v3.5.2", GitCommit:"167aac70832d3a384f65f9745335e9fb40169dc2", GitTreeState:"dirty", GoVersion:"go1.15.7"}

```

## helm need repo to deploy application 

### HElm listing repo 

```
❯ helm repo list
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami

```

### adding repo in helm 

```
helm repo add stable https://charts.helm.sh/stable

---

❯ helm repo list
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami
stable 	https://charts.helm.sh/stable    

```

### searching charts in repo 

```
❯ helm search repo mysql
NAME                            	CHART VERSION	APP VERSION	DESCRIPTION                                       
bitnami/mysql                   	6.14.3       	8.0.20     	Chart to create a Highly available MySQL cluster  
stable/mysql                    	1.6.9        	5.7.30     	DEPRECATED - Fast, reliable, scalable, and easy...
stable/mysqldump                	2.6.2        	2.4.1      	DEPRECATED! - A Helm chart to help backup MySQL...
stable/prometheus-mysql-exporter	0.7.1        	v0.11.0    	DEPRECATED A Helm chart for prometheus mysql ex...
bitnami/phpmyadmin              	6.2.0        	5.0.2      	phpMyAdmin is an mysql administration frontend    
stable/percona                  	1.2.3        	5.7.26     	DEPRECATED - free, fully compatible, enhanced, ...
stable/percona-xtradb-cluster   	1.0.8        	5.7.19     	DEPRECATED - free, fully compatible, enhanced, ...
stable/phpmyadmin               	4.3.5        	5.0.1      	DEPRECATED phpMyAdmin is an mysql administratio...
bitnami/mariadb                 	7.5.1        	10.3.23    	Fast, reliable, scalable, and easy to use open-...
bitnami/mariadb-cluster         	1.0.1        	10.2.14    	Chart to create a Highly available MariaDB cluster
bitnami/mariadb-galera          	3.1.3        	10.4.13    	MariaDB Galera is a multi-master database clust...
stable/gcloud-sqlproxy          	0.6.1        	1.11       	DEPRECATED Google Cloud SQL Proxy                 
stable/mariadb                  	7.3.14       	10.3.22    	DEPRECATED Fast, reliable, scalable, and easy t...

```

### listing all charts in a repo 

```
❯ helm search repo bitnami
NAME                            	CHART VERSION	APP VERSION            	DESCRIPTION                                       
bitnami/bitnami-common          	0.0.8        	0.0.8                  	Chart with custom templates used in Bitnami cha...
bitnami/airflow                 	6.3.3        	1.10.10                	Apache Airflow is a platform to programmaticall...
bitnami/apache                  	7.3.17       	2.4.43                 	Chart for Apache HTTP Server                      
bitnami/cassandra               	5.4.2        	3.11.6                 	Apache Cassandra is a free and open-source dist...
bitnami/common                  	0.3.1        	0.3.1                  	A Library Helm Chart for grouping common logic ...
bitnami/consul                  	7.1.1        	1.7.4                  	Highly available and distributed service discov...
bitnami/dokuwiki                	6.0.18       	0.20180422.202005011246	DokuWiki is a standards-compliant, simple to us...
bitnami/drupal                  	7.0.0        	9.0.0                  	One of the most versatile open source content m...
bitnami/elasticsearch           	12.3.4       	7.7.1                  	A highly scalable open-source full-text search ...
bitnami/etcd                    	4.8.2        	3.4.9                  	etcd is a distributed key value store that prov...
bitnami/external-dns            	3.2.0        	0.7.2                  	ExternalDNS is a Kubernetes addon that configur...
bitnami/fluentd                 	1.2.1        	1.11.0                 	Fluentd is an open source data collector for un...
bitnami/ghost                   	10.0.8       	3.16.1                 	A simple, powerful publishing platform that all...
bitnami/grafana                 	2.0.1        	7.0.3                  	Grafana is an open source, feature rich metrics...
bitnami/harbor                  	6.0.0        	2.0.0                  	Harbor is an an open source trusted cloud nativ...
bitnami/influxdb                	0.5.0        	

```

### updating charts in HElp repo 

```
❯ helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈

```

### view a chart using helm 

```
❯ helm search repo stable |  grep -i ingress
stable/contour                       	0.2.2        	v0.15.0                	DEPRECATED Contour Ingress controller for Kuber...
stable/gce-ingress                   	1.2.2        	1.4.0                  	DEPRECATED A GCE Ingress Controller               
stable/ingressmonitorcontroller      	1.0.50       	1.0.47                 	DEPRECATED - IngressMonitorController chart tha...
stable/kong                          	0.36.7       	1.4                    	DEPRECATED The Cloud-Native Ingress and API-man...
stable/nginx-ingress                 	1.41.3       	v0.34.1                	DEPRECATED! An nginx Ingress controller that us...
stable/nginx-lego                    	0.3.1        	                       	Chart for nginx-ingress-controller and kube-lego  
stable/traefik                       	1.87.7       	1.7.26                 	DEPRECATED - A Traefik based Kubernetes ingress...
stable/voyager                       	3.2.4        	6.0.0                  	DEPRECATED Voyager by AppsCode - Secure Ingress...
❯ helm show chart  stable/nginx-ingress
apiVersion: v1
appVersion: v0.34.1
deprecated: true
description: DEPRECATED! An nginx Ingress controller that uses ConfigMap to store the nginx configuration.
home: https://github.com/kubernetes/ingress-nginx
icon: https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Nginx_logo.svg/500px-Nginx_logo.svg.png
keywords:
- ingress
- nginx
kubeVersion: '>=1.10.0-0'
name: nginx-ingress
sources:
- https://github.com/kubernetes/ingress-nginx
version: 1.41.3

```

## deploying using helm 

```
 helm install ingress  ingress-nginx/ingress-nginx 
```

### listing deployment 

```
 helm ls
NAME   	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART               	APP VERSION
ingress	default  	1       	2021-02-12 11:57:47.021183 +0530 IST	deployed	ingress-nginx-3.23.0	0.44.0     

```

### deleting deployment 

```
❯ helm uninstall ingress
release "ingress" uninstalled
❯ helm ls
NAME	NAMESPACE	REVISION	UPDATED	STATUS	CHART	APP VERSION


```

## Prometheus deployment 

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
 helm install prometheus prometheus-community/prometheus

```

## Grafana deployment 

```
 helm repo add grafana https://grafana.github.io/helm-charts
  helm install grafana stable/grafana
  
```

## dashboard deployment

```
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm install my-release kubernetes-dashboard/kubernetes-dashboard
```

### We can do like this as well

```
helm install kubernetes-dashboard/kubernetes-dashboard --name my-release --set=service.externalPort=8080,resources.limits.cpu=200m
  
```

### setting service account with clusterrole admin 

```
kubectl create clusterrolebinding dashboard-admin-sa   --clusterrole=cluster-admin   --serviceaccount=default:my-release-kubernetes-dashboard
```

### Deleting chart 

```
helm delete my-release
```


### Helm charts structure 

<img src="charts1.png">

### helm charts more info 

<img src="charts2.png">

### pulling charts from repo 

```
❯ helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" has been added to your repositories
❯ helm repo ls
NAME   	URL                               
bitnami	https://charts.bitnami.com/bitnami
❯ helm pull bitnami/nginx
❯ ls
       mychart
       nginx-9.5.3.tgz
                          
❯ tar xvzf  nginx-9.5.3.tgz


❯ cd  nginx
❯ ls
Chart.lock         Chart.yaml         README.md          charts             ci                 templates          values.schema.json values.yaml

░▒▓ /tmp/nginx

```

## Creating a helm charts 

### step 1 

```
 helm create  <chartname>
 ===
  helm create  mychart
```

### Step 2 :-  checking directory structure 

```
❯ helm create  devops
Creating devops
❯ ls -R devops
Chart.yaml  charts      templates   values.yaml

devops/charts:

devops/templates:
NOTES.txt           deployment.yaml     ingress.yaml        serviceaccount.yaml
_helpers.tpl        hpa.yaml            service.yaml        tests

devops/templates/tests:
test-connection.yaml

```

###  step 3 :- removing all template directory content except (_helpers.tpl )

```
cd  devops 
rm -rvf *.yaml 
rm -rf tests
```

### step 4 copy your  YAML data to templates directory 


### step 5 : check helm charts structure is correct or not 

```
helm template  <chart_name>  <chart_directory_name>
=====
helm template  devops  devops 
```

## Deployment using chart 

```
❯ helm install mychart  mychart
NAME: mychart
LAST DEPLOYED: Sat Sep  4 13:11:43 2021
NAMESPACE: ashu-space
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace ashu-space -l "app.kubernetes.io/name=mychart,app.kubernetes.io/instance=mychart" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace ashu-space $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl --namespace ashu-space port-forward $POD_NAME 8080:$CONTAINER_PORT
  
  
```

### list of deployed / released charts 

```
❯ helm list
NAME   	NAMESPACE 	REVISION	UPDATED                             	STATUS  	CHART        	APP VERSION
mychart	ashu-space	1       	2021-09-04 13:11:43.157493 +0530 IST	deployed	mychart-0.1.0	1.16.0     
```

### details about charts 

```
❯  helm show chart mychart
apiVersion: v2
appVersion: 1.16.0
description: A Helm chart for Kubernetes
name: mychart
type: application
version: 0.1.0

```

### helm uninstall 

```
helm uninstall lnbchart
```

## Helm advanced 

### dynamic values using value 

```


```
