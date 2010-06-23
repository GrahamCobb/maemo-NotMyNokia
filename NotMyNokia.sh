#!/bin/sh
#
name=`basename $0`

if [ "$1" != "--undo" ]
then
# Disable MyNokia auto-registration
#

# Set the user choice marker
if [ ! -f /home/user/.USER_DOES_NOT_WANT_MYNOKIA ]
then
    echo $name >/home/user/.USER_DOES_NOT_WANT_MYNOKIA
    logger -t $name Creating /home/user/.USER_DOES_NOT_WANT_MYNOKIA
    echo $name Creating /home/user/.USER_DOES_NOT_WANT_MYNOKIA
fi

# Set the marker that cherry and /etc/X11/Xsession.d/34cherry
# look for:
if [ ! -f /home/user/.cherry_state ]
then
    echo $name >/home/user/.cherry_state
    logger -t $name Creating /home/user/.cherry_state
    echo $name Creating /home/user/.cherry_state
fi

# Remove /etc/X11/Xsession.d/34cherry
if [ -f /etc/X11/Xsession.d/34cherry ]
then
    size=`stat -t /etc/X11/Xsession.d/34cherry | cut -d ' ' -f 2`
    if [ $size -gt 20 ]
    then
	mv -f /etc/X11/Xsession.d/34cherry /etc/X11/Xsession.d/34cherry.donotrun
	echo '#!/bin/sh' >/etc/X11/Xsession.d/34cherry
	chmod +x /etc/X11/Xsession.d/34cherry
	logger -t $name Renamed /etc/X11/Xsession.d/34cherry as /etc/X11/Xsession.d/34cherry.donotrun
	echo $name Renamed /etc/X11/Xsession.d/34cherry as /etc/X11/Xsession.d/34cherry.donotrun
    fi
fi

# Remove /usr/bin/cherry
if [ -f /usr/bin/cherry ]
then
    size=`stat -t /usr/bin/cherry | cut -d ' ' -f 2`
    if [ $size -gt 20 ]
    then
	mv -f /usr/bin/cherry /usr/bin/cherry.donotrun
	echo '#!/bin/sh' >/usr/bin/cherry
	chmod +x /usr/bin/cherry
	logger -t $name Renamed /usr/bin/cherry as /usr/bin/cherry.donotrun
	echo $name Renamed /usr/bin/cherry as /usr/bin/cherry.donotrun
    fi
fi
# End of disabling MyNokia auto-registration

else
#
# Undo disabling MyNokia auto-registration

# Clear the user choice marker
if [ -f /home/user/.USER_DOES_NOT_WANT_MYNOKIA ]
then
    state=`cat /home/user/.USER_DOES_NOT_WANT_MYNOKIA`
    if [ "$state" != "$name" ]; then rem="(not created by $name)"; else rem=""; fi
    rm /home/user/.USER_DOES_NOT_WANT_MYNOKIA
    logger -t $name "Undo: Removing /home/user/.USER_DOES_NOT_WANT_MYNOKIA $rem"
    echo $name "Undo: Removing /home/user/.USER_DOES_NOT_WANT_MYNOKIA $rem"
fi

# Clear the marker that cherry and /etc/X11/Xsession.d/34cherry
# look for:
if [ -f /home/user/.cherry_state ]
then
    state=`cat /home/user/.cherry_state`
    if [ "$state" != "$name" ]; then rem="(not created by $name)"; else rem=""; fi
    rm /home/user/.cherry_state
    logger -t $name "Undo: Removing /home/user/.cherry_state $rem"
    echo $name "Undo: Removing /home/user/.cherry_state $rem"
fi

# Reinstate /etc/X11/Xsession.d/34cherry
if [ -f /etc/X11/Xsession.d/34cherry.donotrun ]
then
    mv -f /etc/X11/Xsession.d/34cherry.donotrun /etc/X11/Xsession.d/34cherry
    logger -t $name Undo: Renamed /etc/X11/Xsession.d/34cherry.donotrun as /etc/X11/Xsession.d/34cherry
    echo $name Undo: Renamed /etc/X11/Xsession.d/34cherry.donotrun as /etc/X11/Xsession.d/34cherry
fi

# Remove /usr/bin/cherry
if [ -f /usr/bin/cherry.donotrun ]
then
    mv -f /usr/bin/cherry.donotrun /usr/bin/cherry
    logger -t $name Undo: Renamed /usr/bin/cherry.donotrun as /usr/bin/cherry
    echo $name Undo: Renamed /usr/bin/cherry.donotrun as /usr/bin/cherry
fi

fi
