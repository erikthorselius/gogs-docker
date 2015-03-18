FROM phusion/baseimage:0.9.16
RUN mkdir -p /gogs/custom/conf && \
cd /gogs && \
apt-get update && \
apt-get install unzip && \
curl -L -o gogs_v0.5.13_linux_amd64.zip https://github.com/gogits/gogs/releases/download/v0.5.13/linux_amd64.zip && \
unzip gogs_v0.5.13_linux_amd64.zip
RUN useradd -m git
USER git
ENV HOME /home/git
ENV USER git
CMD ["/sbin/my_init"]
