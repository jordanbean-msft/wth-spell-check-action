FROM python:3.9-slim-buster

LABEL "com.github.actions.name"="WTH Spell Check Action"
LABEL "com.github.actions.description"="Check spelling of Markdown files in the WhatTheHack repo"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/jordanbean-msft/wth-spell-check-action"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Jordan Bean <jordanbean@microsoft.com>"

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64 --no-tty
RUN add-apt-repository ppa:rmescandon/yq

RUN apt-get update \
  && apt-get install -y aspell hunspell yq

RUN pip3 install pyspelling pyyaml

COPY generate-spellcheck.py /generate-spellcheck.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]