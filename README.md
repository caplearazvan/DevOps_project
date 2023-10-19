# DevOps_project


## Docker project

This is a small docker file in which you'll find basic syntax in order:
* run a Dockerfiler
* run an image pulled from the DockerHub
* setup the working directory
## Docker compose

* command for runnign docker compose in detached mode: <br>
  <code>$docker-compose up -d</code> <br>
  <code>docker stack deploy --compose-file docker-stack.yaml</code> run a compose file (.yaml) containing the desired services)


### Docker stack
* scalling aplicaton ( create replicas of the application) eg: <code>docker update --replicas=10 service_name<code> <br>
* <code>$docker stack ls </code> - list the services that runs on workers

  ### NGINX
  NGINX is open source software for web serving, reverse proxying, caching, load balancing, media streaming, and more. It started out as a web server designed for maximum performance and stability. In addition to its HTTP server capabilities, NGINX can also function as a proxy server for email (IMAP, POP3, and SMTP) and a reverse proxy and load balancer for HTTP, TCP, and UDP servers.


  ## Ansible
  ### what is ansible?
  * confiuration management tool
  * helps configure our infrastructure
  * uses yaml file (identation needed!!!!)
  * easy to use, configure, idempotent
  * has pluggins for cloud services (aws, azure, digitalocean)


  example of basic yaml
  
  ![image](https://github.com/caplearazvan/DevOps_project/assets/82647846/0c0fe172-3157-416e-a224-955882eb67b4)


  ### How it works

    * a server where ansivle is installed is required
    * module - command/set of commands to send from the server to hosts to be executed (eg. the module should install a certain package
    * inventory - a file that contains info about clients servers)
    * task - the smallest unit of action that can be automate in a playbook
    * playbook - a list of tasks the are executed on a host
    * role - way of organize tasks

  #### Dependencies
  
    * needs a ssh connection
    * master server
    * nodes servers
    * install ansible on master 























