# Base image
FROM jenkins/inbound-agent:windowsservercore-ltsc2019

# Install Docker CLI
RUN powershell -Command \
    "Invoke-WebRequest -Uri https://download.docker.com/win/static/stable/x86_64/docker-20.10.7.zip -OutFile docker.zip; \
     Expand-Archive -Path docker.zip -DestinationPath C:\\docker; \
     Remove-Item -Force docker.zip; \
     [System.Environment]::SetEnvironmentVariable('PATH', $Env:PATH + ';C:\\docker', [System.EnvironmentVariableTarget]::Machine)"

# Install jq
RUN powershell -Command \
    "Invoke-WebRequest -Uri https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe -OutFile C:\\Windows\\System32\\jq.exe"

# Install kubectl
RUN powershell -Command \
    "Invoke-WebRequest -Uri https://dl.k8s.io/release/v1.23.0/bin/windows/amd64/kubectl.exe -OutFile C:\\Windows\\System32\\kubectl.exe"

# Set the command to start the Jenkins agent
#CMD ["powershell", "-Command", "C:\\ProgramData\\Jenkins\\jenkins-agent.ps1"]
