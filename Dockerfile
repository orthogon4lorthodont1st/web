#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build

COPY . /apps/
COPY pom.xml /apps/
WORKDIR /apps
RUN mvn install

#
# Package stage
#
FROM tomcat:latest

ARG DATABASE_HOST
ARG DATABASE_USERNAME
ARG DATABASE_PASSWORD


ENV DATABASE_HOST=$DATABASE_HOST
ENV DATABASE_USERNAME=$DATABASE_USERNAME
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD


COPY --from=build apps/target/SimpleApp-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 3000
CMD ["java", "-jar", "app.jar"]