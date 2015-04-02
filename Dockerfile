FROM golang:1.3

# This part is taken from the official docker image --------------------

RUN apt-get update && apt-get install -y \
		build-essential ca-certificates curl \
		bzr git mercurial openssh-client\
		--no-install-recommends

# ----------------------------------------------------------------------

RUN useradd -m git

ENV GOGS_PATH $GOPATH/src/github.com/gogits/gogs
ENV GOGS_CUSTOM_CONF_PATH $GOGS_PATH/custom/conf
ENV GOGS_CUSTOM_CONF $GOGS_CUSTOM_CONF_PATH/app.ini

RUN go get -u -d github.com/gogits/gogs
# WORKDIR $GOGS_PATH
WORKDIR /go/src/github.com/gogits/gogs
RUN go build github.com/gogits/gogs
RUN chown -R git $GOGS_PATH

ADD init_gogs.sh /tmp/
RUN chown git /tmp/init_gogs.sh
RUN chmod +x /tmp/init_gogs.sh

USER git
ENV HOME /home/git
ENV USER git
ENV PATH $GOGS_PATH:$PATH

RUN git config --global user.name "GoGS" && git config --global user.email "gogitservice@gmail.com"

ENTRYPOINT ["/tmp/init_gogs.sh"]
CMD ["gogs", "web"]
