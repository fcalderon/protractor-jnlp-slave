FROM jenkinsci/jnlp-slave

USER root

# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# install chrome for protractor tests
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -yq google-chrome-stable

# nvm environment variables
ENV NVM_DIR /usr/local/nvm

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install nodejs

RUN npm install -g @angular/cli@^8.2.0
RUN npm install -g typescript@3.5.3
RUN npm install -g protractor
RUN webdriver-manager update

RUN chown -R jenkins:jenkins /home/jenkins/.npm
RUN chown -R jenkins:jenkins /home/jenkins/.config

USER jenkins
