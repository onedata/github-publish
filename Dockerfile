FROM python:2-onbuild

# The default working of python:* is /usr/src/app, lets change it

ADD config.yml /
ADD bin /bin
ENV HOME /root
RUN mkdir -p ~/.ssh/
RUN  ssh-keyscan -p7999 git.plgrid.pl >> /root/.ssh/known_hosts
RUN  ssh-keyscan -H github.com >> /root/.ssh/known_hosts

ENTRYPOINT ["/bin/loop.sh"]
