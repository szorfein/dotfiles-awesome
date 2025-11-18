#!/usr/bin/env sh

gmaildir=~/.mails/gmail/INBOX
#count=0
offlineimap_bin=offlineimap
log_file=/tmp/grab_email.log

if [ "$1" = "get" ]; then
    if [ -x $offlineimap_bin ]; then
        if ! $offlineimap_bin; then
            echo "$(date) - failed to get email" >> $log_file
            exit 1
        fi
    else
        echo "$(date) - $offlineimap_bin no found" >> $log_file
        exit 1
    fi

    if [ -d $gmaildir ]; then
        nb_mail=$(find $gmaildir/new | wc -l)
        echo "$nb_mail"
    else
        echo "$(date) - Directory $gmaildir no found..." >> $log_file
        exit 1
    fi
elif [ "$1" = "show" ]; then
    new_mails=$(grep -i "^from" $gmaildir/new/* | awk '{print $2,$3}' | sort -u)
    echo "$new_mails"
fi
