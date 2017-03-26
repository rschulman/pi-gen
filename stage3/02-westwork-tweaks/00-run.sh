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