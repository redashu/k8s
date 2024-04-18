### RBAC in EKS 

## Note: same thing 
-- IN EKS -- system:masters 
-- IN K8s -- cluster-admin 

## Creating an IAM user in aws console with programming access 

### creating a role & rolebinding in EKS 

```
dynamic-provisioning git:(master) kubectl get roles                  
NAME             CREATED AT
developer-role   2024-04-17T23:57:47Z
➜  dynamic-provisioning git:(master) kubectl get rolebindings
NAME               ROLE                  AGE
eks-developer-rb   Role/developer-role   48s
```

### Adding user to aws-auth configmap 

```
* AWS auth configmap allows to add Role-based access control access to IAM users and roles.
* Use the following command to edit configmap.
```

### checking cm in kube-system namespace 

```
dynamic-provisioning git:(master) kubectl  get cm -n kube-system 
NAME                                                   DATA   AGE
amazon-vpc-cni                                         7      2d15h
aws-auth                                               1      2d14h
coredns                                                1      2d15h
extension-apiserver-authentication                     6      2d16h
kube-apiserver-legacy-service-account-token-tracking   1      2d16h
kube-proxy                                             1      2d15h
kube-proxy-config                                      1      2d15h
kube-root-ca.crt                                       1      2d16h
➜  dynamic-provisioning git:(master) 

```

### Edit aws-auth cm and add below lines 

```
kubectl edit  cm aws-auth -n kube-system 
====>>
mapUsers: |
    - userarn: arn:aws:iam::1234567689:user/ashu-dev
      username: ashu-dev
```

## Now testing

### pod 
```
kubectl get po --as  ashu-dev
NAME   READY   STATUS    RESTARTS   AGE
app    0/1     Pending   0          6h46m
```

### deployment 

```
kubectl get deploy --as  ashu-dev
No resources found in ashu-apps namespace.

```

### lets try service 

```
kubectl get svc --as  ashu-dev
Error from server (Forbidden): services is forbidden: User "ashu-dev" cannot list resource "services" in API group "" in the namespace "ashu-apps"

```

### we can add profile in .aws/credential file


```
[default] # root cred
aws_access_key_id =  
aws_secret_access_key = D


[ashu-dev] # ashu-user cred
aws_access_key_id =  AKI
aws_secret_access_key = iWf
```

### checking profile using aws 

```
export AWS_PROFILE="ashu-dev"
aws sts get-caller-identity
```

### now checking 

```
 kubectl get po
NAME   READY   STATUS    RESTARTS   AGE
app    0/1     Pending   0          7h
➜  dynamic-provisioning git:(master) kubectl get svc
Error from server (Forbidden): services is forbidden: User "ashu-dev" cannot list resource "services" in API group "" in the namespace "ashu-apps"

```

## Important 

### TO give cluster-level access to any iam user 

** system:masters -- cluster-role by aws IAM in EKS 
** cluster-admin --  cluster-role by CNCF in any k8s 

## so iam user ashu-dev can have cluster admin access using both 
### method 1 

```
kubectl  create clusterrolebinding  new-power --clusterrole=cluster-admin --user=ashu-dev 
```

### method 2 : 

```
apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::751136288263:role/roche-eks-dataplane
      username: system:node:{{EC2PrivateDNSName}}
  mapUsers: |
    - userarn: arn:aws:iam::751136288263:user/ashu-dev
      username: ashu-dev
      groups:
      - system:masters
kind: ConfigMap

```

### note : apply above config 
