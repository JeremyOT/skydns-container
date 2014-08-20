FROM ubuntu:14.04
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install build-essential curl git -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get update && apt-get install mercurial -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz > /tmp/go1.3.linux-amd64.tar.gz && tar -C /usr/local -xzf /tmp/go1.3.linux-amd64.tar.gz && rm /tmp/go1.3.linux-amd64.tar.gz
ADD https://github.com/skynetservices/skydns/archive/master.tar.gz /tmp/master.tar.gz
RUN export GOPATH=/var/go; mkdir -p $GOPATH/src/github.com/skynetservices; tar -C /tmp -xzf /tmp/master.tar.gz && mv /tmp/skydns-master $GOPATH/src/github.com/skynetservices/skydns && rm -r /tmp/*
RUN export GOROOT=/usr/local/go; export PATH=$PATH:$GOROOT/bin; export GOPATH=/var/go; export PATH=$PATH:$GOROOT/bin; mkdir -p /opt/skydns; cd /opt/skydns; go get github.com/skynetservices/skydns; go build github.com/skynetservices/skydns
EXPOSE 53
ENTRYPOINT ["/opt/skydns/skydns"]
