# CodeAlpha DevOps - Tâche 2 : Jenkins Remoting Project
# Image du contrôleur Jenkins avec les plugins nécessaires pré-installés
# (Configuration as Code + SSH agents).

FROM jenkins/jenkins:lts-jdk21

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/casc_configs/jenkins.yaml"
