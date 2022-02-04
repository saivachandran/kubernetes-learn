# minikube setup

     minikube status

# verify the number of nodes

       sudo kubectl get nodes
       
# check kubectl version

      kubectl version
      
# list the pod

     kubectl get pods
     
# view service

     kubectl get service
     
# create nginx deployment

      kubectl create deployment nginx-depl --image=nginx
      
      kubectl get deployment      
      
      kubectl get pods
      
      kubectl get replicaset
      
# update the image version 


       kubectl edit deployment nginx-depl
      
 search image change image:nginx to image:nginx1.16
      
 save configuration file  
 
# debugging pods

      kubectl logs mongo-depl-85ddc6d66-cmg2f
      
      kubectl describe pod mongo-depl-85ddc6d66-cmg2f
      
      
 # Get terminal of mongodb application
 
         kubectl exec -it mongo-depl-85ddc6d66-cmg2f -- /bin/bash
         
 # Delete deployment 
 
        kubectl delete deployment mongo-depl
        
        
 # create deployment using declerative format
 
 
          kubectl apply -f nginx.yml
          
  edit configuration file and change to number of replicas to 2
  
  
         kubectl apply -f nginx.yml
         
         kubectl get replicaset
         
# Delete with configuration file 

       kubectl delete -f ngnix.yml
       
       
# Each configuration files has 3 parts

     1. Metadata
     2. specification
     3. status - match desired state with actual state 
     
     status data fetch from etcd, etcd store the curent state of k8s component
     
     
 # yaml configuration file
 
       human friendly data serialization standard for all programming language
       
       syntax strict indentation
       
       store the config files with your code or github
       
       template is a blueprint for pod
       
       connection established using labels and selector
       
       
 # create deployment with service
 
       kubectl apply -f ngnix.yml 
       kubectl apply -f service.yml
       
# get deployment with yaml file format

       kubectl get deployment nginx -o yaml > nginx-deployment-result.yaml
       
       
# view service end points

        kubectl describe service deploymnt-web-server-service
        
# view pod ip address


      kubectl get pod -o wide
     
# get replicaset

       kubectl get replicaset
       
# get service

       kubectl get service
       
     

    
        
# delete deployment and service using file

       kubectl delete -f ngnix.yml
       kubectl delete -f service.yml 


       
       
     
     
     
      
      
  
  
   
   
           
        
 
         
       
       
 
       
 
 

       


 
      
      
