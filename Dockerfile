# Dockerfile

FROM alpine:3.7
RUN apk --update add openjdk8-jre
#RUN apt-get update ; apt-get dist-upgrade -y
#RUN apt-get install -y openjdk-8-jre-headless

ADD /build/libs/Parcel-Config-Size-AWS-all-0.1.jar Parcel-Config-Size-Service.jar
#ADD /database/parcelsize.db /database/parcelsize.db
CMD java -jar Parcel-Config-Size-Service.jar




