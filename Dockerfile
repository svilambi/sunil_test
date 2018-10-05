FROM frekele/java:jdk8
MAINTAINER Sunil Kumar

RUN mkdir -p /Java/Program && mkdir -p /root/.ssh/
WORKDIR /Java/Program
COPY Java /Java/Program/

RUN javac ThreadSleep.java
RUN java ThreadSleep
