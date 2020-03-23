#!/bin/sh
SERVICE_NAME=Jenkins-Agent

WORK_DIR=/home/pi/jenkins/$SERVICE_NAME
LOG_FILE_PATH=$WORK_DIR/logs
NOW=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE=$LOG_FILE_PATH/$NOW.log

SERVICE_PATH=/usr/local/$SERVICE_NAME
PATH_TO_JAR=$SERVICE_PATH/$SERVICE_NAME.jar
PID_PATH_NAME=/tmp/$SERVICE_NAME-pid
JNLP_PATH=$SERVICE_PATH/slave-agent.jnlp
SECRET_FILE=$SERVICE_PATH/secret-file

JAR_OPTIONS="-jnlpUrl file://$JNLP_PATH -secret @$SECRET_FILE -workDir $WORK_DIR"

case $1 in
    start)
        echo "Starting $SERVICE_NAME ..." | tee -a $LOG_FILE;
        if [ ! -d $WORK_DIR ]; then
            mkdir -p $WORK_DIR;
        fi
        if [ ! -d $LOG_FILE_PATH ]; then
            mkdir -p $LOG_FILE_PATH;
        fi
        if [ ! -f $PID_PATH_NAME ]; then
            nohup java -jar $PATH_TO_JAR $JAR_OPTIONS >> $LOG_FILE 2>&1&
            echo $! > $PID_PATH_NAME;
            echo "Process ID: $!" | tee -a $LOG_FILE;
            echo "$SERVICE_NAME started ..." | tee -a $LOG_FILE;
        else
            echo "$SERVICE_NAME is already running ..." | tee -a $LOG_FILE;
            PID=$(cat $PID_PATH_NAME);
            echo "Stopping $SERVICE_NAME ..." | tee -a $LOG_FILE;
            kill $PID;
            echo "$SERVICE_NAME stopped ..." | tee -a $LOG_FILE;
            rm $PID_PATH_NAME;
            echo "Starting $SERVICE_NAME ..." | tee -a $LOG_FILE;
            nohup java -jar $PATH_TO_JAR $JAR_OPTIONS >> $LOG_FILE 2>&1&
            echo $! > $PID_PATH_NAME;
            echo "Process ID: $!" | tee -a $LOG_FILE;
            echo "$SERVICE_NAME started ..." | tee -a $LOG_FILE;
        fi
    ;;
    stop)
        if [ -f $PID_PATH_NAME ]; then
            PID=$(cat $PID_PATH_NAME);
            echo "Stopping $SERVICE_NAME ..." | tee -a $LOG_FILE;
            kill $PID;
            echo "$SERVICE_NAME stopped ..." | tee -a $LOG_FILE;
            rm $PID_PATH_NAME;
        else
            echo "$SERVICE_NAME is not running ..." | tee -a $LOG_FILE;
        fi
    ;;
    status)
        if [ -f $PID_PATH_NAME ]; then
            cat $LOG_FILE;
            echo "$SERVICE_NAME running ...";
        else
            echo "$SERVICE_NAME not running ...";
        fi
    ;;
    restart)
        if [ -f $PID_PATH_NAME ]; then
            echo "Restarting $SERVICE_NAME ..." | tee -a $LOG_FILE;
            PID=$(cat $PID_PATH_NAME);
            echo "Stopping $SERVICE_NAME ..." | tee -a $LOG_FILE;
            kill $PID;
            echo "$SERVICE_NAME stopped ..." | tee -a $LOG_FILE;
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..." | tee -a $LOG_FILE;
            nohup java -jar $PATH_TO_JAR $JAR_OPTIONS >> $LOG_FILE 2>&1&
            echo $! > $PID_PATH_NAME;
            echo "Process ID: $!" | tee -a $LOG_FILE;
            echo "$SERVICE_NAME started ..." | tee -a $LOG_FILE;
        else
            echo "$SERVICE_NAME not running ..." | tee -a $LOG_FILE;
        fi

    ;;
    reload)
        if [ -f $PID_PATH_NAME ]; then
            echo "Restarting $SERVICE_NAME ..." | tee -a $LOG_FILE;
            PID=$(cat $PID_PATH_NAME);
            echo "Stopping $SERVICE_NAME ..." | tee -a $LOG_FILE;
            kill $PID;
            echo "$SERVICE_NAME stopped ..." | tee -a $LOG_FILE;
            rm $PID_PATH_NAME
            echo "$SERVICE_NAME starting ..." | tee -a $LOG_FILE;
            nohup java -jar $PATH_TO_JAR $JAR_OPTIONS >> $LOG_FILE 2>&1&
            echo $! > $PID_PATH_NAME;
            echo "Process ID: $!" | tee -a $LOG_FILE;
            echo "$SERVICE_NAME started ..." | tee -a $LOG_FILE;
        else
            echo "$SERVICE_NAME not running ..." | tee -a $LOG_FILE;
        fi
    ;;
esac
exit 0
