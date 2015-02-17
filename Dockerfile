FROM infomaniac50/tutum-docker-wordpress
ADD ./*.sh /
CMD ["/wp-cli-root.sh"]