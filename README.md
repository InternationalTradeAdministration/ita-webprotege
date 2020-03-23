# WebProtégé

This image allows you to deploy [WebProtégé][webprotege] as a [microservice][microservice].

WebProtégé is a free, open-source ontology editor and framework for building intelligent systems.

## How to

To start a new instance :

    docker run --name webprotege -d -v webprotege_data:/data/webprotege --link mongodb -p 8888:8080 docker.io/skyplabs/webprotege

The web application will be accessible from the host system on port *8888*. All the persistent data will be stored in a volume managed by Docker and called *webprotege_data*. *mongodb* must be the name of a [MongoDB][mongodb] docker container listening on port *27017*.

To start a MongoDB instance using Docker (must be started before WebProtégé) :

    docker run --name mongodb -d -v mongodb_data:/data/db mongo:3

All the persistent data will be stored in a volume managed by Docker and called *mongodb_data*.

To start the two containers using only one command, you can use [Docker Compose][docker-compose] :

    docker-compose up -d

## Customise the configuration

You can customise the configuration of WebProtégé by injecting the [`webprotege.properties`][webprotege-properties] and/or [`mail.properties`][mail-properties] files into the container using the volume command. The files must be placed in `/usr/local/tomcat/webapps/ROOT/WEB-INF/classes`.

For example :

    export WP_CONFIG_DIR=/usr/local/tomcat/webapps/ROOT/WEB-INF/classes
    docker run --name webprotege -d -v webprotege_data:/data/webprotege -v $(pwd)/config/webprotege.properties:${WP_CONFIG_DIR}/webprotege.properties:ro --link mongodb -p 8888:8080 docker.io/skyplabs/webprotege

The following values must be set in `webprotege.properties` :

* `application.host`
* `data.directory`
* `application.version`

## License

[MIT][license]

 [docker-compose]: https://www.docker.com/products/docker-compose
 [license]: http://opensource.org/licenses/MIT
 [mail-properties]: https://github.com/SkypLabs/webprotege-dockerfile/blob/master/config/mail.properties
 [microservice]: https://en.wikipedia.org/wiki/Microservices
 [mongodb]: https://www.mongodb.com/
 [webprotege]: http://protege.stanford.edu/
 [webprotege-properties]: https://github.com/SkypLabs/webprotege-dockerfile/blob/master/config/webprotege.properties

## AKS Deployment

**Prerequisites**

* Azure CLI <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>
* Docker CLI <https://docs.docker.com/engine/reference/commandline/cli/>
* KUBECTL CLI (if deploying to AKS) <https://kubernetes.io/docs/tasks/tools/install-kubectl/>
* Azure Subscription
* Azure Container Registry (ACR)
* Azure Kubernetes Service (AKS)
* A DNS Zone has been configured with a sub-domain that points to an ingress controller in AKS
* An AKS Ingess Controller with TLS
  * Additional documentaion: <https://docs.microsoft.com/en-us/azure/aks/ingress-static-ip>

### Scripts & Configuration Files

1. Log in with the Azure CLI: ```az login```
1. Select the appropriate Subscription. Ex: ```az account set --subscription "Sample_Subscription"```
1. Get credentials. Ex: ````az aks get-credentials --resource-group my-resources --name myAKS --overwrite-existing````
1. Rename ```kube-config-template.yml``` to ```kube-config.yml``` and update it with the following:
        - image locations
        - namespace for each section
        - host names in the Ingress section
1. Update ```deploy-aks.sh``` with the appropriate Azure Container Registry and Azure Container Key
1. Execute ```deploy-aks.sh```
1. For Azure DevOps pipeline configuration, update: ```azure-pipelines.yml```

The application will be available at the following URL: [<http://ip-dns-name.location.cloudapp.azure.com>]
The location in the URL will be the location of the Kubernetes cluster. Ex: eastus, centralus, etc...
