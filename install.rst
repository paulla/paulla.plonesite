FreeBSD specifics
=====================

py27-imaging-1.1.7_1 The Python Imaging Library                                 
py27-ldap2-2.4.10   An LDAP module for python, for OpenLDAP2                    
py27-lxml-3.0.1     Pythonic binding for the libxml2 and libxslt libraries    

bin/buildout -Nvc buildout-prod.cfg

cd var/
rsync -av ../../plone420/zeocluster/var/blobstorage/ blobstorage/storage/
rsync -av ../../plone420/zeocluster/var/filestorage/ filestorage /
 
cd -
bin/supervisord
bin/supervisorctl status                     
sockstat -4l 
