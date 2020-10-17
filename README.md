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

# Monitoring in K8s 

## random docs -- need to change 

## prometheus server :-

```
docker run \
    -p 9090:9090 \
    -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus
    
```

## Node Exporter 

```
docker run -d \
  --net="host" \
  --pid="host" \
  -v "/:/host:ro,rslave" \
  quay.io/prometheus/node-exporter \
  --path.rootfs=/host
  
```

## grafana 

```
docker run -d -p 3000:3000 --name grafana grafana/grafana

```

## Some info about grafana 

```
Important changes

File ownership is no longer modified during startup with chown.
Default user ID is now 472 instead of 104.
Removed the following implicit volumes:
/var/lib/grafana
/etc/grafana
/var/log/grafana

```

---

```
# in the container you just started:
chown -R root:root /etc/grafana && \
chmod -R a+r /etc/grafana && \
chown -R grafana:grafana /var/lib/grafana && \
chown -R grafana:grafana /usr/share/grafana

```

