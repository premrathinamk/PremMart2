# ===== Build Stage =====
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven configuration and source code
COPY pom.xml .
COPY src ./src

# Build WAR without running tests
RUN mvn clean package -DskipTests

# ===== Tomcat Stage =====
FROM tomcat:9.0-jdk17

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy WAR as ROOT application
COPY --from=build /app/target/PremMart.war /usr/local/tomcat/webapps/ROOT.war

# Default configuration for Render deployment
ENV DB_TYPE=h2 \
    DB_URL="jdbc:h2:mem:premmart;DB_CLOSE_DELAY=-1" \
    DB_USER=sa \
    DB_PASSWORD=WE \
    AI_CHATBOT_PROVIDER=gemini \
    GEMINI_MODEL=gemini-3.1-flash-lite

# Tomcat default port
EXPOSE 8080

# Dynamically bind to $PORT if provided by Render, then start Tomcat
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]