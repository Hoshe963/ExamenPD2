FROM openjdk:17-slim

# Configuración de la aplicación
ENV APP_HOME=/ecommerce-app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Puerto expuesto (coherente con compose)
EXPOSE 8084

# Copiar el JAR (nombre fijo independiente de versión)
COPY ../target/ecommerce-*.jar app.jar

# Usuario no-root para mayor seguridad
RUN useradd -m appuser && chown -R appuser:appuser $APP_HOME
USER appuser

# Health check interno
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8084/actuator/health || exit 1

# Comando de ejecución (formato exec para mejor manejo de señales)
ENTRYPOINT ["java", "-jar", "app.jar"]
