## Creating cluster from CLI 

### Azure login from CLI 

```
az login
```

### set your subscription if you have multiple 

```
az account set --subscription "Your Subscription Name or ID"

```
### creating resource group 

```
az group create --name myResourceGroup --location eastus
```

### listing your resource group 

```
az group list --output table

```

### Creating AKS cluster 

```
az aks create -g container-expertise -n myAKSCluster --enable-managed-identity --node-count 1 --enable-addons monitoring --generate-ssh-keys
```

### listing AKS cluster 

```
az aks list --output table

```

### Getting aks credentials

```
 az aks get-credentials --resource-group container-expertise  --name myAKSCluster
```

### Testing connection 

```
kubectl get nodes
```

## NodePool Expertise 

### listing nodepool 

```
 az aks nodepool list --resource-group container-expertise  --cluster-name myAKSCluster --output table

Name       OsType    KubernetesVersion    VmSize           Count    MaxPods    ProvisioningState    Mode
---------  --------  -------------------  ---------------  -------  ---------  -------------------  ------
nodepool1  Linux     1.26.6               Standard_DS2_v2  1        110        Succeeded            System

```

### scaling nodes in nodepool

```
az aks nodepool scale --resource-group container-expertise --cluster-name myAKSCluster --name nodepool1 --node-count 3
```

### Creating a new nodepool of linux type 

```
az aks nodepool add \
  --resource-group container-expertise \
  --cluster-name myAKSCluster \
  --name mynewpool \ 
  --node-count 1 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 3 \
  --node-vm-size Standard_DS2_v2
```

### listing node pool 

```
 az aks nodepool list --resource-group container-expertise  --cluster-name myAKSCluster --output table
Name       OsType    KubernetesVersion    VmSize           Count    MaxPods    ProvisioningState    Mode
---------  --------  -------------------  ---------------  -------  ---------  -------------------  ------
mynewpool  Linux     1.26.6               Standard_DS2_v2  1        110        Succeeded            User
nodepool1  Linux     1.26.6               Standard_DS2_v2  3        110        Succeeded            System
```

### Deleting aks cluster

```
az aks delete --resource-group container-expertise --name myAKSCluster

```
