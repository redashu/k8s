## EBS in EKS 

### Implementing EBS CSI drivers -- Using EKSCTL 

## Steps 

### step 1 -- associate -- OIDC provider 

```
 eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=jpmc-cluster --approve
```

### Step 2 -- Creating IAM role for iamServiceAccount 

```
 eksctl create iamserviceaccount --name ebs-csi-controller-sa  --namespace kube-system  --cluster jpmc-cluster --role-name AmazonEKS_EBS_CSI_DriverRole   --role-only --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy    --approve
```

### Step 3 -- Installing EBS CSI driver add-ons

```
eksctl create addon --name aws-ebs-csi-driver --cluster jpmc-cluster --service-account-role-arn arn:aws:iam::751136288263:role/AmazonEKS_EBS_CSI_DriverRole --force
```

## Verify 

### ServiceAccount 

```
manifests git:(master) ✗ kubectl get sa -A | grep -i ebs
kube-system       ebs-csi-controller-sa                  0         18m
kube-system       ebs-csi-node-sa                        0         18m
```

### CSI driver pods 

```
manifests git:(master) ✗ kubectl get po -n kube-system | grep -i ebs
ebs-csi-controller-6847dfb6dd-mtmwz   6/6     Running   0          18m
ebs-csi-controller-6847dfb6dd-pzr84   6/6     Running   0          18m
ebs-csi-node-cfr2k                    3/3     Running   0          18m
ebs-csi-node-fk8mh                    3/3     Running   0          18m

```

### Now you can deploy application 

```
git clone https://github.com/kubernetes-sigs/aws-ebs-csi-driver.git

===>
cd aws-ebs-csi-driver/examples/kubernetes/dynamic-provisioning/

===>>
echo "parameters:
  type: gp3" >> manifests/storageclass.yaml


====>>
kubectl apply -f manifests/

```