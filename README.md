# LAMP
This creates a local CentOS virtual machine with a full web development stack, including the following packages:

 - Apache
 - PHP 5.4 w/ xdebug
 - MariaDB (Community-driven alternative to MySQL)
 - git
 - composer
 - nano (For those who don't like vi...)

### Puphpet files manually edited
A few files had to be manually edited to get puphpet to generate the VM properly.  
Below is the list of files

`puphpet/config.yaml:`
Edited configuration parameters

`puphpet/puppet/modules/puphpet/manifests/php/composer.pp`
Modified download_method to use wget instead of cURL.
Modified download_method to use cURL again, it now works (see below). wget also works.

`puphpet/puppet/manifests/Ruby.pp`
Added system-rvm require line to correct RVM error.
This is as per the issue/fix here: puphpet/puphpet#2103

`puphpet/puppet/modules/composer/manifests/init.pp`
Modified wget command to behave like cURL.
Modified execution statement to include environmental variable for composer installer.
For more info: puphpet/puphpet#2098
