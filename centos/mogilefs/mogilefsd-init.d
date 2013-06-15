#Mogilefsd    Startup script for the MogileFS tracker
#
# chkconfig: - 85 15
# description: MogileFS tracker
# processname: mogilefsd
# config: /home/mogilefs/mogilefs-service/tracker/tracker.conf
# pidfile: /var/run/mogilefsd.pid

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0


lockfile=${LOCKFILE-/var/lock/mogilefsd}

MOGILEFSD_CONF_FILE="/etc/mogilefs/mogilefsd.conf"

MOGILEFSD_BINARY="/usr/local/bin/mogilefsd"


start() {
         echo -n $"Starting mogilefsd: "
         su mogilefs -c "$MOGILEFSD_BINARY --config=$MOGILEFSD_CONF_FILE --daemon"
         RETVAL=$?
         echo
         [ $RETVAL = 0 ] && touch ${lockfile}
         return $RETVAL
}
stop() {
         echo -n $"Stopping $prog: "
         killproc mogilefsd
         RETVAL=$?
         echo
         [ $RETVAL = 0 ] && rm -f ${lockfile}
         return $RETVAL
}
reload() {
     echo -n $"Reloading mogilefsd: "
     killproc mogilefsd -HUP
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
         status mogilefsd
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
         echo $"Usage: mogilefsd {start|stop|restart|reload|status}"
         exit 1
esac
