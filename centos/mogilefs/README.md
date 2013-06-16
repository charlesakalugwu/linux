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
    
    # Create a domain:    
    # A domain represents a classification for a group of files in the cluster.   
    # If you have two webapps being developed, foo and bar, you could create a domain called foo for grouping    
    # files associated with the foo webapp and create another domain called bar for the bar webapp.    
    
        mogadm domain add testdomain    
    
    # Add a class to the domain    
    # Classes allow you to specify subgroups of files within a mogilefs cluster    
    # A replication policy, minimum number of copies of the file (mindevcount)    
    # across the cluster, hash type are specified here, in addition to class name.    
    # For a photo sharing site called foobar, with a domain called foobar, one could create 4 classes    
    # raw, scaled, preview, thumbnail to specify different sizes. the raw class could be set to have a minimum    
    # of 4 copies across devices in the cluster while the others could be set to have just 2 copies or even 1 across    
    # the cluster. If the others get lost, they can always be regenerated from the raw/original.    
    
        mogadm class add foobar raw --hashtype=MD5 --mindevcount=4    
        mogadm class add foobar thumbnail --hashtype=MD5 --mindevcount=2    


    #### Using mogtool for testing adding and retriving the data.     
    ---------------------------------------------------------------    
    
        mogtool inject file-name key-name    
        mogtool extract key-name file-name    
    
    
    #example
    
    # download a small file from somewhere online, save it as downloaded
    # upload the file with mogtool
    # afterwards ls -l ./ to compare sizes of downloaded and redownloaded ...or use any other verification you want 
    # such as simply viewing the files
    
        wget http://pcdn.500px.net/37672672/3952f38dccc481af1ce014625b964de965123aae/4.jpg -O ./downloaded
    	mogtool inject ./downloaded uploaded
    	mogtool extract uploaded ./redownloaded
    	ls -l ./
    
    # sample upload log
    
    	root@node1.storage.dfs:~# mogtool inject ./downloaded uploaded
    	file uploaded: a4be8dcc7ca9317723eabb1f96d97b42, len = 301027
    	Spawned child 4799 to deal with chunk number 1.
    			chunk 1 saved in 0.30 seconds.
    	Child 4799 successfully finished with chunk 1.
    	Replicating: 1
    		   Verifying chunk 1, path http://192.168.0.3:7500/dev3/0/000/000/0000000029.fid...ok
    		   Verifying chunk 1, path http://192.168.0.108:7500/dev2/0/000/000/0000000029.fid...ok
    	root@node1.storage.dfs:~# mogtool extract uploaded ./redownloaded
    	Fetching piece 1...
    			Trying http://192.168.0.3:7500/dev3/0/000/000/0000000029.fid...
    	Done.
    
    
    # for large files, >64M    
    
        mogtool inject --bigfile file-name key-name    
        mogtool extract --bigfile key-name file-name 
    
    
    # download a large file from somewhere online, save it as downloaded.large
    # upload the file with mogtool
    # afterwards ls -l ./ to compare sizes of downloaded.large and redownloaded.large ...or use any other verification you want 
    # such as simply viewing the files
    
    	wget http://packages.couchbase.com/releases/2.0.1/couchbase-server-enterprise_x86_64_2.0.1.setup.exe -O ./downloaded.large
    	mogtool inject --bigfile ./downloaded.large uploaded.large
    	mogtool extract --bigfile uploaded.large ./redownloaded.large
    	ls -l ./
    
    # sample large file upload log
    
    	root@node1.storage.dfs:~# mogtool inject --bigfile ./downloaded.large uploaded.large
    	NOTE: Using chunksize of 33554432 bytes.
    	chunk uploaded.large,1: 2f1d68d6e51939601e239c908fd4aa2d, len = 33554432
    	Spawned child 4971 to deal with chunk number 1.
    			chunk 1 saved in 17.19 seconds.omplete]
    	chunk uploaded.large,2: f2f2ae860d09bee7b9a9465f1565420b, len = 33554432
    	Child 4971 successfully finished with chunk 1.
    	Spawned child 4980 to deal with chunk number 2.
    			chunk 2 saved in 6.70 seconds.complete]
    	chunk uploaded.large,3: 6ec94b4bcc3588a26063b0a2d5634e8e, len = 18745526
    	Spawned child 4983 to deal with chunk number 3.
    			chunk 3 saved in 8.95 seconds.
    	Child 4980 successfully finished with chunk 2.
    	Child 4983 successfully finished with chunk 3.
    	Replicating: 1 2 3
    		   Verifying chunk 1, path http://192.168.0.108:7500/dev2/0/000/000/0000000031.fid...ok
    		   Verifying chunk 1, path http://192.168.0.106:7500/dev4/0/000/000/0000000031.fid...ok
    		   Verifying chunk 3, path http://192.168.0.106:7500/dev4/0/000/000/0000000033.fid...ok
    		   Verifying chunk 3, path http://192.168.0.105:7500/dev5/0/000/000/0000000033.fid...ok
    		   Verifying chunk 2, path http://192.168.0.106:7500/dev4/0/000/000/0000000032.fid...ok
    		   Verifying chunk 2, path http://192.168.0.3:7500/dev3/0/000/000/0000000032.fid...ok
    	Waiting for info file replication...
    	Deleting pre-insert file...
    	root@node1.storage.dfs:~# mogtool extract --bigfile uploaded.large ./redownloaded.large
    	Fetching piece 1...
    			Trying http://192.168.0.108:7500/dev2/0/000/000/0000000031.fid...
    					(33554432 bytes, 2f1d68d6e51939601e239c908fd4aa2d)
    	Fetching piece 2...
    			Trying http://192.168.0.106:7500/dev4/0/000/000/0000000032.fid...
    					(33554432 bytes, f2f2ae860d09bee7b9a9465f1565420b)
    	Fetching piece 3...
    			Trying http://192.168.0.106:7500/dev4/0/000/000/0000000033.fid...
    					(18745526 bytes, 6ec94b4bcc3588a26063b0a2d5634e8e)
    	Done.   
     

    
    #### Using curl to upload data.
    ---------------------------------------------------------------
    
    
    
    
    Installation assumes you are logged in as root. Use sudo as necessary if you are not root
