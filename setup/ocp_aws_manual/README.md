### Self-Managed OpenShift Container Platform (OCP) - For Full Control

This method provides granular control over the infrastructure but requires more manual setup of AWS components. You can use either Installer-Provisioned Infrastructure (IPI) or User-Provisioned Infrastructure (UPI).

#### Prerequisites

- An AWS account with administrative privileges
- A registered domain name managed by Amazon Route 53
- A Linux/Mac machine (bastion host recommended) with the AWS CLI, oc CLI, and OpenShift Installer binaries installed
- A Red Hat account to obtain a pull secret

#### Steps

**1. Configure AWS Account:**
- Set up a dedicated VPC, subnets, internet gateway, and NAT gateways (the IPI installer can do this automatically, but you must ensure your account limits are sufficient)
- Configure a public hosted zone in Route 53 for your cluster's base domain
- Create an IAM user with the required permissions and generate access keys

**2. Prepare Workstation:**
- Install the necessary CLIs: `aws`, `oc`, `openshift-install`

**3. Create Installation Configuration:**
- Run `openshift-install create install-config --dir=./`
- Follow the prompts to specify your AWS credentials, region, base domain, cluster name, and paste your Red Hat pull secret
- (For single-node OCP, edit the `install-config.yaml` file to set `controlPlane.replicas: 1` and `compute.replicas: 0`)

**4. Deploy the Cluster:**
- Run the installation command: `openshift-install create cluster --dir=./`
- The installer will provision all the required AWS infrastructure and deploy the OCP cluster

**5. Access the Cluster:**
- Upon completion (which can take 30+ minutes), the installer will output the kubeadmin credentials and web console URL
- You can then log in using the oc CLI or the web console