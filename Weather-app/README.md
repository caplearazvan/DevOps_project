# Weather app

This is a small python application that reads the wheather form a specific location
## How it works
The wheather.py file uses an api from openweathermap.org, and through a key you can retrive the information in a json format
Then the json format is parsed and the information needed is placed in python variable

### Dependencies:
- python3.6 and above
- libraries:
  - requests lib
  - datetime
  - time
  - smtplib,
  - ssl


## Docker 
### Docker steps for running Weather-app:
- Build script
- Dockerize script:
  - Create docker image->container:
  - Dockerfile build : % docker build -t weather-app_v2 .   
  - Docker run: docker run –name work-container  -d -p 80:80 weather-app
  - Docker tag: % docker tag weather-app_v2:latest caplearazvan/devops:latest    
  - Docker push: docker push caplearazvan/devops 
  - Check if it works - Run :  Docker run caplearazvan/devops








