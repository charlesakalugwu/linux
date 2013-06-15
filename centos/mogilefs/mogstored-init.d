  
# Startup script for the MogileFS storage node
#
# chkconfig: - 85 15
# description: MogileFS storage node
# processname: mogstored
# config: /etc/mogilefs/mogstored.conf
# pidfile: /var/run/mogstored.pid

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0

# Path to the apachectl script, server binary, and short-form for messages.
lockfile=${LOCKFILE-/var/lock/mogstored}

MOGSTORE_BINARY=/usr/local/bin/mogstored

MOGSTORE_CONF_FILE="/etc/mogilefs/mogstored.conf"


start() {
         echo -n $"Starting mogstored: "
         $MOGSTORE_BINARY -d --config $MOGSTORE_CONF_FILE > /dev/null
         RETVAL=$?
         echo
         [ $RETVAL -eq 0 ] && touch ${lockfile}
         return $RETVAL
}
stop() {
         echo -n $"Stopping $prog: "
         killproc mogstored
         RETVAL=$?
         echo
         [ $RETVAL -eq 0 ] && rm -f ${lockfile}
         return $RETVAL
}
reload() {
     echo -n $"Reloading mogstored: "
     killproc mogstored -HUP
     RETVAL=$?
     echo
}

# See how we were called.
case "$1" in
   start)
         start
         ;;
   stop)
         stop
         ;;
   status)
         status mogstored
         RETVAL=$?
         ;;
   restart)
         stop
         start
         ;;
   reload)
         reload
         ;;
   *)
         echo $"Usage: mogstored {start|stop|restart|reload|status}"
         exit 1
esac
