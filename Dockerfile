# Base image
FROM jenkins/inbound-agent:windowsservercore-ltsc2019

# Install Docker CLI
RUN powershell -Command \
    "Invoke-WebRequest -Uri https://download.docker.com/win/static/stable/x86_64/docker-27.3.1.zip -OutFile docker.zip; \
     Expand-Archive -Path docker.zip -DestinationPath C:\\docker; \
     Remove-Item -Force docker.zip; \
     [System.Environment]::SetEnvironmentVariable('PATH', $Env:PATH + ';C:\\docker\\docker', [System.EnvironmentVariableTarget]::Machine)"

# Set PATH to include Docker CLI
#ENV PATH="C:\\docker\\docker;C:\\Windows\\System32;C:\\Windows;C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\"
#ENV DOCKER_PATH="C:\\docker\\docker"
# Install jq
RUN powershell -Command \
    "Invoke-WebRequest -Uri https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe -OutFile C:\\Windows\\System32\\jq.exe"

# Install kubectl
RUN powershell -Command \
    "Invoke-WebRequest -Uri https://dl.k8s.io/release/v1.31.0/bin/windows/amd64/kubectl.exe -OutFile C:\\Windows\\System32\\kubectl.exe"

