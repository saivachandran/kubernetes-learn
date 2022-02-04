# mongodb deployment

Requirement
----------

2 Deployment/pod
2 service
1 configmap
1 secret

# steps

 1. first we will create mongodb pod

 2. then we need a service, create a internal service which basically means no external request
  only cluster component can talk to each other
 
 3. then we create mongodb express deployment,it's a admin web based interactive tool to talk with

   mongodb or mongodb url to access db through web

 4. create credential to authenticate with database the way pass the credential via deployment file   using enviroment variable

 5. we are using configmap it's contain db url and secrets for passwords , we refer both inside of the deployment file

 6. once all setup done we need mongodb express to access db via browser in order to do that

   we need external service, that allow external access talk to the pod

 7. url should be ip address of node and port of external service

# browser rquest flow throuh the k8s components

browser-mongo-express --> mongo-external-service -->  mongo-express-pod --> Mongdb-internal-service--> mongodb-service

  
