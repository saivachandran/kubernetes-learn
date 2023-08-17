LAB: Creating users and groups using x509 certificates
Creating Kubernetes Users and Groups
Generate the user's private key
```
mkdir -p  ~/.kube/users
cd ~/.kube/users
 
openssl genrsa -out maya.key 2048
openssl genrsa -out kim.key 2048
openssl genrsa -out yono.key 2048

```

 
[sample Output]

openssl genrsa -out maya.key 2048
Generating RSA private key, 2048 bit long modulus
.............................................................+++
.........................+++
e is 65537 (0x10001)
 
Lets now create a Certification Signing Request (CSR) for each of the users. When you generate the csr make sure you also provide

CN: This will be set as username

O: Org name. This is actually used as a group by kubernetes while authenticating/authorizing users. You could add as many as you need

e.g.
```
openssl req -new -key maya.key -out maya.csr -subj "/CN=maya/O=ops/O=example.org"
openssl req -new -key kim.key -out kim.csr -subj "/CN=kim/O=dev/O=example.org"
openssl req -new -key yono.key -out yono.csr -subj "/CN=yono/O=interns/O=example.org"
```
 
In order to be deemed authentic, these CSRs need to be signed by the Certification Authority (CA) which in this case is Kubernetes Master. You need access to the folllwing files on kubernetes master.

Certificate : ca.crt (kubeadm) or ca.key (kubespray)

Pricate Key : ca.key (kubeadm) or ca-key.pem (kubespray)

You would typically find it at one of the following paths

/etc/kubernetes/pki (kubeadm)

/etc/kubernetes/ssl (kubespray)

To verify which one is your cert and which one is key, use the following command,
```
$ file ca.pem
ca.pem: PEM certificate
```
 
``` 
$ file ca-key.pem
ca-key.pem: PEM RSA private key
```
Once signed, .csr files with added signatures become the certificates that could be used to authenticate.

You could either

move the crt files to k8s master, sign and download

copy over the CA certs and keys to your management node and use it to sign. Make sure to keep your CA related files secure.

In the example here, I have already downloaded ca.pem and ca-key.pem to my management workstation, which are used to sign the CSRs.

Assuming all the files are in the same directory, sign the CSR as,
```
openssl x509 -req -CA ca.pem -CAkey ca-key.pem -CAcreateserial -days 730 -in maya.csr -out maya.crt
 
openssl x509 -req -CA ca.pem -CAkey ca-key.pem -CAcreateserial -days 730 -in kim.csr -out kim.crt
 
openssl x509 -req -CA ca.pem -CAkey ca-key.pem -CAcreateserial -days 730 -in yono.csr -out yono.crt
```
Setting up User configs with kubectl
In order to configure the users that you created above, following steps need to be performed with kubectl

Add credentials in the configurations

Set context to login as a user to a cluster

Switch context in order to assume the user's identity while working with the cluster

to add credentials,

```

kubectl config set-credentials maya --client-certificate=/absolute/path/to/maya.crt --client-key=/absolute/path/to/maya.key
 
kubectl config set-credentials kim --client-certificate=/absolute/path/to/kim.crt --client-key=~/.kube/users/kim.key
 
kubectl config set-credentials yono --client-certificate=/absolute/path/to/yono.crt --client-key=~/.kube/users/yono.key

```
 
where,

Replace /absolute/path/to/ with the path to these files.

invalid : ~/.kube/users/yono.crt

valid : /home/xyz/.kube/users/yono.crt

And proceed to set/create contexts (user@cluster). If you are not sure whats the cluster name, use the following command to find,

kubectl config get-contexts
 
[sample output]

CURRENT   NAME                          CLUSTER         AUTHINFO              NAMESPACE
          admin-prod           prod   admin-cluster.local   instavote
          admin-cluster4                cluster4        admin-cluster4        instavote
*         kubernetes-admin@kubernetes   kubernetes      kubernetes-admin      instavote
where, prod, cluster4 and kubernetes are cluster names.

To set context for prod cluster,

```

kubectl config set-context maya-prod --cluster=prod  --user=maya --namespace=instavote
 
kubectl config set-context kim-prod --cluster=prod  --user=kim --namespace=instavote
 
kubectl config set-context yono-prod --cluster=prod  --user=yono --namespace=instavote

```
 
Where,

maya-prod : name of the context

prod : name of the kubernetes cluster you set while creating it

maya : user you created and configured above to connect to the cluster

You could verify the configs with
```

kubectl config get-contexts

 
CURRENT   NAME         CLUSTER   AUTHINFO     NAMESPACE
*         admin-prod   prod      admin-prod
          kim-prod     prod      kim
          maya-prod    prod      maya
          yono-prod    prod      yono
and
```
```
kubectl config view


apiVersion: v1
clusters:
- cluster:
   certificate-authority-data: REDACTED
   server: https://128.199.248.240:6443
 name: prod
contexts:
- context:
   cluster: prod
   user: admin-prod
 name: admin-prod
- context:
   cluster: prod
   user: kim
 name: kim-prod
- context:
   cluster: prod
   user: maya
 name: maya-prod
- context:
   cluster: prod
   user: yono
 name: yono-prod
current-context: admin-prod
kind: Config
preferences: {}
users:
- name: admin-prod
 user:
   client-certificate-data: REDACTED
   client-key-data: REDACTED
- name: maya
 user:
   client-certificate: users/~/.kube/users/maya.crt
   client-key: users/~/.kube/users/maya.key
```
You could assume the identity of user yono and connect to the prod cluster as,
```
kubectl config use-context yono-prod
 
kubectl config get-contexts

```
 
CURRENT   NAME         CLUSTER   AUTHINFO     NAMESPACE
          admin-prod   prod      admin-prod
          kim-prod     prod      kim
          maya-prod    prod      maya
*         yono-prod    prod      yono
And then try running any command as,

kubectl get pods
Alternately, if you are a admin user, you could impersonate a user and run a command with that literally using --as option

kubectl config use-context admin-prod
kubectl get pods --as yono
[Sample Output]

No resources found.
Error from server (Forbidden): pods is forbidden: User "yono" cannot list pods in the namespace "instavote"
 
Either ways, since there are authorization rules set, the user can not make any api calls. Thats when you would create some roles and bind it to the users in the next section.

