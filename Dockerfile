FROM anapsix/alpine-java:8_jdk_unlimited

MAINTAINER Facundo Viale <facundo.viale@fravega.com.ar>

ENV SBT_HOME=/opt/sbt \
    PATH=${PATH}:/opt/sbt/bin

ARG SBT_VERSION

RUN apk add --no-cache bash && \
	apk --update add tar

RUN apk add --no-cache --virtual=build-dependencies curl && \
	mkdir -p $SBT_HOME && \
    curl -sL "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar --strip-components=1 -x -C $SBT_HOME && \
    apk del build-dependencies

RUN mkdir -p ~/.sbt/0.13/plugins/ && \
	echo 'addSbtPlugin("io.get-coursier" % "sbt-coursier" % "1.0.0-M15")' > ~/.sbt/0.13/plugins/build.sbt

RUN /opt/sbt/bin/sbt exit