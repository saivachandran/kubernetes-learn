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
  
  
   
   
           
        
 
         
       
       
 
       
 
 

       


 
      
      
