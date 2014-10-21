FROM debian:wheezy
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install build-essential curl git mercurial -y; \
    curl https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz > /tmp/go1.3.linux-amd64.tar.gz && tar -C /usr/local -xzf /tmp/go1.3.linux-amd64.tar.gz && rm /tmp/go1.3.linux-amd64.tar.gz; \
    curl -L https://github.com/skynetservices/skydns/archive/020889568c318c20a9ce4b5e3b949d36162813f9.tar.gz /tmp/020889568c318c20a9ce4b5e3b949d36162813f9.tar.gz; \
    export GOPATH=/var/go; mkdir -p $GOPATH/src/github.com/skynetservices; tar -C /tmp -xzf /tmp/020889568c318c20a9ce4b5e3b949d36162813f9.tar.gz && mv /tmp/skydns-020889568c318c20a9ce4b5e3b949d36162813f9 $GOPATH/src/github.com/skynetservices/skydns && rm -r /tmp/*; \
    export GOROOT=/usr/local/go; export PATH=$PATH:$GOROOT/bin; export GOPATH=/var/go; export PATH=$PATH:$GOROOT/bin; mkdir -p /usr/local/skydns; cd /usr/local/skydns; go get github.com/skynetservices/skydns; go build github.com/skynetservices/skydns; \
    rm -rf /usr/local/go /var/go; \
    apt-get remove --purge -y build-essential curl git mercurial; \
    apt-get autoremove --purge -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 53
ENTRYPOINT ["/usr/local/skydns/skydns"]
