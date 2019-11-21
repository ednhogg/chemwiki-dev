# chemwiki-dev
Vagrant Test Environment 

Get a mysql dump from chemwiki.ch.ic.ac.uk and store it in _DATA\BACKUP
The original wiki folder is symlinked to /var/www/html/wiki.
Copy web content from /var/www/html/mediawiki-<version> to _DATA\mediawiki-<version>. 
(Current mediawiki version in use: 1.25.1)
The _DATA directory will be used as a source directory to populate the vagrant box.
Symlinks within the web content folders may not trasfer correctly. 
  (Check ..\wiki\extensions\LdapAuthentication and copy content from ..\wiki\extensions\LdapAuthentication-new if needs be)
 
The vagrant environment sets up a simplified local web server.
Browse to http://10.0.0.33/wiki
 


