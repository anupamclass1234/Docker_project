# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Install necessary packages, including Tomcat
RUN apt-get update && apt-get install -y wget openjdk-11-jdk

# Set environment variables for Tomcat
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Create a directory for Tomcat
RUN mkdir -p $CATALINA_HOME

# Download and install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.109/bin/apache-tomcat-7.0.109.tar.gz \
    && tar xzvf apache-tomcat-7.0.109.tar.gz -C $CATALINA_HOME --strip-components=1 \
    && rm apache-tomcat-7.0.109.tar.gz

# Add the sample.war file to the Tomcat webapps directory
ADD https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war $CATALINA_HOME/webapps/

# Set the working directory
WORKDIR $CATALINA_HOME

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
