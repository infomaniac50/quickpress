FROM infomaniac50/tutum-docker-wordpress
MAINTAINER Derek Chafin <infomaniac50@gmail.com>
ADD ./*.sh /
CMD ["/wp-cli-root.sh"]