####Install/Update MogileFS from source
----------------------------------

To install/update mogilefs run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/mogilefs/install.mogilefs.centos -O ./install.mogilefs  
  vi ./install.mogilefs     
  # edit versions and configure parameters as you wish, save and exit the vim editor   
  chmod +x ./install.mogilefs     
  ./install.mogilefs     
  
  
Note:
  # you need to tell perl CPAN to automaically use defaults during installation
  # this prevents you from typing potentially hundreds of yes/no confirmations
  # assumes you already have perl CPAN installed
  # if not edit install.mogilefs.centos and uncomment the following commands from that file
  
  perl -MCPAN -e shell
  # Run these two commands in the CPAN shell:

  o conf prerequisites_policy follow
  o conf build_requires_install_policy yes
  o conf commit
  exit
  
  
#### Install MogileFS tracker service 
----------------------------------------------

To install/update mogilefs tracker service (mogilefsd) run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/mogilefs/setup.mogilefsd.service.centos -O ./install.mogilefsd.service   
  chmod +x ./install.mogilefsd.service  
  ./install.mogilefsd.service   
  
  
  
#### Install MogileFS storage node service 
--------------------------------------------------

To install/update mogilefs storage node service (mogstored) run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/mogilefs/setup.mogstored.service.centos -O ./install.mogstored.service   
  chmod +x ./install.mogstored.service   
  ./install.mogstored.service   


####Current Versions of MogileFS and required modules
-----------------------------------------------

   MogileFS Server - 2.6.7    
   MogileFS Utils - 2.2.7    
   MogileFS perl-Client - 1.16    


Installation assumes you are logged in as root. Use sudo as necessary if you are not root
