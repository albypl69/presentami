#!/bin/bash
CONFIG=/config/config.json
log=/Mio-Controllo/MioControllo/logs/error.log
cronLog=/Mio-Controllo/MioControllo/logs/cronMio.log
echo "$UPDATE /bin/bash /Mio-Controllo/update.sh > \$logfile 2>&1" >> /etc/cron.d/Mio.cron
echo "$SCH /bin/bash /Mio-Controllo/script.sh > \$logfile 2>&1" >> /etc/cron.d/Mio.cron
set -x
service cron start
crontab /etc/cron.d/Mio.cron
echo "Setting Up pip and installing requirements"
pip install --upgrade pip
pip install --no-warn-script-location -r /Mio-Controllo/MioControllo/requirements.txt
echo "Checking for imported logs"
if test -e "$log"; 
then
	echo "You imported logs"
	if test ! -e "/Mio-Controllo/MioControllo/logs/cronMio.log";
	then
		echo "You must be new to docker welcome"
		touch /Mio-Controllo/MioControllo/logs/cronMio.log
	fi
else
	echo "Making logs To tail"
	mkdir /Mio-Controllo/MioControllo/logs
	touch /Mio-Controllo/MioControllo/logs/cronMio.log
	touch /Mio-Controllo/MioControllo/logs/error.log
fi
cd /Mio-Controllo/MioControllo
"$@"
tail -f /Mio-Controllo/MioControllo/logs/cronMio.log
