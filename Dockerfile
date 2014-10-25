# Open Source Question Answer
# Dockerfile - Using Source Code from SVN

# Install Dependencies
FROM ubuntu:14.04
RUN apt-get update
RUN apt-get -y install git subversion wget
RUN apt-get -y install openssh-server apache2 libapache2-mod-wsgi supervisor
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor
RUN apt-get -y install mysql-server mysql-client
RUN apt-get -y install python python-setuptools python-openid
RUN apt-get -y install python-mysqldb
RUN easy_install South django==1.6 django-debug-toolbar django-endless-pagination markdown \
    html5lib python-openid pytz
# Configure Apache
RUN rm /etc/apache2/sites-available/000-default.conf \
    /etc/apache2/sites-available/default-ssl.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
# Create OSQA User
RUN useradd -g www-data osqa -m -d /home/osqa
RUN mkdir -p /home/osqa/bash
# Configure MySQL
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
COPY prepare-mysql.sh /home/osqa/bash/prepare-mysql.sh
RUN /bin/sh /home/osqa/bash/prepare-mysql.sh
VOLUME ["/var/lib/mysql"]
# Set root password
RUN echo "root:root" | chpasswd
# Install and Configure OSQA Server
#RUN cd /home/osqa && git clone https://github.com/dzone/osqa.git && mv osqa osqa-server
#RUN svn co http://svn.osqa.net/svnroot/osqa/trunk/ /home/osqa/osqa-server
#
# Release Candidate Install
RUN mkdir -p /home/osqa/tarballs
RUN cd /home/osqa/tarballs
RUN wget http://svn.osqa.net/svnroot/osqa/releases/osqa-1.0rc-20110802.tar.gz
RUN tar -xvzf osqa-1.0rc-20110802.tar.gz
RUN mv osqa-1.0rc-20110802 osqa-server
RUN mv osqa-server/ /home/osqa/
# 
COPY osqa.wsgi /home/osqa/osqa-server/osqa.wsgi
COPY osqa.conf /etc/apache2/sites-available/osqa.conf
RUN ln -s /etc/apache2/sites-available/osqa.conf /etc/apache2/sites-enabled/osqa.conf
COPY settings_local.py /home/osqa/osqa-server/settings_local.py
COPY prime-osqa-db.sh /home/osqa/bash/prime-osqa-db.sh
RUN chown -R osqa:www-data /home/osqa/osqa-server
RUN chmod -R g+w /home/osqa/osqa-server/forum/upfiles
RUN chmod -R g+w /home/osqa/osqa-server/log
# Configure Supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
EXPOSE 22 80 3306
CMD ["/home/osqa/bash/prime-osqa-db.sh"]
