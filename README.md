# 🖥️ CiberMax

**CiberMax** es una aplicación web desarrollada en **Java (JSP + Servlets)** orientada a la venta de PCs y componentes de cómputo.  
El sistema permite la gestión de usuarios, productos por categorías, control de stock y simulación de ventas mediante boletas.

Proyecto desarrollado con fines **académicos** para el curso de **Desarrollo de Aplicaciones Web**.

---

## 🚀 Tecnologías utilizadas

- Java 17
- JSP / Servlets
- Apache Tomcat 9.0.115
- Maven
- MySQL
- HTML5
- CSS3
- JavaScript

---

## 📋 Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener instalado:

- JDK 17
- Apache Tomcat 9
- MySQL Server
- IDE (IntelliJ IDEA o Eclipse)
- Navegador web (Chrome, Edge o Firefox)

---

## ▶️ Cómo ejecutar el proyecto

1. Clonar o descargar el proyecto.
2. Importarlo como proyecto **Maven** en el IDE.
3. Ejecutar el siguiente comando:

```bash```
```mvn clean package```
4. Copiar el archivo cibermax.war ubicado en la carpeta target/
dentro de la carpeta webapps de Apache Tomcat.

5. Iniciar Apache Tomcat.

6. Acceder desde el navegador:

http://localhost:8080/cibermax/

# 👤 Usuario de prueba

Administrador:

Usuario: admin@cibermax.com

Clave: admin

# 🗄️ Base de datos

Nombre de la base de datos: cibermax

Motor: MySQL

Ejecutar el script SQL incluido para crear las tablas y cargar los datos iniciales.