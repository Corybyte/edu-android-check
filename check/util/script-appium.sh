#!/bin/bash


query-dependencies(){
	./gradlew app:dependencies  --configuration releaseUnitTestRuntimeClasspath	
}