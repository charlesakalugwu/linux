    Synchronize system clock via network on CentOS 6.3
    -----------------------------------------
    
    To sync your system clock via ntp daemon run:
    
      wget https://raw.github.com/cprenzberg/linux/master/centos/time/synchronize.system.clock -O ./synchronize.clock
      chmod +x ./synchronize.clock
      ./synchronize.clock        

    
    This assumes you are logged in as root. Use sudo as necessary if you are not root
