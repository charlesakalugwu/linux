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
  
  # Run the following commands in the CPAN shell:   
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
  
  
#### Setup DB connection from each tracker node
--------------------------------------------------

Each tracker needs to introduce itself, so to speak, to the mysql database node by running the following:   

  wget https://raw.github.com/cprenzberg/linux/master/centos/mogilefs/setup.mogilefsd.db.connection -O ./setup.db.connection.for.tracker    
  chmod +x ./setup.db.connection.for.tracker    
  ./setup.db.connection.for.tracker    
  


####Current Versions of MogileFS and associated modules
--------------------------------------------------------

   MogileFS Server - 2.6.7    
   MogileFS Utils - 2.2.7    
   MogileFS perl-Client - 1.16  
   
   
#### MogileFS operations and testing
--------------------------------------------------------
    
    # Check the mogileFS world   
    mogadm check   

    # Adding Storage nodes and devices   

    #1. Use the following command to add the storage hosts.   
    
    mogadm host add node1.storage.dfs --ip=192.168.1.23 --port=7500 --status=alive   
    
    # 2. Verify this by using following command    
    
    mogadm host list    
    
    # 3. Adding Device for the Storage host     
    
    mogadm device add node1.storage.dfs dev1   
    mogadm device add node2.storage.dfs dev2   

    
    # NOTE: Device ID should be unique across all hosts in the cluster. This means there can only be one device in the    
    # cluster which is named dev1 and only one in the cluster named dev2 and so on...   
    
    # list devices   
    mogadm device list   
    
    # Create Device directories on all Storage Servers.    
    # so log into node1.storage.dfs and create a directory /var/mogdata/dev1 and for node2.storage.dfs, log in and    
    # create /var/mogdata/dev2 and so on    
    # if you are running these commands as root, don't forget to chown the folders for the mogilefs user    
    
    ssh node1.storage.dfs    
    mkdir -p /var/mogdata/dev1    
    chown -R mogilefs:mogilefs /var/mogdata/dev1    
    
    ssh node2.storage.dfs    
    mkdir -p /var/mogdata/dev2    
    chown -R mogilefs:mogilefs /var/mogdata/dev2    
    
    
    # start Storage servers     
    
    service mogstored start
    
    # start tracker servers
    
    service mogilefsd start
    
    
    # Do another filesystem check 
    
    mogadm check
    
    # I have the following output
    
    Checking trackers...
  192.168.0.3:6001 ... OK   
  192.168.0.105:6001 ... OK   
  192.168.0.106:6001 ... OK   
  192.168.0.108:6001 ... OK   
  192.168.0.109:6001 ... OK   

  Checking hosts...
  [ 1] node1.storage.dfs ... OK   
  [ 2] node2.storage.dfs ... OK   
  [ 3] node3.storage.dfs ... OK   
  [ 4] node4.storage.dfs ... OK   
  [ 5] node5.storage.dfs ... OK   

  Checking devices...    
  host device         size(G)    used(G)    free(G)   use%   ob state   I/O%   
  ---- ------------ ---------- ---------- ---------- ------ ---------- -----   
  [ 1] dev1            34.521      2.386     32.135   6.91%  writeable   N/A   
  [ 2] dev2            34.521      2.343     32.178   6.79%  writeable   N/A   
  [ 3] dev3            34.521      2.334     32.188   6.76%  writeable   N/A   
  [ 4] dev4            34.521      2.325     32.196   6.74%  writeable   N/A   
  [ 5] dev5            34.521      2.342     32.179   6.78%  writeable   N/A   
  ---- ------------ ---------- ---------- ---------- ------   
             total:   172.606     11.730    160.876   6.80%    

    
    #### Testing
    --------------------------------
    
    1. Create a domain:
    
    mogadm domain add testdomain
    2. Add a class to the domain:
    
    mogadm class add testdomain testclass
    3. Use modtool for adding and retriving the data.
    
    mogtool inject file-name key-name
    mogtool extract key-name file-name
    for large files, >64M
    
    mogtool inject --bigfile file-name key-name
    mogtool extract --bigfile key-name file-name
    for directories
    
    mogtool inject --bigfile dir-name key-name
    mogtool extract --bigfile dir-name file-name 


Installation assumes you are logged in as root. Use sudo as necessary if you are not root
