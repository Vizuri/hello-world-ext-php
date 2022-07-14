FROM registry.access.redhat.com/ubi8/php-73
#FROM registry.access.redhat.com/ubi7/ubi

#RUN yum -y install --disableplugin=subscription-manager httpd24 rh-php72 rh-php72-php \
#  && yum --disableplugin=subscription-manager clean all

ADD index.php .

CMD /usr/libexec/s2i/run

