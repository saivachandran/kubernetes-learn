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
       
    * pod

        Basic unit in kubernets is a pod, pod is smallest unit in kubernetes  
        
        pod is abstraction over a container
        
        pod is create running enviroment or create layer on top of the container
        
        pod purpose to run one application container at time 
        
        
        
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

# ConfigMaps

A ConfigMap is an API object used to store non-confidential data in key-value pairs. Pods can consume ConfigMaps as environment variables, command-line arguments, or as configuration files in a volume.

A ConfigMap allows you to decouple environment-specific configuration from your container images, so that your applications are easily portable.


# secret

 1. secret just like configmap but store secret base64 encoded format
 2. use as a enviroment variable or property file
 
# volumes


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


# What is stateful and stateless in Kubernetes

   
1. Stateful vs Stateless Applications on Kubernetes. A stateless application is one which depends on no persistent storage. The only thing your cluster is responsible for is the code, and other static content, being hosted on it. That's it, no changing databases, no writes and no left over files when the pod is deleted.


2. Stateful applications save data to persistent disk storage for use by the server, by clients, and by other applications. An example of a stateful application is a database or key-value store to which data is saved and retrieved by other applications

3. One may also ask, what is a stateless container? Stateless Container. The stateless container manages stateless session beans, which, by definition, do not carry client-specific states. All session beans (of a particular type) are considered equal. A stateless session bean container uses a bean pool to service requests.

4. A stateless app is an application program that does not save client data generated in one session for use in the next session with that client. In contrast, a stateful application saves data about each client session and uses that data the next time the client makes a request.

# What is the difference between StatefulSet and deployment

Deployment is a resource to deploy a stateless application, if using a PVC, all replicas will be using the same Volume and none of it will have its own state. Statefulsets is used for Stateful applications, each replica of the pod will have its own state, and will be using its own Volume.
 
# What is DaemonSet
DaemonSet. A DaemonSet ensures that all (or some) Nodes run a copy of a Pod. As nodes are added to the cluster, Pods are added to them. As nodes are removed from the cluster, those Pods are garbage collected. running a cluster storage daemon, such as glusterd , ceph , on each node.









 


    






   
   
