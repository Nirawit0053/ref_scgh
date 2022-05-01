FROM --platform=linux/amd64 python:3.9

RUN apt-get -y update
RUN apt-get install -y libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

#RUN apt-get install -y google-chrome-stable
RUN apt-get update && \
    apt-get -qq -y install  libxpm4 libxrender1 libgtk2.0-0 libnss3\ 
       libgconf-2-4  libpango1.0-0 libxss1 libxtst6 fonts-liberation\ 
        xdg-utils

RUN apt-get -y install \
               xvfb gtk2-engines-pixbuf \
               xfonts-cyrillic xfonts-100dpi xfonts-75dpi xfonts-base xfonts-scalable \
               imagemagick x11-apps zip

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

#some envs
ENV DISPLAY=:99
ENV APP_HOME /app 
ENV PORT 5000
ENV DEBIAN_FRONTEND noninteractive
ENV TZ="Asia/Bangkok"
RUN pip install --upgrade pip

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN apt update -y && apt install libgl1-mesa-glx sudo chromium chromium-driver -y

ADD cicd /scgh/cicd
ADD keywords /scgh/keywords
ADD resources /scgh/resources
ADD testcases /scgh/testcases
COPY testcases/test.robot /scgh/testcases/test.robot
#set workspace
WORKDIR /scgh

#install python dependencies
RUN pip install -r /scgh/cicd/docker/requirements.txt 


CMD ["/bin/sh"]
