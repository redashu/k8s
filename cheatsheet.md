✅ 1. Get Pod Name
```bash
kubectl get pod pod1 -o jsonpath='{.metadata.name}'
```

## ✅ 2. Get Pod IP
```bash
kubectl get pod pod1 -o jsonpath='{.status.podIP}'
```

## ✅ 3. Get Node Name (where pod is scheduled)
```bash
kubectl get pod pod1 -o jsonpath='{.spec.nodeName}'
```

## ✅ 4. Get Container Image

If the pod has one container:

```bash
kubectl get pod pod1 -o jsonpath='{.spec.containers[0].image}'
```

If multiple containers, list all:

```bash
kubectl get pod pod1 -o jsonpath='{range .spec.containers[*]}{.image}{"\n"}{end}'
```

## ✅ 5. Get Pod Status
```bash
kubectl get pod pod1 -o jsonpath='{.status.phase}'
```

## ✅ 6. Get Pod Labels
```bash
kubectl get pod pod1 -o jsonpath='{.metadata.labels}'
```

## ✅ 7. Get Pod Annotations
```bash
kubectl get pod pod1 -o jsonpath='{.metadata.annotations}'
```

## ✅ 8. Get Container Name(s)
```bash
kubectl get pod pod1 -o jsonpath='{.spec.containers[*].name}'
```

## ✅ 9. Get Container Ports
```bash
kubectl get pod pod1 -o jsonpath='{.spec.containers[*].ports[*].containerPort}'
```

## ✅ 10. Full dump but readable (pretty-print JSON)
```bash
kubectl get pod pod1 -o json | jq
```

*(Requires jq installed)*

## ⭐ Bonus: Combine fields in one line

Example → Name + IP + Image
```bash
kubectl get pod pod1 -o jsonpath='{.metadata.name}{" : "}{.status.podIP}{" : "}{.spec.containers[0].image}'
```

Example → All container images (multi-container pod)
```bash
kubectl get pod pod1 -o jsonpath='{range .spec.containers[*]}{.name}{" -> "}{.image}{"\n"}{end}'
```