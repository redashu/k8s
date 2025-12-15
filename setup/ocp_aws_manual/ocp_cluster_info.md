# OpenShift Container Platform (OCP) on AWS - Production Setup Guide

Below is a production-grade, Vodafone-style step-by-step approach to set up OpenShift Container Platform (OCP) on AWS.
This is not a quick lab — it's the real enterprise delivery flow you would follow.

**Assumptions:**
- OCP 4.x
- AWS IPI (Installer-Provisioned Infrastructure) – preferred in enterprises
- Multi-AZ, HA
- Strong security & governance

---

## PHASE 0 – Design & Prerequisites (Do NOT skip)

### 0.1 Decide Architecture

For Vodafone-scale environments:
- 1 cluster per environment (dev / test / prod)
- Multi-AZ (minimum 3 AZs)
- Separate AWS accounts per environment (recommended)

**Cluster sizing (example):**
- **Control Plane:** 3 × m5.xlarge
- **Workers:** 3–6 × m5.2xlarge (scale later)

---

## PHASE 1 – AWS Prerequisites

### 1.1 AWS Account & IAM

Create or confirm:
- Dedicated AWS account
- IAM user/role with:
    - EC2
    - ELB
    - IAM
    - Route53
    - S3
    - VPC
    - EBS
    - CloudWatch

> ⚠️ **Warning:** In production, use IAM Role + STS, not static keys.

### 1.2 Networking (Enterprise-grade)

You have two options:

#### Option A – Let Installer Create VPC (simpler)
- Recommended for first cluster
- Installer creates:
    - VPC
    - Public & private subnets
    - Route tables
    - NAT gateways

#### Option B – Bring Your Own VPC (Vodafone-style)
Pre-create:
- VPC
- 3 public subnets
- 3 private subnets
- Internet Gateway
- NAT Gateway

Ensure:
- CIDR does not overlap corporate network
- Proper tagging for OCP

### 1.3 DNS (Very Important)

Create public Route53 hosted zone:

**Example:**
```
openshift.vodafone.com
```

OCP will create:
- `api.openshift.vodafone.com`
- `*.apps.openshift.vodafone.com`

### 1.4 S3 Bucket (Registry & Assets)

Create S3 bucket for:
- Installer assets
- Optional backups

---

## PHASE 2 – OpenShift Installer Setup

### 2.1 Download Installer & CLI

On a bastion or admin VM:
- `openshift-install`
- `oc` (OpenShift CLI)

Ensure:
- Linux x86_64
- Internet access

### 2.2 Prepare install-config.yaml

This is the heart of the installation.

**Key sections:**

```yaml
baseDomain: vodafone.com
metadata:
    name: openshift

platform:
    aws:
        region: eu-west-1
        defaultMachinePlatform:
            type: m5.xlarge

controlPlane:
    name: master
    replicas: 3

compute:
- name: worker
    replicas: 3
    platform:
        aws:
            type: m5.2xlarge

networking:
    networkType: OVNKubernetes
    clusterNetwork:
    - cidr: 10.128.0.0/14
        hostPrefix: 23
    serviceNetwork:
    - 172.30.0.0/16
```

Add:
- SSH key
- Pull secret (from Red Hat)

---

## PHASE 3 – Cluster Installation

### 3.1 Run Installer

```bash
openshift-install create cluster --dir=ocp-install
```

**What happens:**
- Creates EC2 instances
- Sets up ELB
- Configures Route53
- Installs control plane
- Bootstraps cluster

⏱️ **Time:** 35–50 minutes

### 3.2 Validate Installation

After completion:

```bash
export KUBECONFIG=ocp-install/auth/kubeconfig
oc get nodes
oc get co
```

All ClusterOperators should be:
- `AVAILABLE=True`
- `DEGRADED=False`

---

## PHASE 4 – Day-1 Configuration (Mandatory)

### 4.1 Authentication

Integrate with:
- LDAP / Active Directory
- SSO (OIDC)
- Disable `kubeadmin` user after setup

### 4.2 RBAC Model

**Vodafone-style:**
- Platform Admins
- Security Admins
- App Teams (namespace-scoped)

Use:
- `ClusterRole`
- `RoleBinding`

### 4.3 Ingress & Certificates

Replace default certs with:
- Public CA or enterprise CA

Configure wildcard cert:
```
*.apps.openshift.vodafone.com
```

### 4.4 Storage

**Choose:**
- EBS (default)
- EFS (shared RWX)
- OpenShift Data Foundation (if needed)

**Create StorageClasses:**
- `gp3`
- `efs-sc`

---

## PHASE 5 – Day-2 Operations Setup

### 5.1 Monitoring & Logging

Enable:
- Cluster Monitoring
- User Workload Monitoring

Centralized logging:
- Loki or EFK

### 5.2 Backup & DR

- Install OADP (Velero)
- S3 as backend
- Regular namespace backups

### 5.3 GitOps

- Install ArgoCD (OpenShift GitOps)
- Git as single source of truth

---

## PHASE 6 – Security Hardening (Telecom Mandatory)

- NetworkPolicies (default deny)
- Pod Security Admission
- Image scanning
- Audit logs enabled
- CIS benchmarks

---

## PHASE 7 – Production Readiness Checklist

- [ ] Multi-AZ validated
- [ ] Node auto-scaling
- [ ] Cluster upgrade strategy
- [ ] Runbooks created
- [ ] On-call SOPs
