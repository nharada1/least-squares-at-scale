#!/usr/bin/env bash

export SCALA_HOME="/usr/local/share/scala"
export SCALA_VERSION=2.10
export SPARK_HOME="/home/nharada/Code/Spark"
export HADOOP_HOME=""
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export HIVE_DEV_HOME="/home/nharada/Code/BlinkDB/hive_blinkdb"
export HIVE_HOME="$HIVE_DEV_HOME/build/dist"

SPARK_JAVA_OPTS=" -Dspark.local.dir=/tmp "
SPARK_JAVA_OPTS+="-Dspark.kryoserializer.buffer.mb=10 "
SPARK_JAVA_OPTS+="-verbose:gc -XX:-PrintGCDetails -XX:+PrintGCTimeStamps "
export SPARK_JAVA_OPTS
