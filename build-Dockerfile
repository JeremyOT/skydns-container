FROM debian:wheezy
MAINTAINER jeremyot@gmail.com

RUN apt-get update && apt-get install build-essential curl git mercurial -y; \
    curl https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz > /tmp/go1.4.2.linux-amd64.tar.gz && tar -C /usr/local -xzf /tmp/go1.4.2.linux-amd64.tar.gz && rm /tmp/go1.4.2.linux-amd64.tar.gz;
RUN curl -L https://github.com/skynetservices/skydns/archive/40be39d5675b504baaf010952291cf0af163c15a.tar.gz > /tmp/40be39d5675b504baaf010952291cf0af163c15a.tar.gz; \
    export GOPATH=/var/go; mkdir -p $GOPATH/src/github.com/skynetservices; tar -C /tmp -xzf /tmp/40be39d5675b504baaf010952291cf0af163c15a.tar.gz && mv /tmp/skydns-40be39d5675b504baaf010952291cf0af163c15a $GOPATH/src/github.com/skynetservices/skydns && rm -r /tmp/*; \
    export GOROOT=/usr/local/go; export PATH=$PATH:$GOROOT/bin; export GOPATH=/var/go; export PATH=$PATH:$GOROOT/bin; mkdir -p /usr/local/skydns; cd /usr/local/skydns; go get github.com/skynetservices/skydns; go build github.com/skynetservices/skydns
EXPOSE 53
ENTRYPOINT ["/usr/local/skydns/skydns"]
