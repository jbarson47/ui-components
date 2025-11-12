FROM python:2.7-buster

# Combine nvm installation, sourcing, and usage into a single RUN command
# This ensures nvm is available in the same shell session it's used.
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install 14 && \
    nvm alias default 14 && \
    nvm use default

RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    npm install --global yarn

WORKDIR /ui-components
COPY . /ui-components

RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    git clean -fdx && \
    yarn install && \
    yarn pack
