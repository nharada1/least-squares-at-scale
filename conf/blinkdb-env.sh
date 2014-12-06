#!/usr/bin/env bash

export SCALA_HOME="/Users/jkatzsamuels/scala-2.10.4"
export SCALA_VERSION=2.10
export SPARK_HOME="/Users/jkatzsamuels/Desktop/software/spark-1.1.0"
export HADOOP_HOME=""
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
export HIVE_DEV_HOME="/Users/jkatzsamuels/blinkdb/hive_blinkdb"
export HIVE_HOME="$HIVE_DEV_HOME/build/dist"

SPARK_JAVA_OPTS=" -Dspark.local.dir=/tmp "
SPARK_JAVA_OPTS+="-Dspark.kryoserializer.buffer.mb=10 "
SPARK_JAVA_OPTS+="-verbose:gc -XX:-PrintGCDetails -XX:+PrintGCTimeStamps "
export SPARK_JAVA_OPTS
