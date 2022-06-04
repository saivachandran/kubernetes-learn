# what is kubernetes

 1. Open Source Container Orchestration Tool
 2. originaly developed by google 
 3. Helps to managed containerized applications
 4. different deployment enviromrnt like pysical, virtual, cloud, hybrid
 5. what feature orchiestration tool offer High availability or no downtime , scalability or high performance , disaster recovery or backup and restore


# Namespaces

In Kubernetes, namespaces provides a mechanism for isolating groups of resources within a single cluster. Names of resources need to be unique within a namespace, but not across namespaces. Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc)


Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all. Start using namespaces when you need the features they provide.

Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces. Namespaces cannot be nested inside one another and each Kubernetes resource can only be in one namespace

# kubernetes compontents

 1. Node and pod

    * Node

       simple server physical or virtual machine
       
# pod

        Basic unit in kubernets is a pod, pod is smallest unit in kubernetes  
        
        pod is abstraction layer over a container
        
        pod is create running enviroment or create layer on top of the container
        
        pod purpose to run one application container at time 
        
        Each pod get it's own ip address
        
        pod get new ip address when pod dies and recreated
        
        
        
# kubernetes network

   1. kubernetes offer virtual network which means each pod get own ip address 
   2. each pod can communicate each other using ip address
   3. it's internal ip address not public one
   4. container can communicate with ip address using that ip address
   5. if pod die or run out of the resource it will create new pod and also get new ip
   6. every time new ip assigend it's difficault communicate with database
   7. to over come this kubernetes offer another component called service

# service 

  1. service can provide static ip address that can be attached to each pod
  2. even if pod die service and ip address remain same, so you don't have to change endpoint anymore
  3. if you want to access your application throuh bowser 
  4. we need to create external service and you don't want to expose your database outside for this you will create internal service
  5. if you wnat to access your url with secure domain name url, kubernetes offer another component called ingress
  6. pod can communicate each other using service


# ingress

An API object that manages external access to the services in a cluster, typically HTTP.

Ingress may provide load balancing, SSL termination and name-based virtual hosting.

![image](https://user-images.githubusercontent.com/42309948/159120016-e7df6f81-9936-4f2e-91ca-42508da5d7c0.png)



# ConfigMaps

configMap used for External configuration of your application

A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable.


# secret

 1. secret just like configmap but store secret base64 encoded format
 2. use as a enviroment variable or property file
 
# volumes (data storage)

 pod get restarted data is gone, you want to persist your database data and log, using volumes you can persist your data
 
 how volumes works attache physical drive into pods, it could be local storage, remote storage,cloud storage
 

 1. how it's work attach a physical storage to pod 
 2. storage either local machine or remote server or outside the kubernets cluster it could be cloud 
 3. if pod restarted all data get persisted 
 4. think storage is a external hardrive plugin in kubernetes cluster 
 5. if kubernetes doesn't manage persistence data as administrator we will responisble for backing data and replicate data


# ReplicaSet

A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods     

# When to use a ReplicaSet

A ReplicaSet ensures that a specified number of pod replicas are running at any given time. However, a Deployment is a higher-level concept that manages ReplicaSets and provides declarative updates to Pods along with a lot of other useful features. Therefore, we recommend using Deployments instead of directly using ReplicaSets, unless you require custom update orchestration or don't require updates at all.


 1. we are replicating single pod into multiple nodes it also connected to service
 2. service has two functionalites permanent static ip with dnsname 
 3. service also has loadbalancer, service cache the request forward which pod is available

# deployment

 1.  if you want to replicate pod, you won't create new pod, you just define number of replicas in declerative deployment file, deployment maintain the desire number of replicas always run at given time     
 2.  you can scaleup and scaledown as number of replicas you need
 3.  pod is layer of abtraction on top the container
 4.  Deployment another abtraction layer of pod
 5.  now one of the pod is die, service forward request to another pod
 6.  database can't be replicate using deployment reason for that database is data 
 7.  we need to clone database, require shared storage and to define 
 8.  which one write and which one read to avoid data inconsistence
 9.  that machanism offered by statefulset


# statefulset

  1. this component mainly used to replicate database
  2. mysql, mongodb,  elasticsearch
  
 * deployment for stateless application 
 * stateful for stateful apps or database 
 * Db are often used outside kubernetes cluster
 * we have two replicas for application and database incase one both pods rebooted are crashed still app and db accessible by another node untill two relicas recreated


# main kubernetes component

 1. pod is a abraction layer of container
 2. service - for kubbernetes resource communication we are using service
 3. ingress controller - route the traffic into cluster
 4. configmap - external configution using configmap
 5. secrets
 6. volume - for data persistence
 7. Deployments - pod blueprint with replicating mechanism 
 8. statefulset - stateful application specifically like database
 9. yes kubernetes offered lot of compontents


# kubernetes Architecture

![image](https://user-images.githubusercontent.com/42309948/152154355-bce4bae7-0b32-4d4b-b1c0-39631a21d359.png)


  1. we are going to look two types of master and worker nodes 

# worker machines in kubernetes cluster

  1. each node has multiple pod on it
  2. 3 process must be installed on every node, node is cluster service actaully do the work

        * first process need to run every node is container runtime, my example docker you can use anyone
        * Application pod container run inside process those schedule container is kubelet 
        * kubelet is a process itself in cluster, kubelet interact with both container and node
        * kubelet start the pod with container inside
        * usually kubernetes cluster made with multiple nodes it also must have container runtime and kubelet service
        * second process is service has loadbalancer cache the service and forwared to pod 
        * third process is forward request service to pod is kube proxy, kube proxy must be installed every node

      
 # how to interact with cluster 
 
       How to 
       
          1. schedule a pod
          2. monitor pod
          3. re-schedule/restart pod
          4.  Join a new node
          
  # managing process done master node in kubernetes  
  
     * four process done by every master node to control cluster node and worker node
     
         1. Api server
         
              when as user you want deploy a application run as a client
              Api server like a gateway of a cluster, interact with cluster using client like cli tool kubelet or api, it's get inital request like update or    eventhough query  from client 
              
              Act as a gatekeeper for authendication 
              
              some request example pod creation  -> Api server -> validate request ->  other process -> kubelet - schedule pod
              
         2. scheduler
         
            schedule a new pod -> Api server -> scheduler -> place the pod to node
            
            scheduler decide which specific pod have to place, first look request check how much resource application need schedule a pod 
            
            scheduler just decide which pod goes to which node, process actually does the scheduling is kueblet.
            
         3. controller manager
         
             pod dies any node controller manger detects state changes like crashes , try to recover pod state asap for this controller manager make the request to scheduler to recreate pod
             
         4. Etcd 
         
            Etcd is a key value store of the cluster state,  Etcd is a cluster brain, cluster changed store in etcd key value store, example pod creatred or pod dies all details store 
            
            all controller manager scheduler works because of  data 
            
            Application data not stored in etcd key value store
            
            Etcd store must be relaible store are replicated , kubernetes usually made multiple masters , apcourse api server act as load balancer etcd replicated across master
             
    

# What is stateful and stateless in Kubernetes

   
1. Stateful vs Stateless Applications on Kubernetes. A stateless application is one which depends on no persistent storage. The only thing your cluster is responsible for is the code, and other static content, being hosted on it. That's it, no changing databases, no writes and no left over files when the pod is deleted.


2. Stateful applications save data to persistent disk storage for use by the server, by clients, and by other applications. An example of a stateful application is a database or key-value store to which data is saved and retrieved by other applications

3. One may also ask, what is a stateless container? Stateless Container. The stateless container manages stateless session beans, which, by definition, do not carry client-specific states. All session beans (of a particular type) are considered equal. A stateless session bean container uses a bean pool to service requests.

4. A stateless app is an application program that does not save client data generated in one session for use in the next session with that client. In contrast, a stateful application saves data about each client session and uses that data the next time the client makes a request.

# What is the difference between StatefulSet and deployment

Deployment is a resource to deploy a stateless application, if using a PVC, all replicas will be using the same Volume and none of it will have its own state. Statefulsets is used for Stateful applications, each replica of the pod will have its own state, and will be using its own Volume.
 
# What is DaemonSet
DaemonSet. A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. running a cluster storage daemon, such as glusterd , ceph , on each node.


# what is minikube and kubectl how to set up

     in a production setup we go with multmaster and multi worker node with kubeadm
     
     in a test local enviroment we go with minikube
     
     minikube is a single node cluster both master process and worker process run on single node, node docker container runtime pre installed.
     
# kubectl

   kubectl is a commandline tool interact with kubernetes cluster create and delete,update manage pods 
   
   
   
 # layer of abstraction
 
      Deployment manages replicaset
      
      Replicaset manages pod
      
      pod abstraction lyaer of container
      
      every below deployment handled by kubernetes      
   

# Example cluster setup

![image](https://user-images.githubusercontent.com/42309948/162559246-2d3caa71-6c8a-4703-8ba4-831508f85697.png)

* Matser node uses less resources
* worker node actaully run all pods it's uses more resources

# minikube setup

* production setup we need alteast two master and three worker node

* minikube single node cluster both master and worker node run on same node
* node will have docker container runtime preinstalled
* minikube 1 node k8s cluster runs at virtual box


# kubectl is commandline tools for kubernetes cluster

Remeber run both master and worker process, Api server main entrypoint in kubernetes cluster

talk with api server ui or ap or cli


# layer of abstarction

1. Deployment manages replicaset
2. replicaset manages replicas of pod
3. pod abstarction layer of container

Everything below the deployment kubernetes automatically manages


# variables in python

variables are used to store values


# kubernets yaml configuration

 1. metadata
 2. specification
 3. status

# connections for yaml file

1. way connection esatbilished in k8s using labels and selector  



# Namespace

1. organise your resources using namespaces

2. virtual cluster inside a cluster 

```
kubectl get namespace

NAME              STATUS   AGE
default           Active   1d
kube-node-lease   Active   1d
kube-public       Active   1d
kube-system       Active   1d
```

```
    default The default namespace for objects with no other namespace
    kube-system The namespace for objects created by the Kubernetes system
    kube-public This namespace is created automatically and is readable by all users (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.
    kube-node-lease This namespace holds Lease objects associated with each node. Node leases allow the kubelet to send heartbeats so that the control plane can detect node failure.

```

3. Always good idea group your resources in namespaces

4. per namesapce we can define resource quota

# namespace usecases

1. structure your components

2. Avoid conflict between teams

3. share services diffrent Enviroment

4. Access and resource limits on namespace level

5. you can't access most resources from another namespaces

6. volume and node it's globally accessible not within namespace 


    






   
   
