FROM busybox:ubuntu-14.04
MAINTAINER jeremyot@gmail.com

ADD skydns /usr/local/skydns/skydns
EXPOSE 53
ENTRYPOINT ["/usr/local/skydns/skydns"]
