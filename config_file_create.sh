# kube-apiserver URL 
server=https://172.31.11.159:6443
# name of secret for the namespace which service account you want to use
name=default-token-xfw5d

# ca cert of apiserver 
ca=$(kubectl get secret/$name -o jsonpath='{.data.ca\.crt}')
echo $ca
sleep 2

#  token of service account 
token=$(kubectl get secret/$name -o jsonpath='{.data.token}' | base64 --decode)
echo $token 
sleep 2

# name of namespace where your serviceaccount is there 
namespace=new
echo $namespace

#  script to create config file and then you can share with client  / admin / developer 

echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
" > sa.kubeconfig


