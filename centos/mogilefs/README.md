####Install/Update MogileFS from source
----------------------------------

To install/update nginx run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/nginx/install.nginx.centos -O ./install.nginx   
  vi ./install.nginx   
  # edit versions and configure parameters as you wish, save and exit the vim editor   
  chmod +x ./install.nginx   
  ./install.nginx   
  
  
  
#### Install MogileFS tracker service daemon
----------------------------------------------

To install/update nginx run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/nginx/setup.nginx.service.centos -O ./install.nginx.service   
  chmod +x ./install.nginx.service   
  ./install.nginx.service   
  
  
  
#### Install MogileFS storage node service daemon
--------------------------------------------------

To install/update nginx run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/nginx/setup.nginx.service.centos -O ./install.nginx.service   
  chmod +x ./install.nginx.service   
  ./install.nginx.service   


####Current Versions of MogileFS and required modules
-----------------------------------------------

  nginx - 1.4.1   
  pcre - 8.33   
  openssl - 1.0.1e   
  zlib - 1.2.8   
  memc-nginx-module - v0.13rc3   
  echo nginx module - v0.45   
  nginx-mogilefs-plugin - 1.0.4   



Installation assumes you are logged in as root. Use sudo as necessary if you are not root
