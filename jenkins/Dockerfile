FROM dockerfile/java:oracle-java7
MAINTAINER Jacek Marchwicki "jacek.marchwicki@gmail.com"

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables \
    git \
    wget \
    curl \
    openssh-client \
    python \
    unzip \
    python-openssl \
    openssh-server
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ubuntu/ | sh

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Define additional metadata for our image.
VOLUME /var/lib/docker

# Install google cloud sdk
RUN mkdir -p /opt && cd /opt/ && wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip && google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
ENV PATH /opt/google-cloud-sdk/bin:$PATH
RUN yes | gcloud components update
ENV CLOUDSDK_CONFIG /jenkins/gcloud
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1

# Install jenkins
RUN wget --output-document=/opt/jenkins.war http://mirrors.jenkins-ci.org/war/1.599/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins
VOLUME /jenkins

# Setup slave login
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
COPY slave.sh /usr/local/bin/
ENV ROOT_PASSWORD notasecret

# install run script
COPY run.sh /usr/local/bin/

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

EXPOSE 8080 22

CMD ["/usr/local/bin/wrapdocker", "/usr/local/bin/run.sh"]
