#!/bin/bash -e

# Get Rainloop and set permissions
install -v -d                               ${ROOTFS_DIR}/data/www
curl https://www.rainloop.net/repository/webmail/rainloop-community-latest.zip > ${ROOTFS_DIR}/data/www/
unzip ${ROOTFS_DIR}/data/www/rainloop-community-latest.zip
rm ${ROOTFS_DIR}/data/www/rainloop-community-latest.zip
cd ${ROOTFS_DIR}/data/www/rainloop
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
chown -R www-data:www-data .

# Relocate config files from /etc to /data/conf
mv -f ${ROOTFS_DIR}/etc/dovecot             ${ROOTFS_DIR}/data/conf/
mv -f ${ROOTFS_DIR}/etc/nginx               ${ROOTFS_DIR}/data/conf/
mv -f ${ROOTFS_DIR}/etc/postfix             ${ROOTFS_DIR}/data/conf/
mv -f ${ROOTFS_DIR}/etc/matrix-synapse      ${ROOTFS_DIR}/data/conf/
mv -f ${ROOTFS_DIR}/etc/letsencrypt         ${ROOTFS_DIR}/data/conf/

# Install dovecot config files
install -m 644 files/dovecot.conf           ${ROOTFS_DIR}/data/conf/dovecot/
install -m 644 files/dovecot-10-auth.conf   ${ROOTFS_DIR}/data/conf/dovecot/conf.d/10-auth.conf
install -m 644 files/dovecot-10-mail.conf   ${ROOTFS_DIR}/data/conf/dovecot/conf.d/10-mail.conf
install -m 644 files/dovecot-10-master.conf ${ROOTFS_DIR}/data/conf/dovecot/conf.d/10-master.conf
install -m 644 files/dovecot-10-ssl.conf.mustache   ${ROOTFS_DIR}/data/conf/dovecot/conf.d/10-ssl.conf.mustache
install -m 644 files/dovecot-20-lmtp.conf   ${ROOTFS_DIR}/data/conf/dovecot/conf.d/20-lmtp.conf
install -m 644 files/dovecot-20-managedsieve.conf   ${ROOTFS_DIR}/data/conf/dovecot/conf.d/20-managedsieve.conf
install -m 644 files/dovecot-90-sieve.conf   ${ROOTFS_DIR}/data/conf/dovecot/conf.d/10-sieve.conf
install -m 644 files/dovecot-auth-ldap.conf.ext   ${ROOTFS_DIR}/data/conf/dovecot/
install -m 644 files/dovecot-ldap.conf.ext.mustache   ${ROOTFS_DIR}/data/conf/dovecot/

# Install synapse config files
install -m 644 files/matrix-homeserver.yaml  ${ROOTFS_DIR}/data/conf/matrix-synapse/homeserver.yaml

# Install nginx config template
install -m 644 files/nginx-site.mustache    ${ROOTFS_DIR}/data/conf/nginx/sites-available/

# Install postfix config files
install -m 644 files/postfix-ldap-aliases.cf.mustache   ${ROOTFS_DIR}/data/conf/postfix/ldap-aliases.cf.mustache
install -m 644 files/postfix-main.cf.mustache           ${ROOTFS_DIR}/data/conf/postfix/main.cf.mustache



