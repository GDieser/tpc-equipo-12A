# 🎓 Plataforma de Cursos Online - Equipo 12A

Este repositorio contiene el proyecto cuatrimestral desarrollado por el equipo **12A**, correspondiente a una plataforma de **cursos online**. La solución permite la gestión integral de cursos, usuarios y contenidos, ofreciendo una experiencia completa tanto para **estudiantes** como para **administradores**.

---

## 🚀 Funcionalidades principales

### 🌐 Sitio público
- 🏠 **Inicio accesible sin autenticación** con navegación amigable.
- 📚 **Catálogo de cursos** con títulos, descripciones, imágenes, duración, precio y botón para obtener más información.
- 🗞️ **Sección de novedades** actualizada por administradores, con publicaciones tipo blog institucional.
- 📝 **Formulario de registro e inicio de sesión**, siempre visible desde la cabecera del sitio.

---

### 📝 Registro e inicio de sesión

- 👤 **Alta de usuario** con campos básicos: nombre, apellido, email, contraseña y tipo de usuario.
- 🔒 **Recuperación de contraseña** mediante verificación por correo electrónico.
- 📧 **Confirmación de cuenta por email** con generación de token de validación y expiración.
- 🔐 **Inicio de sesión seguro** con segmentación de acceso según rol:
  - 👨‍🎓 **Estudiante**: acceso a cursos comprados, foros, contenidos, certificados y perfil.
  - 🛠️ **Administrador**: panel de gestión de contenido, usuarios y estadísticas.

---

## 👤 Usuario estudiante
- 🔍 Exploración y compra de cursos disponibles en la plataforma.
- 🎓 Acceso a cursos adquiridos, con navegación completa:
  - Visualización de módulos del curso.
  - Acceso a cada lección dentro de los módulos.
  - Visualización de componentes de lección: texto, imágenes, videos y archivos.
- 📊 Seguimiento del progreso en cada lección y marcado como completada.
- 🧾 Descarga de certificados al finalizar un curso completo (en PDF listo para imprimir).
- 📚 Acceso a recursos complementarios, como videos, materiales descargables, foros y blogs.
- ❤️ Gestión de favoritos para cursos.
- 👤 Edición del perfil personal (nombre, email, contraseña, etc.).
- 🗨️ Participación en espacios colaborativos, como foros de dudas y blogs.

## 🛠️ Usuario administrador
- 🎨 Creación, edición y organización de cursos, módulos y lecciones.
- 🔐 Control de acceso: definición del estado (público/privado) y visibilidad del contenido.
- 👥 Gestión de usuarios registrados: ver, editar o inhabilitar cuentas.
- 📊 Paneles con estadísticas de uso, participación y progreso en los cursos.
- 🧾 Emisión automática de certificados al finalizar cursos completos.
- 💬 Moderación de foros: edición y eliminación de comentarios de estudiantes.
- 🗞️ Gestión de novedades del curso (noticias internas): crear, editar y eliminar publicaciones.
- 📰 Publicación de contenido general en la página principal (estilo blog informativo), con funcionalidades completas de alta, modificación y eliminación.

---

## 🧰 Tecnologías utilizadas
- ⚙️ ASP.NET Web Forms  
- 🛠️ ADO.NET – Acceso a datos con SQL Server
- 🛢️ SQL Server  
- 🎨 Bootstrap 5
- 📝 CKEditor – Editor enriquecido de texto para cursos, módulos, lecciones, novedades y publicaciones
- 💳 Integración con Mercado Pago (Webhooks) 
- 📄 Generación de certificados con HTML embebido  
- 📦 Contenido modular dinámico (SPA-like con UserControls)
- 📧 MailTrap – Envío y testeo de correos SMTP en entorno seguro

---

## 👨‍💻 Equipo 12A
Este proyecto fue desarrollado como trabajo cuatrimestral por el equipo **12A**:

- 👨‍💻 Germán Dieser
- 👨‍💻 Walter Lugo  
- 👨‍💻 Darian Hiebl  

---

Gracias por visitar nuestro repositorio 💙  
¡Esperamos que disfrutes explorando nuestra plataforma!
