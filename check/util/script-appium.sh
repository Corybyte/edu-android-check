#!/bin/bash

source /data/workspace/myshixun/check/util/init-env.sh $1
cd $TPI_DIR/step$challengeStage/appium-check/

appium-check(){
	nohup mvn -q compile exec:java -Dexec.mainClass="org.example.Main" >> $LOG_DIR/appium/compile.log
}