#!/bin/bash
#加载环境变量
source /etc/profile

#加载script库脚本
source /data/workspace/myshixun/check/util/init-env.sh $1
source $TPI_DIR/check/util/script-gradle.sh
source $TPI_DIR/check/util/script-appium.sh

#清空日志
echo "" >$LOG_DIR/appium/appium.log
echo "" >$LOG_DIR/emulator/emulator.log
echo "" >$LOG_DIR/gradle/build-task.log
echo "" >$LOG_DIR/gradle/uninstallDebug-task.log
echo "" >$LOG_DIR/gradle/installDebug-task.log
echo "" >$LOG_DIR/gradle/test.log
echo "" >$LOG_DIR/mvn/mvn.log

#关闭已启动的进程
pkill -9 qemu-system-x86
pkill -9 node



#启动 appium server (宿主机)
nohup appium >> $LOG_DIR/appium/appium.log 2>&1 &

#启动 虚拟机
nohup emulator -avd Pixel_4a_API_34 >> $LOG_DIR/emulator/emulator.log 2>&1 & 


#执行 Gradle Build task (编译Gradle 项目)
gradle-build

#执行 Gradle uninstallDebug Task (从虚拟机卸载调试版APK)
gradle-uninstallDebug

#执行 Gradle installDebug Task
gradle-installDebug


adb uninstall   io.appium.settings >/dev/null 2>&1 &


#执行 appium 自动化脚本
# cd $TPI_DIR/step$challengeStage/appium-check/
# nohup mvn -q compile exec:java -Dexec.mainClass="org.example.Main" >> $LOG_DIR/mvn/mvn.log
#输出 appium for java 日志
#cat $LOG_DIR/mvn/mvn.log


case $challengeStage  in
  1)
    appium-check
    cat  $LOG_DIR/appium/compile.log
    ;;
  2)
    gradle-test
    cat $LOG_DIR/gradle/test.log
    ;;
esac










