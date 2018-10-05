FROM frekele/java:jdk8
MAINTAINER Sunil Kumar

WORKDIR /Java/
COPY Java /Java/Program/
RUN javac ThreadSleep.java
RUN java ThreadSleep
