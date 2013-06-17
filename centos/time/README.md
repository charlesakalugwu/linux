#### Update firewall rules on CentOS 6.3
-----------------------------------------

To install/update mogilefs run:

  wget https://raw.github.com/cprenzberg/linux/master/centos/firewall/update.firewall.permissions -O ./update.firewall.rules    
  vi ./update.firewall.rules    
  # edit rules as you wish, save and exit the vim editor   
  chmod +x ./update.firewall.rules    
  ./update.firewall.rules        
  


Installation assumes you are logged in as root. Use sudo as necessary if you are not root
