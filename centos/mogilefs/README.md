####Install/Update MogileFS from source
----------------------------------

To install/update mogilefs run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/mogilefs/install.mogilefs.centos -O ./install.mogilefs  
  vi ./install.mogilefs     
  # edit versions and configure parameters as you wish, save and exit the vim editor   
  chmod +x ./install.mogilefs     
  ./install.mogilefs     
  
  
  
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

     



Installation assumes you are logged in as root. Use sudo as necessary if you are not root
