## EKSCTL -- 

### EKS cluster manager tool 

### Creating cluster using CLI 

```
eksctl create cluster --name=cluster-2 --nodes=4 --kubeconfig=./kubeconfig.cluster-2.yaml

```

### Listing cluster 

```
eksctl get cluster
NAME		REGION		EKSCTL CREATED
cluster-2	us-east-1	True
```

### More details about cluster

```
eksctl get cluster --name cluster-2
NAME		VERSION	STATUS	CREATED			VPC			SUBNETS												SECURITYGROUPS		PROVIDER
cluster-2	1.25	ACTIVE	2024-04-12T04:22:36Z	vpc-02315fd72a7058617	subnet-016d17e18928437f9,subnet-01edfd9e00db588d3,subnet-04606488d51f8b8a8,subnet-0d03d8bb7c8e54c6c	sg-072dea849db6a62d2	EKS
```

### listing Nodegroup 

```
eksctl get nodegroup  --cluster cluster-2
CLUSTER		NODEGROUP	STATUS	CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID	ASG NAME		TYPE
cluster-2	ng-eb58d3d1	ACTIVE	2024-04-12T04:36:05Z	1		1		1			m5.large	AL2_x86_64	eks-ng-eb58d3d1-52c7684b-ab3c-ef54-fa79-692da9d4350c	managed

```

### changing min/max and Desired capacity 

```
 eksctl scale nodegroup --cluster cluster-2 --name ng-eb58d3d1 --nodes=2  --nodes-min=1 --nodes-max=4 
```
### verify 

```
eksctl get nodegroup  --cluster cluster-2  
CLUSTER		NODEGROUP	STATUS	CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID	ASG NAME		TYPE
cluster-2	ng-eb58d3d1	ACTIVE	2024-04-12T04:36:05Z	1		4		2			m5.large	AL2_x86_64	eks-ng-eb58d3d1-52c7684b-ab3c-ef54-fa79-692da9d4350c	managed
```

### verify using kubectl 

```
kubectl get nodes --kubeconfig  kubeconfig.cluster-2.yaml 
NAME                             STATUS   ROLES    AGE     VERSION
ip-192-168-19-216.ec2.internal   Ready    <none>   49s     v1.25.16-eks-5e0fdde
ip-192-168-51-230.ec2.internal   Ready    <none>   8m24s   v1.25.16-eks-5e0fdde
```

### add more nodes using eksctl within max nodes range

```
eksctl scale nodegroup --cluster cluster-2 --name ng-eb58d3d1 --nodes=3                              
2024-04-12 10:16:29 [ℹ]  scaling nodegroup "ng-eb58d3d1" in cluster cluster-2
2024-04-12 10:16:32 [ℹ]  initiated scaling of nodegroup
2024-04-12 10:16:32 [ℹ]  to see the status of the scaling run `eksctl get nodegroup --cluster cluster-2 --region us-east-1 --name ng-eb58d3d1`
➜  ~ 

```

## How to add fargate profile 

```
eksctl create fargateprofile --cluster=cluster-2 --name=ashu-fargate --namespace=default 
```

## How to list fargate profile 

```
eksctl get fargateprofile --cluster cluster-2
NAME		SELECTOR_NAMESPACE	SELECTOR_LABELS	POD_EXECUTION_ROLE_ARN										SUBNETS			TAGS	STATUS
ashu-fargate	default			<none>		arn:aws:iam::751136288263:role/eksctl-cluster-2-fargate-FargatePodExecutionRole-RSi10W7H2WpN	subnet-01edfd9e00db588d3,subnet-0d03d8bb7c8e54c6c	<none>	ACTIVE
➜  ~ 

```

### Deleting fargate profile

```
eksctl  delete  fargateprofile --name ashu-fargate --cluster cluster-2
```

### Deleting Nodegroup 

```
eksctl delete nodegroup --name ng-eb58d3d1  --cluster cluster-2
```

### Deleting cluster 

```
eksctl delete cluster --name cluster-2

2024-04-12 11:08:42 [ℹ]  deleting EKS cluster "cluster-2"
2024-04-12 11:08:45 [ℹ]  deleted 0 Fargate profile(s)
2024-04-12 11:08:48 [ℹ]  cleaning up AWS load balancers created by Kubernetes objects of Kind Service or Ingress
2024-04-12 11:08:54 [ℹ]  1 task: { delete cluster control plane "cluster-2" [async] }
2024-04-12 11:08:55 [ℹ]  will delete stack "eksctl-cluster-2-cluster"
2024-04-12 11:08:56 [✔]  all cluster resources were deleted 
```

## Creating Cluster using cluster.yaml file 

```
 eksctl git:(master) ✗ eksctl create cluster -f cluster.yaml    
 
                      
2024-04-12 11:27:58 [ℹ]  eksctl version 0.175.0-dev+5b28c1794.2024-03-22T12:39:36Z
2024-04-12 11:27:58 [ℹ]  using region us-east-1
2024-04-12 11:28:00 [ℹ]  subnets for us-east-1a - public:192.168.0.0/19 private:192.168.128.0/19
2024-04-12 11:28:00 [ℹ]  subnets for us-east-1b - public:192.168.32.0/19 private:192.168.160.0/19
2024-04-12 11:28:00 [ℹ]  subnets for us-east-1c - public:192.168.64.0/19 private:192.168.192.0/19
2024-04-12 11:28:00 [ℹ]  subnets for us-east-1d - public:192.168.96.0/19 private:192.168.224.0/19

```