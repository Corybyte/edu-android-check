#!/bin/bash

#导入环境变量
source /data/workspace/myshixun/check/util/init-env.sh $1

#进入 Gaedle 项目目录
cd $TPI_DIR/step$challengeStage/project/

#查看 Gradle app模块依赖列表
query-dependencies(){
	./gradlew app:dependencies  --configuration releaseUnitTestRuntimeClasspath	
}

#执行 Gradle build Task
gradle-build(){
	nohup	./gradlew build --offline >> $LOG_DIR/gradle/build-task.log
}

#执行 Gradle uninstallDebug Task
gradle-uninstallDebug(){
	nohup  ./gradlew uninstallDebug --quiet --offline $LOG_DIR/gradle/uninstallDebug-task.log
}


#执行 Gradle installDebug Task
gradle-installDebug(){
	nohup ./gradlew installDebug --offline >> $LOG_DIR/gradle/installDebug-task.log
}

#执行 Gradle 
# ./gradlew :app:connectedAndroidTest
gradle-connectedAndroidTest(){
	nohup ./gradlew :app:connectedAndroidTest --offline >> $LOG_DIR/gradle/installDebug-task.log
}

