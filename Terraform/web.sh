#!/bin/bash
yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd

wget wget https://www.tooplate.com/download/2136_kool_form_pack
mkdir test
unzip 2136_kool_form_pack -d test
cp -r 2136_kool_form_pack/* /var/www/html

systemctl restart httpd