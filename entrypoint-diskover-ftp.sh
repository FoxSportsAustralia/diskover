#!/bin/bash
FTP_USR=anonymous
FTP_PWD=
FTP_HOST=127.0.0.1
FTP_PORT=21
FTP_PATH=
DISKOVER_CMD="python diskover.py"

while [ "$1" != "" ]; do
        case $1 in
                --ftp-host )            FTP_HOST=$2; shift 2;;
                --ftp-port )            FTP_PORT=$2; shift 2;;
                --ftp-path )            FTP_PATH=$2; shift 2;;
                --ftp-username )        FTP_USR=$2; shift 2;;
                --ftp-password )        FTP_PWD=$2; shift 2;;
                --)                     shift; break;;
                * )                     DISKOVER_CMD="$DISKOVER_CMD $1"; shift;;
        esac 
done

echo "Will mount ftp://$FTP_HOST:$FTP_PORT/$FTP_PATH on $DISKOVER_ROOTDIR"

curlftpfs "ftp://$FTP_USR:$FTP_PWD@$FTP_HOST:$FTP_PORT/$FTP_PATH" "$DISKOVER_ROOTDIR"

echo "Will execute: $DISKOVER_CMD"

eval "$DISKOVER_CMD"

fusermount -u "$DISKOVER_ROOTDIR"