# DevOps_project


## Docker project

This is a small docker file in which you'll find basic syntax in order:
* run a Dockerfiler
* run an image pulled from the DockerHub
* setup the working directory

  ### NGINX
  NGINX is open source software for web serving, reverse proxying, caching, load balancing, media streaming, and more. It started out as a web server designed for maximum performance and stability. In addition to its HTTP server capabilities, NGINX can also function as a proxy server for email (IMAP, POP3, and SMTP) and a reverse proxy and load balancer for HTTP, TCP, and UDP servers.


  ## Ansible
  ### what is ansible?
  * confiuration management tool
  * helps configure our infrastructure
  * uses yaml file (identation needed!!!!)
  * easy to use, configure, idempotent
  * has pluggins for cloud services (aws, azure, digitalocean)


  examole yaml
  
      ![Basic yaml example](https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.ttgtmedia.com%2Frms%2FonlineImages%2Fitops-yaml_code_5_mobile.png&tbnid=pu1usDFShYh9hM&vet=12ahUKEwiFi-n6soKCAxV7gP0HHVMIA1kQMygLegQIARBo..i&imgrefurl=https%3A%2F%2Fwww.techtarget.com%2Fsearchitoperations%2Ftip%2FLearn-YAML-through-a-personal-example&docid=bH6gmyMOeQGX6M&w=520&h=185&q=basic%20yaml%20file&ved=2ahUKEwiFi-n6soKCAxV7gP0HHVMIA1kQMygLegQIARBo)

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























