USE [TPC_CURSOS_G12A]
GO
SET IDENTITY_INSERT [dbo].[Modulo] ON 
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (1, 1, NULL, N'Introducción a las bases de datos', N'¿Qué es una base de datos? Tipos y arquitectura de un SGBD.', 1)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (2, 1, NULL, N'Modelado de datos', N'Entidades, atributos y relaciones. Diagramas ER y paso al modelo lógico.', 2)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (3, 1, NULL, N'Lenguaje SQL básico', N'Introducción a consultas SELECT, INSERT, UPDATE y DELETE. Sintaxis fundamental.', 3)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (4, 1, NULL, N'Consultas avanzadas', N'JOINs entre tablas, subconsultas y funciones de agregación (GROUP BY, HAVING).', 4)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (5, 1, NULL, N'Normalización de bases de datos', N'Formas normales (1NF, 2NF, 3NF) y cómo aplicarlas en diseños reales.', 5)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (6, 2, NULL, N'Introducción a la programación y a Python', N'Conceptos básicos, instalación y primer script en Python.', 1)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (7, 2, NULL, N'Variables y tipos de datos', N'Tipos básicos en Python, conversiones y entrada/salida por consola.', 2)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (8, 2, NULL, N'Estructuras de control', N'Condicionales (if-elif-else) y bucles (while/for). Ejercicios prácticos.', 3)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (9, 3, NULL, N'Introducción a la Inteligencia Artificial', N'Definiciones, historia y principales aplicaciones de la IA.', 1)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (10, 3, NULL, N'Ramas y enfoques de la IA', N'Sistemas expertos, aprendizaje automático, PLN y visión computacional.', 2)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (11, 4, NULL, N'Fundamentos de APIs', N'Qué es una API, tipos (REST, SOAP, GraphQL) y protocolos como HTTP y JSON.', 1)
GO
INSERT [dbo].[Modulo] ([IdModulo], [IdCurso], [IdImagen], [Titulo], [Introduccion], [Orden]) VALUES (12, 4, NULL, N'Consumir APIs externas', N'Uso de herramientas como Postman para realizar solicitudes a APIs.', 2)
GO
SET IDENTITY_INSERT [dbo].[Modulo] OFF
GO
SET IDENTITY_INSERT [dbo].[Leccion] ON 
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (1, 1, N'¿Qué es una base de datos?', N'Conceptos fundamentales y motivación.', N'<h2><strong>📌 Definición</strong></h2>

<p>Una&nbsp;<strong>base de datos (BD)</strong>&nbsp;es un&nbsp;<strong>conjunto estructurado de información</strong>&nbsp;almacenada en un sistema informático, diseñada para ser&nbsp;<strong>consultada, actualizada y gestionada</strong>&nbsp;de manera eficiente.</p>

<p>📊&nbsp;<strong>Ejemplo:</strong></p>

<ul>
	<li>
	<p>Un&nbsp;<strong>sistema de biblioteca</strong>&nbsp;guarda libros, autores y préstamos.</p>
	</li>
	<li>
	<p>Una&nbsp;<strong>red social</strong>&nbsp;almacena usuarios, publicaciones y mensajes.</p>
	</li>
</ul>

<hr>
<h2><strong>🔍 Conceptos Clave</strong></h2>

<h3><strong>1. Datos vs. Información</strong></h3>

<ul>
	<li>
	<p><strong>Datos:</strong>&nbsp;Hechos crudos (ej:&nbsp;<em>"Ana, 28, Madrid"</em>).</p>
	</li>
	<li>
	<p><strong>Información:</strong>&nbsp;Datos organizados con significado (<em>"Ana tiene 28 años y vive en Madrid"</em>).</p>
	</li>
</ul>

<h3><strong>2. Sistemas Gestores de Bases de Datos (SGBD)</strong></h3>

<p>Software que administra las BD (ej:&nbsp;<em>MySQL, PostgreSQL, Oracle</em>).<br>
<strong>Funciones principales:</strong></p>

<ul>
	<li>
	<p>Almacenar y recuperar datos.</p>
	</li>
	<li>
	<p>Garantizar&nbsp;<strong>seguridad</strong>&nbsp;y&nbsp;<strong>consistencia</strong>.</p>
	</li>
	<li>
	<p>Permitir acceso concurrente.</p>
	</li>
</ul>

<h3><strong>3. Modelos de Bases de Datos</strong></h3>

<ul>
	<li>
	<p><strong>Relacional (SQL):</strong>&nbsp;Datos en tablas relacionadas (filas y columnas).</p>
	</li>
	<li>
	<p><strong>NoSQL:</strong>&nbsp;Flexible, para datos no estructurados (ej: MongoDB).</p>
	</li>
</ul>

<hr>
<h2><strong>💡 Motivación</strong></h2>

<h3><strong>¿Por qué usar una BD?</strong></h3>

<p>✅&nbsp;<strong>Eficiencia:</strong>&nbsp;Acceso rápido a grandes volúmenes de datos.<br>
✅&nbsp;<strong>Integridad:</strong>&nbsp;Reglas para evitar datos corruptos.<br>
✅&nbsp;<strong>Seguridad:</strong>&nbsp;Control de acceso (usuarios y permisos).<br>
✅&nbsp;<strong>Escalabilidad:</strong>&nbsp;Crece con las necesidades de la empresa.</p>

<blockquote>
<p><em>"Sin bases de datos, la información sería como libros tirados en el suelo: imposible de encontrar cuando se necesita."</em></p>
</blockquote>
', 1, 500, 750, N'https://www.youtube.com/watch?v=n9BNWRewwhQ&t=4s', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/n9BNWRewwhQ" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (2, 2, N'Identificando entidades y sus características', N'Aprenderás a reconocer entidades clave en un sistema (como "Cliente" o "Producto") y sus atributos esenciales (ej: "Nombre", "ID"). Usaremos casos prácticos para diferenciar entre atributos obligatorios y opcionales, y cómo definir claves primarias.', N'<h1><strong>📚 Lección 1: Identificando Entidades y Atributos</strong></h1>

<h2><strong>🔍 ¿Qué es una Entidad?</strong></h2>

<p>Una&nbsp;<strong>entidad</strong>&nbsp;representa un&nbsp;<strong>objeto del mundo real</strong>&nbsp;que queremos almacenar en la base de datos.</p>

<p>📌&nbsp;<strong>Ejemplos comunes:</strong></p>

<ul>
	<li>
	<p><strong><code>Cliente</code></strong>&nbsp;(en un sistema de ventas).</p>
	</li>
	<li>
	<p><strong><code>Producto</code></strong>&nbsp;(en un e-commerce).</p>
	</li>
	<li>
	<p><strong><code>Empleado</code></strong>&nbsp;(en una nómina).</p>
	</li>
</ul>

<hr>
<h2><strong>📝 Atributos: Las Propiedades de una Entidad</strong></h2>

<p>Cada entidad tiene&nbsp;<strong>atributos</strong>&nbsp;que describen sus características.</p>

<h3><strong>Tipos de Atributos:</strong></h3>

<table>
	<thead>
		<tr>
			<th>Tipo</th>
			<th>Descripción</th>
			<th>Ejemplo</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>Clave Primaria (PK)</strong></td>
			<td>Identificador único.</td>
			<td><code>ID_Cliente</code></td>
		</tr>
		<tr>
			<td><strong>Obligatorios</strong></td>
			<td>Datos que&nbsp;<strong>no</strong>&nbsp;pueden ser nulos.</td>
			<td><code>Nombre</code>,&nbsp;<code>Email</code></td>
		</tr>
		<tr>
			<td><strong>Opcionales</strong></td>
			<td>Pueden quedar sin valor.</td>
			<td><code>Teléfono</code></td>
		</tr>
		<tr>
			<td><strong>Compuestos</strong></td>
			<td>Formados por varios datos.</td>
			<td><code>Dirección</code>&nbsp;(Calle, Ciudad, CP)</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🎨 Ejemplo Visual: Entidad "Alumno"</strong></h2>

<p>plaintext</p>

<p>Copy</p>

<p>Download</p>

<pre>┌──────────────────────┐  
│      **ALUMNO**      │  
├──────────────────────┤  
│ ▪ ID_Alumno (PK)     │  
│ ▪ Nombre             │  
│ ▪ Apellido           │  
│ ▪ Fecha_Nacimiento   │  
│ ▪ Teléfono (Opcional)│  
└──────────────────────┘  </pre>

<hr>
<h2><strong>💡 Buenas Prácticas</strong></h2>

<p>✔&nbsp;<strong>Usar nombres claros</strong>&nbsp;(ej:&nbsp;<code>ID_Cliente</code>&nbsp;en lugar de&nbsp;<code>Cod1</code>).<br>
✔&nbsp;<strong>Evitar atributos redundantes</strong>&nbsp;(ej: no guardar&nbsp;<code>Edad</code>&nbsp;si ya tienes&nbsp;<code>Fecha_Nacimiento</code>).<br>
✔&nbsp;<strong>Priorizar claves simples</strong>&nbsp;(un solo campo como PK).</p>

<blockquote>
<p><em>"Una entidad bien definida es la base de una base de datos eficiente."</em></p>
</blockquote>
', 1, 500, 750, N'https://www.youtube.com/watch?v=_acDisSc2UE', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/_acDisSc2UE" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (3, 1, N'Modelado con diagramas ER', N'Representación gráfica de entidades y relaciones.', N'<h2><strong>📌 ¿Qué es un Diagrama Entidad-Relación (DER)?</strong></h2>

<p>Es un&nbsp;<strong>modelo visual</strong>&nbsp;que representa la estructura lógica de una base de datos mediante:</p>

<ul>
	<li>
	<p><strong>Entidades</strong>&nbsp;(objetos del mundo real).</p>
	</li>
	<li>
	<p><strong>Atributos</strong>&nbsp;(propiedades de las entidades).</p>
	</li>
	<li>
	<p><strong>Relaciones</strong>&nbsp;(asociaciones entre entidades).</p>
	</li>
</ul>

<blockquote>
<p>📌&nbsp;<strong>Objetivo:</strong>&nbsp;<em>"Traducir requisitos del negocio a un esquema claro antes de crear tablas en SQL."</em></p>
</blockquote>

<hr>
<h2><strong>🔍 Componentes Principales</strong></h2>

<h3><strong>1. Entidades</strong></h3>

<p>📦&nbsp;<strong>Objetos con existencia independiente</strong>&nbsp;(ej:&nbsp;<code>Cliente</code>,&nbsp;<code>Producto</code>,&nbsp;<code>Factura</code>).</p>

<ul>
	<li>
	<p>Se dibujan como&nbsp;<strong>rectángulos</strong>.</p>
	</li>
	<li>
	<p><strong>Ejemplo:</strong></p>

	<p>text</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>┌─────────────┐  
│   ALUMNO    │  
└─────────────┘  </pre>
	</li>
</ul>

<h3><strong>2. Atributos</strong></h3>

<p>📝&nbsp;<strong>Características de una entidad</strong>&nbsp;(ej:&nbsp;<code>DNI</code>,&nbsp;<code>Nombre</code>,&nbsp;<code>Precio</code>).</p>

<ul>
	<li>
	<p>Se representan con&nbsp;<strong>óvalos</strong>&nbsp;conectados a su entidad.</p>
	</li>
	<li>
	<p><strong>Clave primaria (PK):</strong>&nbsp;Atributo único (subrayado).</p>

	<p>text</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>   ┌─────────────┐  
   │   LIBRO     │  
   └─────────────┘  
      /    |    \  
   ISBN  Título  Año  
   (PK)  </pre>
	</li>
</ul>

<h3><strong>3. Relaciones</strong></h3>

<p>🔗&nbsp;<strong>Asociaciones entre entidades</strong>&nbsp;(ej:&nbsp;<code>Compra</code>,&nbsp;<code>Matrícula</code>).</p>

<ul>
	<li>
	<p>Se grafican con&nbsp;<strong>rombos</strong>&nbsp;y líneas de conexión.</p>
	</li>
	<li>
	<p><strong>Cardinalidad:</strong>&nbsp;Indica cuántas instancias se relacionan (1:1, 1:N, N:M).</p>

	<p>text</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>┌─────────┐        ┌─────────┐  
│ CLIENTE │─────&lt;*&gt;──│ PEDIDO │  
└─────────┘        └─────────┘  
(1 cliente hace N pedidos)  </pre>
	</li>
</ul>

<hr>
<h2><strong>🎨 Ejemplo Práctico: Sistema de Biblioteca</strong></h2>

<p>&nbsp;</p>

<p><strong>Explicación:</strong></p>

<ul>
	<li>
	<p>Un&nbsp;<strong>LIBRO</strong>&nbsp;(entidad) tiene&nbsp;<strong>ISBN</strong>&nbsp;(PK) y&nbsp;<strong>tiene</strong>&nbsp;varios&nbsp;<strong>EJEMPLARES</strong>&nbsp;(relación 1:N).</p>
	</li>
	<li>
	<p>Un&nbsp;<strong>SOCIO</strong>&nbsp;realiza múltiples&nbsp;<strong>PRÉSTAMOS</strong>&nbsp;(1:N), cada préstamo usa un&nbsp;<strong>EJEMPLAR</strong>&nbsp;(1:1).</p>
	</li>
</ul>

<hr>
<h2><strong>💡 Motivación</strong></h2>

<h3><strong>¿Por qué usar DER?</strong></h3>

<p>✅&nbsp;<strong>Claridad:</strong>&nbsp;Fácil de entender para no técnicos.<br>
✅&nbsp;<strong>Prevención de errores:</strong>&nbsp;Detecta problemas antes de implementar.<br>
✅&nbsp;<strong>Documentación:</strong>&nbsp;Esquema reusable para desarrolladores.</p>

<blockquote>
<p><em>"Un buen DER es como un mapa: evita perderse en el diseño de la BD."</em></p>
</blockquote>
', 2, 500, 750, N'https://www.youtube.com/watch?v=TKuxYHb-Hvc', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/TKuxYHb-Hvc" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (7, 2, N'Conectando entidades: tipos de relaciones', N'Exploraremos cómo las entidades se vinculan entre sí (1:1, 1:N, N:M) y cómo representar estas conexiones en un diagrama ER. Analizaremos errores comunes al definir cardinalidades y su impacto en la base de datos final.', N'<h2><strong>📌 ¿Qué es una Relación en un DER?</strong></h2>

<p>Una&nbsp;<strong>relación</strong>&nbsp;describe cómo dos o más entidades interactúan entre sí en un sistema. Se representan con&nbsp;<strong>verbos</strong>&nbsp;en el diagrama.</p>

<p>📌&nbsp;<strong>Ejemplo:</strong></p>

<ul>
	<li>
	<p><strong><code>Cliente</code></strong>&nbsp;→&nbsp;<strong><code>COMPRA</code></strong>&nbsp;→&nbsp;<strong><code>Producto</code></strong></p>
	</li>
	<li>
	<p><strong><code>Profesor</code></strong>&nbsp;→&nbsp;<strong><code>IMPARTE</code></strong>&nbsp;→&nbsp;<strong><code>Curso</code></strong></p>
	</li>
</ul>

<hr>
<h2><strong>🔍 Tipos de Relaciones (Cardinalidad)</strong></h2>

<h3><strong>1. Relación Uno a Uno (1:1)</strong></h3>

<ul>
	<li>
	<p><strong>Definición:</strong>&nbsp;Cada instancia de&nbsp;<strong>Entidad A</strong>&nbsp;se relaciona con&nbsp;<strong>solo una</strong>&nbsp;de&nbsp;<strong>Entidad B</strong>&nbsp;(y viceversa).</p>
	</li>
	<li>
	<p><strong>Ejemplo:</strong></p>

	<p>Diagram</p>

	<p>Code</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>erDiagram
    EMPLEADO ||--|| CONTRATO : "TIENE"</pre>

	<p><em>(Un empleado tiene&nbsp;<strong>un único contrato</strong>&nbsp;y un contrato pertenece a **un único empleado</em>)*</p>
	</li>
</ul>

<h3><strong>2. Relación Uno a Muchos (1:N)</strong></h3>

<ul>
	<li>
	<p><strong>Definición:</strong>&nbsp;Una instancia de&nbsp;<strong>Entidad A</strong>&nbsp;puede vincularse con&nbsp;<strong>varias</strong>&nbsp;de&nbsp;<strong>Entidad B</strong>, pero&nbsp;<strong>B</strong>&nbsp;solo se asocia a&nbsp;<strong>una A</strong>.</p>
	</li>
	<li>
	<p><strong>Ejemplo:</strong></p>

	<p>Diagram</p>

	<p>Code</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>erDiagram
    DEPARTAMENTO ||--o{ EMPLEADO : "DIRIGE"</pre>

	<p><em>(Un departamento tiene&nbsp;<strong>muchos empleados</strong>, pero cada empleado pertenece a **un solo departamento</em>)*</p>
	</li>
</ul>

<h3><strong>3. Relación Muchos a Muchos (N:M)</strong></h3>

<ul>
	<li>
	<p><strong>Definición:</strong>&nbsp;Una instancia de&nbsp;<strong>Entidad A</strong>&nbsp;puede vincularse con&nbsp;<strong>varias B</strong>, y viceversa.</p>
	</li>
	<li>
	<p><strong>Ejemplo:</strong></p>

	<p>Diagram</p>

	<p>Code</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>erDiagram
    ESTUDIANTE }|--|{ CURSO : "MATRICULADO_EN"</pre>

	<p><em>(Un estudiante puede inscribirse en&nbsp;<strong>varios cursos</strong>, y un curso puede tener **muchos estudiantes</em>)*</p>
	</li>
</ul>

<hr>
<h2><strong>⚠️ Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Confundir 1:N&nbsp;con N:M</strong>: Ej: Modelar "Libros y Autores" como 1:N&nbsp;(cuando un libro puede tener varios autores y viceversa → debe ser N:M).<br>
❌&nbsp;<strong>Ignorar la obligatoriedad</strong>: No definir si la relación es opcional (ej: "Un cliente&nbsp;<strong>puede</strong>&nbsp;hacer pedidos" vs. "Un cliente&nbsp;<strong>debe</strong>&nbsp;hacer al menos un pedido").</p>

<hr>
<h2><strong>🎨 Ejemplo Visual: Sistema de Biblioteca</strong></h2>

<p>Diagram</p>

<p>Code</p>

<p>Copy</p>

<p>Download</p>

<pre>erDiagram
    SOCIO ||--o{ PRÉSTAMO : "REALIZA"
    PRÉSTAMO }|--|| LIBRO : "INCLUYE"
    LIBRO }|--|{ AUTOR : "ESCRITO_POR"</pre>

<p><strong>Explicación:</strong></p>

<ol start="1">
	<li>
	<p><strong>1:N</strong>: Un socio realiza&nbsp;<strong>muchos</strong>&nbsp;préstamos, pero cada préstamo es de&nbsp;<strong>un</strong>&nbsp;socio.</p>
	</li>
	<li>
	<p><strong>1:1</strong>: Cada préstamo incluye&nbsp;<strong>un</strong>&nbsp;libro (físico).</p>
	</li>
	<li>
	<p><strong>N:M</strong>: Un libro puede tener&nbsp;<strong>varios autores</strong>, y un autor puede escribir&nbsp;<strong>muchos libros</strong>.</p>
	</li>
</ol>

<hr>
<h2><strong>💡 Buenas Prácticas</strong></h2>

<p>✔&nbsp;<strong>Usar verbos claros</strong>&nbsp;para relaciones (ej:&nbsp;<code>PERTENECE_A</code>,&nbsp;<code>GENERA</code>).<br>
✔&nbsp;<strong>Validar cardinalidades</strong>&nbsp;con reglas de negocio (ej: "¿Un empleado puede trabajar en 2 departamentos?").<br>
✔&nbsp;<strong>Documentar restricciones</strong>&nbsp;(ej: "Un pedido debe tener al menos 1 producto").</p>

<blockquote>
<p><em>"Una relación mal diseñada puede llevar a datos duplicados o inconsistencias."</em></p>
</blockquote>
', 2, 500, 750, N'https://www.youtube.com/watch?v=AArIcStS0TU', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/AArIcStS0TU" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (8, 3, N'Lenguaje SQL básico', N'Fundamentos del lenguaje SQL y cómo interactuar con bases de datos.', N'<h2><strong>🔍 ¿Qué es SQL?</strong></h2>

<p><strong>SQL</strong>&nbsp;(<em>Structured Query Language</em>) es el lenguaje estándar para gestionar bases de datos relacionales. Permite:</p>

<ul>
	<li>
	<p>✅&nbsp;<strong>Crear</strong>&nbsp;y&nbsp;<strong>modificar</strong>&nbsp;estructuras de datos.</p>
	</li>
	<li>
	<p>✅&nbsp;<strong>Insertar</strong>,&nbsp;<strong>consultar</strong>,&nbsp;<strong>actualizar</strong>&nbsp;y&nbsp;<strong>eliminar</strong>&nbsp;información.</p>
	</li>
	<li>
	<p>✅&nbsp;<strong>Controlar</strong>&nbsp;accesos y permisos.</p>
	</li>
</ul>

<blockquote>
<p><em>"SQL es el puente entre los usuarios y los datos almacenados."</em></p>
</blockquote>

<hr>
<h2><strong>📌 Comandos Fundamentales</strong></h2>

<h3><strong>1.&nbsp;<strong>DDL</strong>&nbsp;(Data Definition Language)</strong></h3>

<table>
	<thead>
		<tr>
			<th>Comando</th>
			<th>Función</th>
			<th>Ejemplo</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>CREATE</code></td>
			<td>Crear objetos (tablas, vistas)</td>
			<td><code>CREATE TABLE Clientes (...)</code></td>
		</tr>
		<tr>
			<td><code>ALTER</code></td>
			<td>Modificar estructuras</td>
			<td><code>ALTER TABLE Clientes ADD COLUMN email VARCHAR(100)</code></td>
		</tr>
		<tr>
			<td><code>DROP</code></td>
			<td>Eliminar objetos</td>
			<td><code>DROP TABLE Temporal</code></td>
		</tr>
	</tbody>
</table>

<h3><strong>2.&nbsp;<strong>DML</strong>&nbsp;(Data Manipulation Language)</strong></h3>

<table>
	<thead>
		<tr>
			<th>Comando</th>
			<th>Función</th>
			<th>Ejemplo</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>SELECT</code></td>
			<td>Consultar datos</td>
			<td><code>SELECT * FROM Productos</code></td>
		</tr>
		<tr>
			<td><code>INSERT</code></td>
			<td>Añadir registros</td>
			<td><code>INSERT INTO Clientes VALUES (1, ''Ana'')</code></td>
		</tr>
		<tr>
			<td><code>UPDATE</code></td>
			<td>Modificar datos</td>
			<td><code>UPDATE Productos SET precio = 20 WHERE id = 5</code></td>
		</tr>
		<tr>
			<td><code>DELETE</code></td>
			<td>Eliminar registros</td>
			<td><code>DELETE FROM Pedidos WHERE fecha &lt; ''2023-01-01''</code></td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🎨 Ejemplo Visual: Consulta Básica</strong></h2>

<p>sql</p>

<p>Copy</p>

<p>Download</p>

<pre>-- Obtener productos con precio mayor a $50
SELECT nombre, precio 
FROM Productos
WHERE precio &gt; 50
ORDER BY nombre;</pre>

<p><strong>Resultado:</strong></p>

<table>
	<thead>
		<tr>
			<th>nombre</th>
			<th>precio</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Laptop</td>
			<td>1200</td>
		</tr>
		<tr>
			<td>Smartphone</td>
			<td>800</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>💡 Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Olvidar el&nbsp;<code>WHERE</code>&nbsp;en UPDATE/DELETE</strong>&nbsp;→ ¡Puedes modificar/borrar&nbsp;<strong>todos</strong>&nbsp;los registros!<br>
❌&nbsp;<strong>Usar comillas incorrectas</strong>:&nbsp;<code>''texto''</code>&nbsp;(válido) vs.&nbsp;<code>"texto"</code>&nbsp;(depende del SGBD).<br>
❌&nbsp;<strong>Ignorar mayúsculas/minúsculas</strong>&nbsp;en nombres de tablas (ej:&nbsp;<code>Clientes</code>&nbsp;≠&nbsp;<code>clientes</code>&nbsp;en algunos sistemas).</p>

<hr>
<h2><strong>⚙️ Tipos de Datos Básicos</strong></h2>

<table>
	<thead>
		<tr>
			<th>Tipo</th>
			<th>Ejemplo</th>
			<th>Descripción</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>INT</code></td>
			<td><code>25</code></td>
			<td>Enteros</td>
		</tr>
		<tr>
			<td><code>VARCHAR(n)</code></td>
			<td><code>''Hola''</code></td>
			<td>Texto de longitud variable</td>
		</tr>
		<tr>
			<td><code>DATE</code></td>
			<td><code>''2023-12-31''</code></td>
			<td>Fechas</td>
		</tr>
		<tr>
			<td><code>DECIMAL</code></td>
			<td><code>19.99</code></td>
			<td>Números con decimales</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🎨 Estilo Visual</strong></h2>

<ul>
	<li>
	<p><strong>Código SQL</strong>: Fondo&nbsp;<code>#F8F9F9</code>&nbsp;+ borde&nbsp;<code>#3498DB</code>.</p>
	</li>
	<li>
	<p><strong>Tablas de resultados</strong>: Líneas&nbsp;<code>#E5E7E9</code>, encabezados en&nbsp;<code>#2C3E50</code>.</p>
	</li>
	<li>
	<p><strong>Palabras clave SQL</strong>: En&nbsp;<strong>azul oscuro</strong>&nbsp;(<code>#2874A6</code>) +&nbsp;<code>MAYÚSCULAS</code>.</p>
	</li>
</ul>

<hr>
<h2><strong>🔗 Próximos Pasos</strong></h2>

<ol start="1">
	<li>
	<p><strong>Consultas avanzadas</strong>: JOINs, GROUP BY.</p>
	</li>
	<li>
	<p><strong>Subconsultas</strong>.</p>
	</li>
	<li>
	<p><strong>Optimización de consultas</strong>.</p>
	</li>
</ol>

<blockquote>
<p><em>"Domina estos fundamentos antes de saltar a temas avanzados."</em></p>
</blockquote>

<p><em>(Material diseñado para clases o documentación técnica clara).</em></p>
', 1, 500, 750, N'https://www.youtube.com/watch?v=HU7VJ-xDEzw', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/HU7VJ-xDEzw" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (9, 4, N'Consultas avanzadas', N'Exploración de técnicas SQL para obtener información compleja.', N'<h2><strong>📌 ¿Qué son las Consultas Avanzadas?</strong></h2>

<p>Herramientas SQL para resolver problemas de datos&nbsp;<strong>reales</strong>&nbsp;donde las consultas básicas son insuficientes.</p>

<blockquote>
<p>⚡&nbsp;<strong>Casos de uso:</strong></p>

<ul>
	<li>
	<p>Reportes gerenciales con datos cruzados.</p>
	</li>
	<li>
	<p>Análisis de patrones de compra.</p>
	</li>
	<li>
	<p>Integración de información de múltiples tablas.</p>
	</li>
</ul>
</blockquote>

<hr>
<h2><strong>🚀 Técnicas Clave</strong></h2>

<h3><strong>1. JOINs: Relacionando Tablas</strong></h3>

<table>
	<thead>
		<tr>
			<th>Tipo</th>
			<th>Descripción</th>
			<th>Ejemplo</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>INNER JOIN</strong></td>
			<td>Solo registros coincidentes</td>
			<td><code>SELECT * FROM Clientes INNER JOIN Pedidos ON Clientes.id = Pedidos.cliente_id</code></td>
		</tr>
		<tr>
			<td><strong>LEFT JOIN</strong></td>
			<td>Todos los registros de la tabla izquierda + coincidencias</td>
			<td><code>SELECT * FROM Productos LEFT JOIN Inventario ON Productos.id = Inventario.producto_id</code></td>
		</tr>
		<tr>
			<td><strong>RIGHT JOIN</strong></td>
			<td>Todos los registros de la tabla derecha + coincidencias</td>
			<td><em>(Poco usado - mejor usar LEFT JOIN invertido)</em></td>
		</tr>
	</tbody>
</table>

<p><strong>💡 Pro-tip:</strong></p>

<blockquote>
<p><em>"El 90% de tus JOINs serán INNER o LEFT JOIN. RIGHT JOIN es raramente necesario."</em></p>
</blockquote>

<hr>
<h3><strong>2. Subconsultas (Queries Anidadas)</strong></h3>

<p>Consultas dentro de otras consultas para filtrar o calcular datos.</p>

<p><strong>Ejemplo práctico:</strong></p>

<p>sql</p>

<p>Copy</p>

<p>Download</p>

<pre>-- Productos con precio mayor al promedio  
SELECT nombre, precio  
FROM Productos  
WHERE precio &gt; (SELECT AVG(precio) FROM Productos);  </pre>

<p><strong>⚠️ Cuidado con:</strong></p>

<ul>
	<li>
	<p>Subconsultas en el SELECT (pueden ralentizar la query).</p>
	</li>
	<li>
	<p>Subconsultas correlacionadas (usan valores de la consulta externa).</p>
	</li>
</ul>

<hr>
<h3><strong>3. GROUP BY + Funciones de Agregación</strong></h3>

<table>
	<thead>
		<tr>
			<th>Función</th>
			<th>Descripción</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>COUNT()</code></td>
			<td>Cuenta registros</td>
		</tr>
		<tr>
			<td><code>SUM()</code></td>
			<td>Suma valores</td>
		</tr>
		<tr>
			<td><code>AVG()</code></td>
			<td>Calcula el promedio</td>
		</tr>
		<tr>
			<td><code>MAX()/MIN()</code></td>
			<td>Encuentra valores extremos</td>
		</tr>
	</tbody>
</table>

<p><strong>Ejemplo avanzado:</strong></p>

<p>sql</p>

<p>Copy</p>

<p>Download</p>

<pre>-- Ventas por categoría (solo categorías con &gt;10 ventas)  
SELECT   
    c.nombre AS Categoría,   
    COUNT(p.id) AS Total_Productos,  
    SUM(v.monto) AS Ventas_Totales  
FROM Ventas v  
JOIN Productos p ON v.producto_id = p.id  
JOIN Categorías c ON p.categoria_id = c.id  
GROUP BY c.nombre  
HAVING COUNT(p.id) &gt; 10  
ORDER BY Ventas_Totales DESC;  </pre>

<hr>
<h2><strong>🎨 Visualización de Datos</strong></h2>

<p><strong>Resultado de ejemplo (Ventas por categoría):</strong></p>

<table>
	<thead>
		<tr>
			<th>Categoría</th>
			<th>Total_Productos</th>
			<th>Ventas_Totales</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Electrónicos</td>
			<td>15</td>
			<td>$120,000</td>
		</tr>
		<tr>
			<td>Ropa</td>
			<td>12</td>
			<td>$85,500</td>
		</tr>
		<tr>
			<td>Hogar</td>
			<td>8</td>
			<td>$42,300</td>
		</tr>
	</tbody>
</table>

<p><em>(Usar formatos condicionales en herramientas como Excel o Power BI para destacar insights)</em></p>

<hr>
<h2><strong>💡 Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Usar WHERE en lugar de HAVING</strong>&nbsp;para filtrar grupos.<br>
❌&nbsp;<strong>Olvidar incluir columnas no agregadas</strong>&nbsp;en el GROUP BY.<br>
❌&nbsp;<strong>JOINs innecesarios</strong>&nbsp;que duplican registros (siempre verificar con un SELECT COUNT(*) primero).</p>

<hr>
<h2><strong>⚙️ Optimización</strong></h2>

<ul>
	<li>
	<p><strong>Índices</strong>&nbsp;en columnas usadas en JOINs y WHERE.</p>
	</li>
	<li>
	<p><strong>EXPLAIN ANALYZE</strong>&nbsp;(en PostgreSQL) para entender el plan de ejecución.</p>
	</li>
	<li>
	<p><strong>LIMIT</strong>&nbsp;en consultas de prueba para evitar traer millones de registros.</p>
	</li>
</ul>

<hr>
<h2><strong>🔗 Próximos Niveles</strong></h2>

<ol start="1">
	<li>
	<p><strong>Ventanas (Window Functions)</strong>:&nbsp;<code>OVER()</code>,&nbsp;<code>PARTITION BY</code>.</p>
	</li>
	<li>
	<p><strong>CTEs (Common Table Expressions)</strong>: Consultas con&nbsp;<code>WITH</code>.</p>
	</li>
	<li>
	<p><strong>Optimización avanzada</strong>: Índices parciales, particionamiento.</p>
	</li>
</ol>

<blockquote>
<p><em>"Las consultas avanzadas son como un bisturí: poderosas en manos expertas, peligrosas en principiantes."</em></p>
</blockquote>

<p><em>(Material listo para formación técnica o documentación de referencia rápida)</em></p>
', 1, 500, 750, N'https://www.youtube.com/watch?v=X4ffVGDI2Fo', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/X4ffVGDI2Fo" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (10, 5, N'Normalización de bases de datos', N'Principios para organizar datos de forma eficiente y evitar redundancias.', N'<h1><strong>📊 Normalización de Bases de Datos</strong></h1>

<p><em>(Organización eficiente de datos para minimizar redundancias y anomalías)</em></p>

<hr>
<h2><strong>🔍 ¿Qué es la Normalización?</strong></h2>

<p>Proceso de&nbsp;<strong>diseñar esquemas de bases de datos</strong>&nbsp;mediante reglas que:<br>
✅&nbsp;<strong>Eliminan datos duplicados</strong><br>
✅&nbsp;<strong>Previenen inconsistencias</strong><br>
✅&nbsp;<strong>Optimizan el almacenamiento</strong></p>

<blockquote>
<p><em>"Una base de datos normalizada es como una biblioteca bien organizada: cada libro (dato) tiene un lugar único."</em></p>
</blockquote>

<hr>
<h2><strong>📌 Formas Normales (Principales)</strong></h2>

<h3><strong>1. Primera Forma Normal (1FN)</strong></h3>

<p><strong>Regla:</strong></p>

<ul>
	<li>
	<p>Cada tabla debe tener&nbsp;<strong>una clave primaria</strong>.</p>
	</li>
	<li>
	<p>Los atributos deben ser&nbsp;<strong>atómicos</strong>&nbsp;(indivisibles).</p>
	</li>
</ul>

<p><strong>Ejemplo:</strong><br>
❌&nbsp;<strong>Antes (No normalizado):</strong></p>

<table>
	<thead>
		<tr>
			<th><code>ID_Cliente</code></th>
			<th><code>Nombre</code></th>
			<th><code>Teléfonos</code></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>Ana Pérez</td>
			<td>555-1234, 555-5678</td>
		</tr>
	</tbody>
</table>

<p>✅&nbsp;<strong>Después (1FN):</strong></p>

<table>
	<thead>
		<tr>
			<th><code>ID_Cliente</code></th>
			<th><code>Nombre</code></th>
			<th><code>Teléfono</code></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>Ana Pérez</td>
			<td>555-1234</td>
		</tr>
		<tr>
			<td>1</td>
			<td>Ana Pérez</td>
			<td>555-5678</td>
		</tr>
	</tbody>
</table>

<hr>
<h3><strong>2. Segunda Forma Normal (2FN)</strong></h3>

<p><strong>Regla:</strong></p>

<ul>
	<li>
	<p>Debe estar en&nbsp;<strong>1FN</strong>.</p>
	</li>
	<li>
	<p>Todos los atributos no clave deben depender&nbsp;<strong>completamente</strong>&nbsp;de la clave primaria.</p>
	</li>
</ul>

<p><strong>Ejemplo (Sistema de Pedidos):</strong><br>
❌&nbsp;<strong>Problema:</strong></p>

<table>
	<thead>
		<tr>
			<th><code>ID_Pedido</code>&nbsp;(PK)</th>
			<th><code>ID_Producto</code></th>
			<th><code>Nombre_Producto</code></th>
			<th><code>Cantidad</code></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1001</td>
			<td>P50</td>
			<td>Laptop</td>
			<td>2</td>
		</tr>
	</tbody>
</table>

<p>✅&nbsp;<strong>Solución:</strong><br>
<strong>Tabla Pedidos_Detalle:</strong></p>

<table>
	<thead>
		<tr>
			<th><code>ID_Pedido</code>&nbsp;(PK/FK)</th>
			<th><code>ID_Producto</code>&nbsp;(PK/FK)</th>
			<th><code>Cantidad</code></th>
		</tr>
	</thead>
</table>

<p><strong>Tabla Productos:</strong></p>

<table>
	<thead>
		<tr>
			<th><code>ID_Producto</code>&nbsp;(PK)</th>
			<th><code>Nombre_Producto</code></th>
		</tr>
	</thead>
</table>

<hr>
<h3><strong>3. Tercera Forma Normal (3FN)</strong></h3>

<p><strong>Regla:</strong></p>

<ul>
	<li>
	<p>Debe estar en&nbsp;<strong>2FN</strong>.</p>
	</li>
	<li>
	<p><strong>No</strong>&nbsp;debe existir dependencia transitiva (atributos que dependen de otros no clave).</p>
	</li>
</ul>

<p><strong>Ejemplo:</strong><br>
❌&nbsp;<strong>Antes:</strong></p>

<table>
	<thead>
		<tr>
			<th><code>ID_Empleado</code>&nbsp;(PK)</th>
			<th><code>Nombre</code></th>
			<th><code>Departamento</code></th>
			<th><code>Ciudad_Sede</code></th>
		</tr>
	</thead>
</table>

<p>✅&nbsp;<strong>Después:</strong><br>
<strong>Tabla Empleados:</strong><br>
|&nbsp;<code>ID_Empleado</code>&nbsp;(PK) |&nbsp;<code>Nombre</code>&nbsp;|&nbsp;<code>ID_Departamento</code>&nbsp;(FK) |</p>

<p><strong>Tabla Departamentos:</strong><br>
|&nbsp;<code>ID_Departamento</code>&nbsp;(PK) |&nbsp;<code>Nombre</code>&nbsp;|&nbsp;<code>Ciudad_Sede</code>&nbsp;|</p>

<hr>
<h2><strong>🎨 Diagrama de Normalización</strong></h2>

<p>Diagram</p>

<p>Code</p>

<p>Copy</p>

<p>Download</p>

<pre>erDiagram
    CLIENTE ||--o{ PEDIDO : "REALIZA"
    PEDIDO ||--|{ PEDIDO_DETALLE : "CONTIENE"
    PEDIDO_DETALLE }|--|| PRODUCTO : "INCLUYE"
    EMPLEADO }|--|| DEPARTAMENTO : "PERTENECE_A"</pre>

<hr>
<h2><strong>💡 Beneficios Clave</strong></h2>

<p>✔&nbsp;<strong>Menos redundancia:</strong>&nbsp;Ahorro de espacio.<br>
✔&nbsp;<strong>Integridad:</strong>&nbsp;Actualizaciones en un solo lugar.<br>
✔&nbsp;<strong>Consultas más eficientes.</strong></p>

<h2><strong>⚠️ Desnormalización Controlada</strong></h2>

<p>En casos específicos (ej: data warehouses), se acepta cierta redundancia para&nbsp;<strong>mejorar performance</strong>.</p>

<hr>
<h2><strong>🔍 Caso Práctico: Red Social</strong></h2>

<p><strong>Problema Inicial:</strong></p>

<p>plaintext</p>

<p>Copy</p>

<p>Download</p>

<pre>┌───────────────┐  
│ USUARIO       │  
├───────────────┤  
│ ID (PK)       │  
│ Nombre        │  
│ Amigos        │ ← Lista de IDs separados por comas  
│ Grupos        │ ← Mismo problema  
└───────────────┘  </pre>

<p><strong>Solución Normalizada (3FN):</strong></p>

<p>Diagram</p>

<p>Code</p>

<p>Copy</p>

<p>Download</p>

<pre>erDiagram
    USUARIO ||--o{ USUARIO_AMIGO : "TIENE"
    USUARIO ||--o{ USUARIO_GRUPO : "PERTENECE"</pre>
', 1, 500, 750, N'https://www.youtube.com/watch?v=LqlC7Ie5WnY', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/LqlC7Ie5WnY" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (11, 6, N'Tu primer script en Python', N'Instalación de Python y ejecución básica.', N'<h1><strong>🐍 Tu Primer Script en Python</strong></h1>

<p><em>(Guía rápida para iniciarse en Python)</em></p>

<hr>
<h2><strong>📌 Paso 1: Instalación de Python</strong></h2>

<h3><strong>Windows/macOS/Linux</strong></h3>

<ol start="1">
	<li>
	<p>Descarga la última versión desde&nbsp;<a href="https://www.python.org/downloads/" rel="noreferrer" target="_blank">python.org</a>.</p>
	</li>
	<li>
	<p>Ejecuta el instalador&nbsp;<strong>marcando la opción</strong>:<br>
	✅&nbsp;<em>"Add Python to PATH"</em>&nbsp;(¡Fundamental!).</p>
	</li>
</ol>

<p><strong>Verifica la instalación</strong>&nbsp;en tu terminal:</p>

<p>bash</p>

<p>Copy</p>

<p>Download</p>

<pre>python --version
# Debe mostrar: Python 3.X.X</pre>

<hr>
<h2><strong>🛠️ Paso 2: Tu Primer Script</strong></h2>

<p>Crea un archivo llamado&nbsp;<code>hola_mundo.py</code>&nbsp;con este contenido:</p>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># Esto es un comentario
print("¡Hola, Mundo!")  # Función para imprimir en pantalla

# Variables básicas
nombre = "Ana"
edad = 25

# F-strings (formato moderno)
print(f"Me llamo {nombre} y tengo {edad} años.")</pre>

<hr>
<h2><strong>⚡ Paso 3: Ejecución</strong></h2>

<ol start="1">
	<li>
	<p><strong>Método 1 (Terminal):</strong></p>

	<p>bash</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>python hola_mundo.py</pre>

	<p><em>(Navega a la carpeta del archivo primero con&nbsp;<code>cd</code>)</em>.</p>
	</li>
	<li>
	<p><strong>Método 2 (IDEs):</strong>&nbsp;Usa editores como:</p>

	<ul>
		<li>
		<p><strong>VS Code</strong>&nbsp;(con extensión Python).</p>
		</li>
		<li>
		<p><strong>PyCharm</strong>&nbsp;(entorno profesional).</p>
		</li>
	</ul>
	</li>
</ol>

<hr>
<h2><strong>📚 Conceptos Básicos Incluidos</strong></h2>

<table>
	<thead>
		<tr>
			<th>Código</th>
			<th>Explicación</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>print()</code></td>
			<td>Muestra texto en consola</td>
		</tr>
		<tr>
			<td><code># comentarios</code></td>
			<td>Notas para desarrolladores</td>
		</tr>
		<tr>
			<td><code>nombre = "Ana"</code></td>
			<td>Variable de tipo&nbsp;<strong>string</strong></td>
		</tr>
		<tr>
			<td><code>edad = 25</code></td>
			<td>Variable de tipo&nbsp;<strong>entero</strong></td>
		</tr>
		<tr>
			<td><code>f"Hola {nombre}"</code></td>
			<td>Formateo de strings (Python 3.6+)</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🎨 Salida del Programa</strong></h2>

<p>plaintext</p>

<p>Copy</p>

<p>Download</p>

<pre>¡Hola, Mundo!
Me llamo Ana y tengo 25 años.</pre>

<hr>
<h2><strong>💡 Tips para Principiantes</strong></h2>

<p>✔&nbsp;<strong>Sangría (indentación):</strong>&nbsp;Python la usa para definir bloques (¡no uses llaves!).<br>
✔&nbsp;<strong>Mayúsculas/minúsculas:</strong>&nbsp;<code>Edad</code>&nbsp;y&nbsp;<code>edad</code>&nbsp;son variables distintas.<br>
✔&nbsp;<strong>Errores comunes:</strong>&nbsp;Olvidar los&nbsp;<code>:</code>&nbsp;en condicionales o bucles.</p>

<blockquote>
<p><em>"Python es como el inglés: sencillo de leer pero poderoso en manos expertas."</em></p>
</blockquote>

<hr>
<h2><strong>🔗 ¿Qué Aprender Ahora?</strong></h2>

<ol start="1">
	<li>
	<p><strong>Condicionales:</strong>&nbsp;<code>if-elif-else</code>.</p>
	</li>
	<li>
	<p><strong>Bucles:</strong>&nbsp;<code>for</code>&nbsp;y&nbsp;<code>while</code>.</p>
	</li>
	<li>
	<p><strong>Listas y diccionarios.</strong></p>
	</li>
</ol>

<p><em>(Material listo para talleres introductorios o autoaprendizaje).</em></p>
', 1, 500, 750, N'https://www.youtube.com/watch?v=_6N18g3ewnw', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/_6N18g3ewnw" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (12, 7, N'Trabajando con variables', N'Tipos de datos en Python.'', ''Cómo declarar, asignar y manipular variables.', N'<h1><strong>📊 Trabajando con Variables en Python</strong></h1>

<p><em>(Tipos de datos y operaciones esenciales)</em></p>

<hr>
<h2><strong>📌 Conceptos Clave</strong></h2>

<h3><strong>1. ¿Qué es una Variable?</strong></h3>

<p>Espacio en memoria que almacena un valor con un&nbsp;<strong>nombre simbólico</strong>.</p>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre>nombre = "Carlos"  # Variable ''nombre'' almacena un string
edad = 30          # Variable ''edad'' almacena un entero</pre>

<hr>
<h2><strong>🔢 Tipos de Datos Básicos</strong></h2>

<table>
	<thead>
		<tr>
			<th>Tipo</th>
			<th>Ejemplo</th>
			<th>Descripción</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>int</code></td>
			<td><code>42</code></td>
			<td>Números enteros</td>
		</tr>
		<tr>
			<td><code>float</code></td>
			<td><code>3.14</code></td>
			<td>Números decimales</td>
		</tr>
		<tr>
			<td><code>str</code></td>
			<td><code>"Hola"</code></td>
			<td>Texto (cadena de caracteres)</td>
		</tr>
		<tr>
			<td><code>bool</code></td>
			<td><code>True</code>&nbsp;o&nbsp;<code>False</code></td>
			<td>Valores lógicos</td>
		</tr>
		<tr>
			<td><code>list</code></td>
			<td><code>[1, 2, 3]</code></td>
			<td>Listas (mutables)</td>
		</tr>
		<tr>
			<td><code>tuple</code></td>
			<td><code>(4, 5, 6)</code></td>
			<td>Tuplas (inmutables)</td>
		</tr>
		<tr>
			<td><code>dict</code></td>
			<td><code>{"clave": valor}</code></td>
			<td>Diccionarios (parejas clave-valor)</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🎨 Ejemplos Prácticos</strong></h2>

<h3><strong>Declaración y Operaciones</strong></h3>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># Números
precio = 19.99
cantidad = 3
total = precio * cantidad  # Multiplicación

# Strings
mensaje = "Python es " + "genial"  # Concatenación
saludo = f"Hola, {nombre}. Tienes {edad} años."  # f-string

# Listas
frutas = ["manzana", "banana", "naranja"]
frutas.append("kiwi")  # Añadir elemento

# Diccionarios
usuario = {
    "nombre": "Ana",
    "edad": 25,
    "activo": True
}</pre>

<hr>
<h2><strong>⚠️ Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Usar nombres reservados</strong>&nbsp;como&nbsp;<code>print = 5</code>&nbsp;(¡rompe la función&nbsp;<code>print()</code>!).<br>
❌&nbsp;<strong>Confundir tipos</strong>:&nbsp;<code>"10" + 5</code>&nbsp;(error: no se puede sumar string + int).<br>
❌&nbsp;<strong>Mayúsculas/minúsculas</strong>:&nbsp;<code>Edad</code>&nbsp;≠&nbsp;<code>edad</code>.</p>

<hr>
<h2><strong>💡 Buenas Prácticas</strong></h2>

<p>✔&nbsp;<strong>Nombres descriptivos</strong>:&nbsp;<code>total_ventas</code>&nbsp;en lugar de&nbsp;<code>tv</code>.<br>
✔&nbsp;<strong>Snake_case</strong>: Usar&nbsp;<code>nombre_usuario</code>&nbsp;(no&nbsp;<code>NombreUsuario</code>).<br>
✔&nbsp;<strong>Verificar tipos</strong>: Con&nbsp;<code>type(variable)</code>.</p>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre>print(type(edad))  # Salida: &lt;class ''int''&gt;</pre>

<hr>
<h2><strong>🔍 Conversión de Tipos</strong></h2>

<p>Python es&nbsp;<strong>dinámicamente tipado</strong>, pero a veces necesitas conversiones explícitas:</p>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># String a entero
numero = int("10")

# Entero a string
texto = str(42)

# Float a int (trunca decimales)
entero = int(3.99)  # Resultado: 3 (no redondea)</pre>

<hr>
<h2><strong>🎨 Salidas con Formato</strong></h2>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># Método clásico
print("Total: $%.2f" % 19.5)  # Salida: Total: $19.50

# Método moderno (f-strings)
print(f"Total: ${19.5:.2f}")  # Salida: Total: $19.50</pre>

<hr>
<h2><strong>📚 ¿Qué Aprender Ahora?</strong></h2>

<ol start="1">
	<li>
	<p><strong>Operadores de comparación</strong>:&nbsp;<code>==</code>,&nbsp;<code>!=</code>,&nbsp;<code>&gt;</code>,&nbsp;<code>&lt;</code>.</p>
	</li>
	<li>
	<p><strong>Estructuras de control</strong>:&nbsp;<code>if-else</code>, bucles.</p>
	</li>
	<li>
	<p><strong>Funciones integradas</strong>:&nbsp;<code>len()</code>,&nbsp;<code>sum()</code>,&nbsp;<code>range()</code>.</p>
	</li>
</ol>

<blockquote>
<p><em>"Dominar variables y tipos es como aprender el abecedario antes de escribir un libro."</em></p>
</blockquote>
', 1, 500, 750, N'https://www.youtube.com/watch?v=22gv7arOT8Q', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/22gv7arOT8Q" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (13, 8, N'Sentencias IF, ELIF y ELSE de Python', N'Declaraciones simples IF, ELIF y ELSE ', N'<h1><strong>🔀 Sentencias IF, ELIF y ELSE en Python</strong></h1>

<p><em>(Toma de decisiones en tu código)</em></p>

<hr>
<h2><strong>📌 Estructura Básica</strong></h2>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre>if condición:  
    # Bloque de código si la condición es True  
elif otra_condición:  # Opcional (tantos como necesites)  
    # Bloque alternativo  
else:  # Opcional  
    # Bloque si ninguna condición se cumple  </pre>

<hr>
<h2><strong>🎯 Ejemplo Práctico</strong></h2>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre>edad = 18

if edad &lt; 13:  
    print("Eres un niño")  
elif 13 &lt;= edad &lt; 18:  
    print("Eres un adolescente")  
else:  
    print("Eres un adulto")  </pre>

<p><strong>Salida:</strong></p>

<p>plaintext</p>

<p>Copy</p>

<p>Download</p>

<pre>Eres un adulto</pre>

<hr>
<h2><strong>🔍 Reglas Clave</strong></h2>

<ol start="1">
	<li>
	<p><strong>Los dos puntos (<code>:</code>)</strong>&nbsp;son obligatorios al final de cada condición.</p>
	</li>
	<li>
	<p><strong>Sangría (indentación):</strong>&nbsp;Python usa 4 espacios (o tab) para definir bloques.</p>
	</li>
	<li>
	<p><strong>Jerarquía:</strong>&nbsp;El orden es siempre&nbsp;<code>if</code>&nbsp;→&nbsp;<code>elif</code>&nbsp;→&nbsp;<code>else</code>.</p>
	</li>
</ol>

<hr>
<h2><strong>⚡ Operadores Usados en Condiciones</strong></h2>

<table>
	<thead>
		<tr>
			<th>Operador</th>
			<th>Significado</th>
			<th>Ejemplo</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><code>==</code></td>
			<td>Igual a</td>
			<td><code>edad == 18</code></td>
		</tr>
		<tr>
			<td><code>!=</code></td>
			<td>Diferente de</td>
			<td><code>nombre != "Ana"</code></td>
		</tr>
		<tr>
			<td><code>&gt;</code></td>
			<td>Mayor que</td>
			<td><code>puntos &gt; 100</code></td>
		</tr>
		<tr>
			<td><code>&lt;</code></td>
			<td>Menor que</td>
			<td><code>altura &lt; 1.80</code></td>
		</tr>
		<tr>
			<td><code>and</code></td>
			<td>Y lógico</td>
			<td><code>edad &gt;= 18 and tiene_licencia</code></td>
		</tr>
		<tr>
			<td><code>or</code></td>
			<td>O lógico</td>
			<td><code>es_miembro or pago &gt; 50</code></td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>💡 Ejemplo Avanzado (Anidado)</strong></h2>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre>temperatura = 28  
hora = 14  # 2 PM  

if temperatura &gt; 30:  
    print("¡Hace calor!")  
    if hora &gt; 12:  
        print("Bebe mucha agua")  
elif 20 &lt;= temperatura &lt;= 30:  
    print("Clima agradable")  
else:  
    print("¡Hace frío!")  </pre>

<hr>
<h2><strong>⚠️ Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Olvidar los&nbsp;<code>:</code></strong>&nbsp;→&nbsp;<code>SyntaxError</code>.<br>
❌&nbsp;<strong>Usar&nbsp;<code>=</code>&nbsp;en lugar de&nbsp;<code>==</code></strong>&nbsp;para comparaciones.<br>
❌&nbsp;<strong>Sangría inconsistente</strong>&nbsp;(mezclar espacios y tabs).</p>

<hr>
<h2><strong>🎨 Estilo Recomendado</strong></h2>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># ✔️ Correcto (PEP 8)  
if x &gt; 0:  
    print("Positivo")  

# ❌ Evitar  
if x&gt;0: print("Positivo")  # Muy compacto  </pre>

<hr>
<h2><strong>📚 ¿Siguiente Paso?</strong></h2>

<ol start="1">
	<li>
	<p><strong>Condicionales con listas:</strong>&nbsp;<code>if item in lista:</code>.</p>
	</li>
	<li>
	<p><strong>Expresiones ternarias:</strong>&nbsp;<code>resultado = "Aprobado" if nota &gt;= 5 else "Reprobado"</code>.</p>
	</li>
	<li>
	<p><strong>Match-case (Python 3.10+):</strong>&nbsp;Similar a&nbsp;<code>switch</code>&nbsp;en otros lenguajes.</p>
	</li>
</ol>

<blockquote>
<p><em>"Los condicionales son el semáforo que dirige el flujo de tu programa."</em></p>
</blockquote>
', 1, 500, 750, N'https://www.youtube.com/watch?v=w53HiWSZnzU', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/w53HiWSZnzU" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (14, 9, N'¿Qué es la IA?', N'Desde la definición hasta las aplicaciones reales.', N'<h1><strong>🧠 ¿Qué es la Inteligencia Artificial?</strong></h1>

<p><em>(De la teoría a la práctica cotidiana)</em></p>

<hr>
<h2><strong>📌 Definición Simple</strong></h2>

<p>La&nbsp;<strong>IA</strong>&nbsp;es la capacidad de máquinas para&nbsp;<strong>realizar tareas que normalmente requieren inteligencia humana</strong>, como:</p>

<ul>
	<li>
	<p>🔍&nbsp;<strong>Aprender</strong>&nbsp;de datos (machine learning).</p>
	</li>
	<li>
	<p>💬&nbsp;<strong>Entender lenguaje</strong>&nbsp;(chatbots, traducción).</p>
	</li>
	<li>
	<p>🎨&nbsp;<strong>Crear contenido</strong>&nbsp;(imágenes, música, texto).</p>
	</li>
	<li>
	<p>🤖&nbsp;<strong>Tomar decisiones</strong>&nbsp;(robótica, vehículos autónomos).</p>
	</li>
</ul>

<blockquote>
<p><em>"No es magia, son matemáticas y datos a gran escala."</em></p>
</blockquote>

<hr>
<h2><strong>🔍 Tipos de IA</strong></h2>

<table>
	<thead>
		<tr>
			<th><strong>Tipo</strong></th>
			<th><strong>Descripción</strong></th>
			<th><strong>Ejemplo</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>IA Estrecha (ANI)</strong></td>
			<td>Realiza&nbsp;<strong>una tarea específica</strong>&nbsp;mejor que humanos.</td>
			<td>Reconocimiento facial en tu móvil.</td>
		</tr>
		<tr>
			<td><strong>IA General (AGI)</strong>&nbsp;<em>(Teórica)</em></td>
			<td>Inteligencia&nbsp;<strong>humana completa</strong>.</td>
			<td>Robots como "WALL-E" (aún no existe).</td>
		</tr>
		<tr>
			<td><strong>Superinteligencia (ASI)</strong>&nbsp;<em>(Futuro)</em></td>
			<td>Supera&nbsp;<strong>todas</strong>&nbsp;las capacidades humanas.</td>
			<td>Sistemas hipotéticos de ciencia ficción.</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🌍 Aplicaciones Reales (2024)</strong></h2>

<ul>
	<li>
	<p><strong>💊 Salud:</strong>&nbsp;Diagnóstico de cáncer con IA más preciso que médicos.</p>
	</li>
	<li>
	<p><strong>🛒 Retail:</strong>&nbsp;Recomendaciones personalizadas (Amazon, Netflix).</p>
	</li>
	<li>
	<p><strong>📱Asistentes:</strong>&nbsp;Siri, Alexa, ChatGPT.</p>
	</li>
	<li>
	<p><strong>🚗 Transporte:</strong>&nbsp;Coches autónomos (Tesla, Waymo).</p>
	</li>
	<li>
	<p><strong>🎨 Creatividad:</strong>&nbsp;Generadores de imágenes (DALL-E, Midjourney).</p>
	</li>
</ul>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># Ejemplo mínimo de IA (red neuronal en Python)  
import tensorflow as tf  
modelo = tf.keras.Sequential([...])  # Capas que "aprenden" patrones  </pre>

<hr>
<h2><strong>⚙️ ¿Cómo Funciona?</strong></h2>

<ol start="1">
	<li>
	<p><strong>Datos masivos</strong>&nbsp;(imágenes, textos, sensores).</p>
	</li>
	<li>
	<p><strong>Algoritmos</strong>&nbsp;que detectan patrones (redes neuronales).</p>
	</li>
	<li>
	<p><strong>Entrenamiento</strong>&nbsp;(ajuste de parámetros con ejemplos).</p>
	</li>
	<li>
	<p><strong>Inferencia</strong>&nbsp;(aplicar lo aprendido a nuevos casos).</p>
	</li>
</ol>

<hr>
<h2><strong>⚠️ Mitos vs. Realidad</strong></h2>

<table>
	<thead>
		<tr>
			<th><strong>Mito</strong></th>
			<th><strong>Verdad</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><em>"La IA reemplazará todos los trabajos."</em></td>
			<td>Automatiza tareas&nbsp;<strong>repetitivas</strong>, pero crea nuevos roles (ej: especialistas en IA).</td>
		</tr>
		<tr>
			<td><em>"Las IA tienen conciencia."</em></td>
			<td>Solo&nbsp;<strong>simulan</strong>&nbsp;comprensión (no sienten ni piensan).</td>
		</tr>
		<tr>
			<td><em>"Es tecnología del futuro."</em></td>
			<td>Ya está en tu móvil, banco, hospital y redes sociales.</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>💡 ¿Por qué Importa Ahora?</strong></h2>

<ul>
	<li>
	<p><strong>Velocidad:</strong>&nbsp;ChatGPT alcanzó 100M usuarios en 2 meses (vs. 4.5 años para Internet).</p>
	</li>
	<li>
	<p><strong>Accesibilidad:</strong>&nbsp;Herramientas gratuitas como Google Gemini o Copilot democratizan su uso.</p>
	</li>
	<li>
	<p><strong>Impacto económico:</strong>&nbsp;Se estima que aportará&nbsp;<strong>$15.7 trillones</strong>&nbsp;a la economía global para 2030 (PwC).</p>
	</li>
</ul>
', 1, 500, 750, N'https://www.youtube.com/watch?v=BaaUbPSaZFo', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/BaaUbPSaZFo" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (15, 10, N'Aprendizaje supervisado vs no supervisado', N'Diferencias y usos prácticos.', N'<h1><strong>🔍 Aprendizaje Supervisado vs No Supervisado</strong></h1>

<p><em>(Claves para elegir el enfoque correcto en tus proyectos de IA)</em></p>

<hr>
<h2><strong>📌 Definiciones Claras</strong></h2>

<h3><strong>1. Aprendizaje Supervisado</strong></h3>

<p>📚&nbsp;<strong>"Con libro de respuestas"</strong></p>

<ul>
	<li>
	<p>El modelo aprende de&nbsp;<strong>datos etiquetados</strong>&nbsp;(input → output conocido).</p>
	</li>
	<li>
	<p><strong>Objetivo:</strong>&nbsp;Predecir resultados futuros basados en ejemplos pasados.</p>
	</li>
</ul>

<h3><strong>2. Aprendizaje No Supervisado</strong></h3>

<p>🔮&nbsp;<strong>"Descubriendo patrones ocultos"</strong></p>

<ul>
	<li>
	<p>Trabaja con&nbsp;<strong>datos sin etiquetar</strong>&nbsp;(solo inputs).</p>
	</li>
	<li>
	<p><strong>Objetivo:</strong>&nbsp;Encontrar estructuras o agrupaciones naturales.</p>
	</li>
</ul>

<hr>
<h2><strong>🆚 Comparación Directa</strong></h2>

<table>
	<thead>
		<tr>
			<th><strong>Criterio</strong></th>
			<th><strong>Supervisado</strong></th>
			<th><strong>No Supervisado</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>Datos</strong></td>
			<td>Etiquetados (ej: "spam"/"no spam")</td>
			<td>Sin etiquetas (ej: transacciones bancarias)</td>
		</tr>
		<tr>
			<td><strong>Objetivo</strong></td>
			<td>Predecir/clasificar</td>
			<td>Descubrir patrones</td>
		</tr>
		<tr>
			<td><strong>Algoritmos típicos</strong></td>
			<td>Regresión lineal, Random Forest, SVM</td>
			<td>K-Means, PCA, DBSCAN</td>
		</tr>
		<tr>
			<td><strong>Ejemplo real</strong></td>
			<td>Diagnóstico médico (imagen → enfermedad)</td>
			<td>Segmentación de clientes</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>💡 Usos Prácticos</strong></h2>

<h3><strong>Aprendizaje Supervisado</strong></h3>

<ul>
	<li>
	<p>🏥&nbsp;<strong>Diagnóstico médico:</strong>&nbsp;Clasificar radiografías como "neumonía" o "normal".</p>
	</li>
	<li>
	<p>💳&nbsp;<strong>Detección de fraude:</strong>&nbsp;Transacciones etiquetadas como "legítimas" o "fraudulentas".</p>
	</li>
	<li>
	<p>📧&nbsp;<strong>Filtro de spam:</strong>&nbsp;Correos marcados como "spam" o "inbox".</p>
	</li>
</ul>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># Ejemplo: Entrenar un clasificador supervisado
from sklearn.ensemble import RandomForestClassifier
modelo = RandomForestClassifier()
modelo.fit(X_entrenamiento, y_etiquetas)  # X = features, y = labels</pre>

<h3><strong>Aprendizaje No Supervisado</strong></h3>

<ul>
	<li>
	<p>🛒&nbsp;<strong>Análisis de mercado:</strong>&nbsp;Agrupar clientes por hábitos de compra.</p>
	</li>
	<li>
	<p>🧬&nbsp;<strong>Genómica:</strong>&nbsp;Descubrir patrones en secuencias de ADN.</p>
	</li>
	<li>
	<p>🖼️&nbsp;<strong>Compresión de imágenes:</strong>&nbsp;Reducir dimensiones (PCA).</p>
	</li>
</ul>

<p>python</p>

<p>Copy</p>

<p>Download</p>

<pre># Ejemplo: Agrupamiento con K-Means
from sklearn.cluster import KMeans
kmeans = KMeans(n_clusters=3)
kmeans.fit(datos_sin_etiquetas)  # Solo inputs</pre>

<hr>
<h2><strong>⚠️ Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Usar aprendizaje supervisado sin datos etiquetados</strong>&nbsp;(resultados inútiles).<br>
❌&nbsp;<strong>Aplicar clustering no supervisado cuando hay etiquetas disponibles</strong>&nbsp;(desaprovechar información valiosa).<br>
❌&nbsp;<strong>Ignorar el preprocesamiento</strong>&nbsp;(ambos métodos requieren datos limpios).</p>

<hr>
<h2><strong>🎯 ¿Cuál Elegir?</strong></h2>

<ul>
	<li>
	<p><strong>Elige Supervisado si:</strong><br>
	✅ Tienes datos etiquetados.<br>
	✅ Necesitas predicciones concretas (ej: "¿Este tumor es maligno?").</p>
	</li>
	<li>
	<p><strong>Elige No Supervisado si:</strong><br>
	✅ Solo tienes datos crudos.<br>
	✅ Quieres explorar (ej: "¿Qué tipos de clientes existen?").</p>
	</li>
</ul>

<blockquote>
<p><em>"El supervisado aprende respuestas, el no supervisado hace las preguntas."</em></p>
</blockquote>

<hr>
<h2><strong>🔍 Caso Híbrido: Aprendizaje Semi-Supervisado</strong></h2>

<p>📊&nbsp;<strong>Cuando tienes pocas etiquetas:</strong>&nbsp;Combina ambos enfoques para mejorar resultados (ej: clasificación de imágenes con solo 10% de datos etiquetados).</p>
', 1, 500, 750, N'https://www.youtube.com/watch?v=oT3arRRB2Cw', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/oT3arRRB2Cw" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (16, 11, N'Conceptos clave de las APIs', N'REST, SOAP y GraphQL explicados.', N'<h1><strong>🌐 Conceptos Clave de las APIs: REST, SOAP y GraphQL</strong></h1>

<p><em>(Guía definitiva para elegir el tipo de API adecuado)</em></p>

<hr>
<h2><strong>📌 ¿Qué es una API?</strong></h2>

<p>Interfaz que permite a&nbsp;<strong>dos sistemas comunicarse</strong>&nbsp;bajo reglas definidas.<br>
<em>(Ej: Cuando una app de clima usa datos de un servidor remoto)</em></p>

<hr>
<h2><strong>🆚 Comparación Rápida</strong></h2>

<table>
	<thead>
		<tr>
			<th><strong>Criterio</strong></th>
			<th><strong>REST</strong></th>
			<th><strong>SOAP</strong></th>
			<th><strong>GraphQL</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><strong>Estilo</strong></td>
			<td>Arquitectura liviana</td>
			<td>Protocolo estricto</td>
			<td>Lenguaje de consulta</td>
		</tr>
		<tr>
			<td><strong>Formato</strong></td>
			<td>JSON (mayoría)</td>
			<td>XML</td>
			<td>JSON</td>
		</tr>
		<tr>
			<td><strong>Rendimiento</strong></td>
			<td>Alto (caché)</td>
			<td>Bajo (sobrecarga XML)</td>
			<td>Flexible (evita over-fetching)</td>
		</tr>
		<tr>
			<td><strong>Uso típico</strong></td>
			<td>Apps móviles, web</td>
			<td>Banca, legacy systems</td>
			<td>Apps complejas con datos relacionados</td>
		</tr>
		<tr>
			<td><strong>Autodescripción</strong></td>
			<td>No</td>
			<td>Sí (WSDL)</td>
			<td>Sí (Schema)</td>
		</tr>
	</tbody>
</table>

<hr>
<h2><strong>🔍 Profundizando en Cada Tipo</strong></h2>

<h3><strong>1. REST (Representational State Transfer)</strong></h3>

<p>✅&nbsp;<strong>Ventajas:</strong></p>

<ul>
	<li>
	<p>Escalable y simple (usa HTTP estándar: GET, POST, PUT, DELETE).</p>
	</li>
	<li>
	<p>Ideal para microservicios.</p>
	</li>
</ul>

<p>❌&nbsp;<strong>Limitaciones:</strong></p>

<ul>
	<li>
	<p>Over-fetching/under-fetching de datos.</p>
	</li>
</ul>

<p>http</p>

<p>Copy</p>

<p>Download</p>

<pre>GET /api/users/123 HTTP/1.1  
Host: ejemplo.com  
Accept: application/json  </pre>

<p><em>Ejemplo de petición REST para obtener un usuario.</em></p>

<hr>
<h3><strong>2. SOAP (Simple Object Access Protocol)</strong></h3>

<p>✅&nbsp;<strong>Ventajas:</strong></p>

<ul>
	<li>
	<p>Seguridad y ACID integradas (ideal para transacciones).</p>
	</li>
	<li>
	<p>Estándar rígido (WSDL define el contrato).</p>
	</li>
</ul>

<p>❌&nbsp;<strong>Limitaciones:</strong></p>

<ul>
	<li>
	<p>XML verboso → tráfico pesado.</p>
	</li>
	<li>
	<p>Curva de aprendizaje más pronunciada.</p>
	</li>
</ul>

<p>xml</p>

<p>Copy</p>

<p>Download</p>

<p>Run</p>

<pre>&lt;soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"&gt;
  &lt;soap:Body&gt;
    &lt;GetUser xmlns="http://ejemplo.com"&gt;
      &lt;UserID&gt;123&lt;/UserID&gt;
    &lt;/GetUser&gt;
  &lt;/soap:Body&gt;
&lt;/soap:Envelope&gt;</pre>

<hr>
<h3><strong>3. GraphQL</strong></h3>

<p>✅&nbsp;<strong>Ventajas:</strong></p>

<ul>
	<li>
	<p>El cliente pide&nbsp;<strong>exactamente</strong>&nbsp;lo que necesita.</p>
	</li>
	<li>
	<p>Útil para datos altamente relacionados (ej: redes sociales).</p>
	</li>
</ul>

<p>❌&nbsp;<strong>Limitaciones:</strong></p>

<ul>
	<li>
	<p>Caché más complejo que REST.</p>
	</li>
</ul>

<p>graphql</p>

<p>Copy</p>

<p>Download</p>

<pre>query {
  user(id: "123") {
    name
    email
    posts(last: 2) {
      title
    }
  }
}</pre>

<p>*Consulta que obtiene un usuario + sus 2 últimos posts (sin datos extra).*</p>

<hr>
<h2><strong>🎯 ¿Cuál Elegir?</strong></h2>

<table>
	<thead>
		<tr>
			<th><strong>Escenario</strong></th>
			<th><strong>Tecnología Recomendada</strong></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>App moderna con móvil/web</td>
			<td>REST o GraphQL</td>
		</tr>
		<tr>
			<td>Sistema legacy empresarial</td>
			<td>SOAP</td>
		</tr>
		<tr>
			<td>Consultas complejas a datos</td>
			<td>GraphQL</td>
		</tr>
		<tr>
			<td>Transacciones financieras</td>
			<td>SOAP</td>
		</tr>
	</tbody>
</table>

<blockquote>
<p><em>"REST para lo simple, GraphQL para lo flexible, SOAP para lo crítico."</em></p>
</blockquote>

<hr>
<h2><strong>⚡ Caso Real: Spotify</strong></h2>

<ul>
	<li>
	<p><strong>Usa REST</strong>&nbsp;para endpoints simples (ej: buscar canciones).</p>
	</li>
	<li>
	<p><strong>Usa GraphQL</strong>&nbsp;para el dashboard de artistas (datos anidados: canciones + álbumes + estadísticas).</p>
	</li>
</ul>

<hr>
<h2><strong>💡 Buenas Prácticas Comunes</strong></h2>

<p>✔&nbsp;<strong>Versionado:</strong>&nbsp;<code>/v1/users</code>&nbsp;(REST) o&nbsp;<code>@version(1)</code>&nbsp;(GraphQL).<br>
✔&nbsp;<strong>Autenticación:</strong>&nbsp;Tokens JWT (REST/GraphQL), WS-Security (SOAP).<br>
✔&nbsp;<strong>Documentación:</strong>&nbsp;Swagger (REST), GraphiQL (GraphQL), WSDL (SOAP).</p>
', 1, 500, 750, N'https://www.youtube.com/watch?v=u2Ms34GE14U', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/u2Ms34GE14U" ></iframe>')
GO
INSERT [dbo].[Leccion] ([IdLeccion], [IdModulo], [Titulo], [Introduccion], [Contenido], [Orden], [AltoVideo], [AnchoVideo], [UrlVideo], [IframeVideo]) VALUES (17, 12, N'Usar Postman para probar APIs', N'Ejemplo práctico de consumo de una API.', N'<h1><strong>📌 Guía Práctica: Usar Postman para Probar APIs</strong></h1>

<p><em>Aprende a consumir una API real paso a paso</em></p>

<hr>
<h2><strong>🔍 Paso 1: Instalación y Configuración</strong></h2>

<ol start="1">
	<li>
	<p><strong>Descarga Postman</strong>&nbsp;desde&nbsp;<a href="https://www.postman.com/downloads/" rel="noreferrer" target="_blank">postman.com</a>.</p>
	</li>
	<li>
	<p><strong>Crea una cuenta</strong>&nbsp;(opcional pero útil para sincronizar tus proyectos).</p>
	</li>
</ol>

<hr>
<h2><strong>🌐 Paso 2: Ejemplo con API Pública</strong></h2>

<p>Vamos a usar&nbsp;<strong>JSONPlaceholder</strong>, una API de prueba gratuita:</p>

<p>txt</p>

<p>Copy</p>

<p>Download</p>

<pre>https://jsonplaceholder.typicode.com/posts</pre>

<hr>
<h2><strong>🛠️ Paso 3: Probar Endpoints</strong></h2>

<h3><strong>1. GET: Obtener datos</strong></h3>

<ul>
	<li>
	<p><strong>URL:</strong>&nbsp;<code>GET</code>&nbsp;<a href="https://jsonplaceholder.typicode.com/posts" rel="noreferrer" target="_blank">https://jsonplaceholder.typicode.com/posts</a></p>
	</li>
	<li>
	<p><strong>Headers:</strong></p>

	<p>json</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>{
  "Content-Type": "application/json"
}</pre>
	</li>
	<li>
	<p><strong>Respuesta esperada (200 OK):</strong></p>

	<p>json</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>[
  {
    "userId": 1,
    "id": 1,
    "title": "Título del post",
    "body": "Contenido del post..."
  }
]</pre>
	</li>
</ul>

<hr>
<h3><strong>2. POST: Crear un recurso</strong></h3>

<ul>
	<li>
	<p><strong>URL:</strong>&nbsp;<code>POST</code>&nbsp;<a href="https://jsonplaceholder.typicode.com/posts" rel="noreferrer" target="_blank">https://jsonplaceholder.typicode.com/posts</a></p>
	</li>
	<li>
	<p><strong>Headers:</strong>&nbsp;Igual que en GET.</p>
	</li>
	<li>
	<p><strong>Body (raw → JSON):</strong></p>

	<p>json</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>{
  "title": "Mi nuevo post",
  "body": "Este es el contenido de mi post.",
  "userId": 1
}</pre>
	</li>
	<li>
	<p><strong>Respuesta esperada (201 Created):</strong></p>

	<p>json</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>{
  "id": 101  // Nuevo ID generado
}</pre>
	</li>
</ul>

<hr>
<h3><strong>3. PUT/PATCH: Actualizar datos</strong></h3>

<ul>
	<li>
	<p><strong>URL:</strong>&nbsp;<code>PUT</code>&nbsp;<a href="https://jsonplaceholder.typicode.com/posts/1" rel="noreferrer" target="_blank">https://jsonplaceholder.typicode.com/posts/1</a></p>
	</li>
	<li>
	<p><strong>Body:</strong></p>

	<p>json</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>{
  "title": "Título actualizado"
}</pre>
	</li>
	<li>
	<p><strong>Respuesta (200 OK):</strong>&nbsp;Muestra el registro modificado.</p>
	</li>
</ul>

<hr>
<h3><strong>4. DELETE: Eliminar un recurso</strong></h3>

<ul>
	<li>
	<p><strong>URL:</strong>&nbsp;<code>DELETE</code>&nbsp;<a href="https://jsonplaceholder.typicode.com/posts/1" rel="noreferrer" target="_blank">https://jsonplaceholder.typicode.com/posts/1</a></p>
	</li>
	<li>
	<p><strong>Respuesta (200 OK):</strong>&nbsp;<code>{}</code>&nbsp;(recurso eliminado).</p>
	</li>
</ul>

<hr>
<h2><strong>💡 Características Avanzadas de Postman</strong></h2>

<ul>
	<li>
	<p><strong>Variables de entorno:</strong>&nbsp;Para manejar URLs dinámicas (ej:&nbsp;<code>{{base_url}}/posts</code>).</p>
	</li>
	<li>
	<p><strong>Tests automatizados:</strong></p>

	<p>javascript</p>

	<p>Copy</p>

	<p>Download</p>

	<pre>pm.test("Status code is 200", () =&gt; {
  pm.response.to.have.status(200);
});</pre>
	</li>
	<li>
	<p><strong>Colecciones:</strong>&nbsp;Organiza APIs relacionadas en carpetas.</p>
	</li>
	<li>
	<p><strong>Documentación automática:</strong>&nbsp;Genera docs interactivas para tu equipo.</p>
	</li>
</ul>

<hr>
<h2><strong>🎨 Captura de Postman</strong></h2>

<p><em>(Interfaz visual con los pasos anteriores)</em></p>

<p>plaintext</p>

<p>Copy</p>

<p>Download</p>

<pre>[POSTMAN UI]  
├── Sidebar: Colección "Ejemplo JSONPlaceholder"  
├── Pestaña "Request":  
│   - Método: GET/POST/PUT/DELETE  
│   - URL: ingresada  
│   - Headers: Content-Type: application/json  
│   - Body (para POST/PUT): JSON editable  
└── Response: JSON formateado con sintaxis coloreada  </pre>

<hr>
<h2><strong>⚠️ Errores Comunes</strong></h2>

<p>❌&nbsp;<strong>Olvidar los headers</strong>&nbsp;→ Error&nbsp;<code>415 Unsupported Media Type</code>.<br>
❌&nbsp;<strong>Enviar JSON malformado</strong>&nbsp;→ Error&nbsp;<code>400 Bad Request</code>.<br>
❌&nbsp;<strong>No verificar el método HTTP</strong>&nbsp;(GET vs POST).</p>

<hr>
<h2><strong>🚀 Ejemplo con API Real</strong></h2>

<p>Prueba estos endpoints públicos:</p>

<ul>
	<li>
	<p><strong>REST Countries:</strong>&nbsp;<code>GET</code>&nbsp;<a href="https://restcountries.com/v3.1/name/argentina" rel="noreferrer" target="_blank">https://restcountries.com/v3.1/name/argentina</a></p>
	</li>
	<li>
	<p><strong>The Cat API:</strong>&nbsp;<code>GET</code>&nbsp;<a href="https://api.thecatapi.com/v1/images/search" rel="noreferrer" target="_blank">https://api.thecatapi.com/v1/images/search</a></p>
	</li>
</ul>

<hr>
<h2><strong>🔗 Recursos Adicionales</strong></h2>

<ol start="1">
	<li>
	<p><strong>Documentación oficial:</strong>&nbsp;<a href="https://learning.postman.com/" rel="noreferrer" target="_blank">Postman Learning Center</a></p>
	</li>
	<li>
	<p><strong>Colección de ejemplos:</strong>&nbsp;<a href="https://www.postman.com/templates/" rel="noreferrer" target="_blank">Postman Templates</a></p>
	</li>
</ol>

<blockquote>
<p><em>"Postman es el ''probar antes de implementar'' del desarrollo de APIs."</em></p>

<hr>
<p>&nbsp;</p>
</blockquote>
', 1, 500, 750, N'https://www.youtube.com/watch?v=qsejysrhJiU', N'<iframe width="750" height="500" src="https://www.youtube.com/embed/qsejysrhJiU" ></iframe>')
GO
SET IDENTITY_INSERT [dbo].[Leccion] OFF
GO
SET IDENTITY_INSERT [dbo].[Debate] ON 
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (1, 1, 1, N'Normas de la Comunidad | Foro de Dudas 🚨', N'<p><strong>📌 Normas de la Comunidad | Foro de Dudas</strong></p>

<p>&iexcl;Bienvenido/a al foro de dudas de [MisCursos]! 🎓✨ Este espacio est&aacute; dise&ntilde;ado para que resuelvas tus inquietudes, compartas conocimientos y aprendas en comunidad. Para mantener un ambiente respetuoso y productivo, por favor sigue estas normas:</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<h3>🔹&nbsp;<strong>1. S&eacute; claro y espec&iacute;fico en tus preguntas</strong></h3>

<ul>
	<li>
	<p>Describe tu duda de manera detallada (ej.: menciona el curso, lecci&oacute;n o tema).</p>
	</li>
	<li>
	<p>Evita titulos gen&eacute;ricos como&nbsp;<em>&quot;Ayuda&quot;</em>&nbsp;o&nbsp;<em>&quot;No entiendo&quot;</em>. Mejor:&nbsp;*&quot;Duda sobre ejercicio de Python (Curso B&aacute;sico - Lecci&oacute;n 5)&quot;*.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>2. Mant&eacute;n el respeto</strong></h3>

<ul>
	<li>
	<p>Trata a todos con amabilidad. No se toleran insultos, discriminaci&oacute;n o comentarios ofensivos.</p>
	</li>
	<li>
	<p>Si no est&aacute;s de acuerdo con una respuesta, discute con argumentos, no con ataques.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>3. Evita el spam o autopromoci&oacute;n</strong></h3>

<ul>
	<li>
	<p>No compartas enlaces externos no relacionados, publicidad o contenido repetitivo.</p>
	</li>
	<li>
	<p>Si quieres recomendar un recurso, aseg&uacute;rate de que sea relevante para la duda planteada.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>4. Usa el espacio correcto</strong></h3>

<ul>
	<li>
	<p>Publica cada duda en la categor&iacute;a correspondiente (ej.:&nbsp;<em>&quot;Dise&ntilde;o Gr&aacute;fico&quot;</em>,&nbsp;<em>&quot;Programaci&oacute;n&quot;</em>, etc.).</p>
	</li>
	<li>
	<p>Si tu pregunta es sobre problemas t&eacute;cnicos (acceso, plataforma, etc.), usa el soporte oficial.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>5. Revisa antes de publicar</strong></h3>

<ul>
	<li>
	<p>Busca si tu duda ya fue respondida antes de abrir un nuevo hilo.</p>
	</li>
	<li>
	<p>Si encuentras la soluci&oacute;n, marca la respuesta correcta o comp&aacute;rtela para ayudar a otros.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>6. No compartas contenido protegido</strong></h3>

<ul>
	<li>
	<p>Est&aacute; prohibido publicar material de pago (PDFs, videos, etc.) o violar derechos de autor.</p>
	</li>
</ul>

<h3>🚨&nbsp;<strong>Consecuencias por incumplimiento</strong></h3>

<ul>
	<li>
	<p>Los posts que rompan las normas ser&aacute;n editados o eliminados.</p>
	</li>
	<li>
	<p>Usuarios reincidentes podr&iacute;an recibir advertencias o ser suspendidos.</p>
	</li>
</ul>

<p>&iexcl;Gracias por colaborar para hacer de este foro un lugar &uacute;til e inclusivo! 💡 Si tienes dudas sobre las normas, contacta a los moderadores.</p>

<p><strong>&iexcl;Aprende, comparte y crece con nosotros!</strong>&nbsp;🚀</p>', CAST(N'2025-06-30T22:19:16.053' AS DateTime), CAST(N'2025-06-30T22:47:29.647' AS DateTime), 1, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (2, 1, 1, N'¡Bienvenidos/as a Fundamentos y Práctica de Bases de Datos! 🎉 ', N'<h3>&iexcl;Nos alegra tenerte aqu&iacute;! 🚀 En este curso, aprender&aacute;s los conceptos esenciales para dise&ntilde;ar, gestionar y trabajar con bases de datos de manera eficiente, desde lo b&aacute;sico hasta aplicaciones pr&aacute;cticas.</h3>

<p>&nbsp;</p>

<h3>📌&nbsp;<strong>Qu&eacute; esperar del curso:</strong></h3>

<ul>
	<li>
	<p><strong>Fundamentos te&oacute;ricos</strong>: Modelos de datos, SQL, normalizaci&oacute;n y m&aacute;s.</p>
	</li>
	<li>
	<p><strong>Ejercicios pr&aacute;cticos</strong>: Crear&aacute;s y manipular&aacute;s tus propias bases de datos.</p>
	</li>
	<li>
	<p><strong>Proyectos reales</strong>: Aplicar&aacute;s lo aprendido en casos simulados o personales.</p>
	</li>
	<li>
	<p><strong>Soporte continuo</strong>: Foros de dudas, retroalimentaci&oacute;n y recursos adicionales.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>Recomendaciones para aprovecharlo al m&aacute;ximo:</strong></h3>

<ol start="1">
	<li>
	<p><strong>Dedica tiempo constante</strong>: Practica con los ejercicios y proyectos.</p>
	</li>
	<li>
	<p><strong>Participa en el foro</strong>: Resuelve dudas y ayuda a tus compa&ntilde;eros.</p>
	</li>
	<li>
	<p><strong>Experimenta</strong>: No te limites a lo visto en clase; prueba tus propias consultas y dise&ntilde;os.</p>
	</li>
</ol>

<h3>📢&nbsp;<strong>Importante:</strong></h3>

<ul>
	<li>
	<p>El material (videos, gu&iacute;as y ejercicios) estar&aacute; disponible las 24/7, pero sigue el calendario sugerido para no retrasarte.</p>
	</li>
	<li>
	<p>Si tienes problemas t&eacute;cnicos o con el contenido, escr&iacute;benos a [correo/soporte] o usa el foro del curso.</p>
	</li>
</ul>

<p>&iexcl;Estamos aqu&iacute; para que domines las bases de datos y apliques ese conocimiento en tu carrera o proyectos! 💻🔍</p>

<p><strong>&iexcl;Manos a la obra!</strong><br />
<em>El equipo de [MisCursos]</em></p>', CAST(N'2025-06-30T22:52:03.350' AS DateTime), CAST(N'2025-06-30T22:54:54.410' AS DateTime), 1, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (3, 1, 2, N'Normas de la Comunidad | Foro de Dudas 🚨', N'<p><strong>📌 Normas de la Comunidad | Foro de Dudas</strong></p>

<p>&iexcl;Bienvenido/a al foro de dudas de [MisCursos]! 🎓✨ Este espacio est&aacute; dise&ntilde;ado para que resuelvas tus inquietudes, compartas conocimientos y aprendas en comunidad. Para mantener un ambiente respetuoso y productivo, por favor sigue estas normas:</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<h3>🔹&nbsp;<strong>1. S&eacute; claro y espec&iacute;fico en tus preguntas</strong></h3>

<ul>
	<li>
	<p>Describe tu duda de manera detallada (ej.: menciona el curso, lecci&oacute;n o tema).</p>
	</li>
	<li>
	<p>Evita titulos gen&eacute;ricos como&nbsp;<em>&quot;Ayuda&quot;</em>&nbsp;o&nbsp;<em>&quot;No entiendo&quot;</em>. Mejor:&nbsp;*&quot;Duda sobre ejercicio de Python (Curso B&aacute;sico - Lecci&oacute;n 5)&quot;*.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>2. Mant&eacute;n el respeto</strong></h3>

<ul>
	<li>
	<p>Trata a todos con amabilidad. No se toleran insultos, discriminaci&oacute;n o comentarios ofensivos.</p>
	</li>
	<li>
	<p>Si no est&aacute;s de acuerdo con una respuesta, discute con argumentos, no con ataques.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>3. Evita el spam o autopromoci&oacute;n</strong></h3>

<ul>
	<li>
	<p>No compartas enlaces externos no relacionados, publicidad o contenido repetitivo.</p>
	</li>
	<li>
	<p>Si quieres recomendar un recurso, aseg&uacute;rate de que sea relevante para la duda planteada.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>4. Usa el espacio correcto</strong></h3>

<ul>
	<li>
	<p>Publica cada duda en la categor&iacute;a correspondiente (ej.:&nbsp;<em>&quot;Dise&ntilde;o Gr&aacute;fico&quot;</em>,&nbsp;<em>&quot;Programaci&oacute;n&quot;</em>, etc.).</p>
	</li>
	<li>
	<p>Si tu pregunta es sobre problemas t&eacute;cnicos (acceso, plataforma, etc.), usa el soporte oficial.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>5. Revisa antes de publicar</strong></h3>

<ul>
	<li>
	<p>Busca si tu duda ya fue respondida antes de abrir un nuevo hilo.</p>
	</li>
	<li>
	<p>Si encuentras la soluci&oacute;n, marca la respuesta correcta o comp&aacute;rtela para ayudar a otros.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>6. No compartas contenido protegido</strong></h3>

<ul>
	<li>
	<p>Est&aacute; prohibido publicar material de pago (PDFs, videos, etc.) o violar derechos de autor.</p>
	</li>
</ul>

<h3>🚨&nbsp;<strong>Consecuencias por incumplimiento</strong></h3>

<ul>
	<li>
	<p>Los posts que rompan las normas ser&aacute;n editados o eliminados.</p>
	</li>
	<li>
	<p>Usuarios reincidentes podr&iacute;an recibir advertencias o ser suspendidos.</p>
	</li>
</ul>

<p>&iexcl;Gracias por colaborar para hacer de este foro un lugar &uacute;til e inclusivo! 💡 Si tienes dudas sobre las normas, contacta a los moderadores.</p>

<p><strong>&iexcl;Aprende, comparte y crece con nosotros!</strong>&nbsp;🚀</p>', CAST(N'2025-06-30T22:19:16.053' AS DateTime), CAST(N'2025-06-30T22:47:29.647' AS DateTime), 1, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (4, 1, 2, N'¡Bienvenidos/as a Programación Básica con Python! 🐍', N'<h3>&iexcl;Es hora de dar tus primeros pasos en el mundo de la programaci&oacute;n! 🎉 En este curso, aprender&aacute;s los fundamentos de Python, uno de los lenguajes m&aacute;s vers&aacute;tiles y demandados, desde cero y con un enfoque 100% pr&aacute;ctico.</h3>

<p>&nbsp;</p>

<h3>📌&nbsp;<strong>Qu&eacute; vas a lograr en este curso:</strong></h3>

<ul>
	<li>
	<p><strong>Domina lo esencial</strong>: Variables, condicionales, bucles, funciones y estructuras de datos.</p>
	</li>
	<li>
	<p><strong>Proyectos reales</strong>: Desde scripts simples hasta mini-aplicaciones interactivas.</p>
	</li>
	<li>
	<p><strong>Pensamiento algor&iacute;tmico</strong>: Resolver problemas como un programador/a.</p>
	</li>
	<li>
	<p><strong>Preparaci&oacute;n para avanzar</strong>: Bases s&oacute;lidas para especializarte en ciencia de datos, web, IA, y m&aacute;s.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>Tips para triunfar:</strong></h3>

<ol start="1">
	<li>
	<p><strong>Practica todos los d&iacute;as</strong>: &iexcl;Python se aprende escribiendo c&oacute;digo! Usa los ejercicios y retos opcionales.</p>
	</li>
	<li>
	<p><strong>No te rindas ante los errores</strong>: Los &quot;bugs&quot; son parte del aprendizaje (y siempre habr&aacute; soluci&oacute;n en el foro).</p>
	</li>
	<li>
	<p><strong>Experimenta</strong>: Modifica el c&oacute;digo de las lecciones y crea tus propias variantes.</p>
	</li>
</ol>

<h3>📢&nbsp;<strong>Recuerda:</strong></h3>

<ul>
	<li>
	<p>El material (videoclases, ejemplos y actividades) est&aacute; disponible&nbsp;<strong>24/7</strong>, pero te recomendamos seguir el ritmo semanal.</p>
	</li>
	<li>
	<p>&iquest;Atascado/a? Usa el&nbsp;<strong>foro de dudas</strong>&nbsp;o cont&aacute;ctanos en [correo/soporte]. &iexcl;Nadie se queda atr&aacute;s!</p>
	</li>
</ul>

<p><strong>Python es poder, y ahora es tu turno de usarlo.</strong>&nbsp;&iexcl;Vamos a programar! 💻✨</p>

<p><em>El equipo de [MisCursos]</em></p>', CAST(N'2025-06-30T22:56:07.493' AS DateTime), NULL, 0, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (5, 1, 3, N'Normas de la Comunidad | Foro de Dudas 🚨', N'<p><strong>📌 Normas de la Comunidad | Foro de Dudas</strong></p>

<p>&iexcl;Bienvenido/a al foro de dudas de [MisCursos]! 🎓✨ Este espacio est&aacute; dise&ntilde;ado para que resuelvas tus inquietudes, compartas conocimientos y aprendas en comunidad. Para mantener un ambiente respetuoso y productivo, por favor sigue estas normas:</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<h3>🔹&nbsp;<strong>1. S&eacute; claro y espec&iacute;fico en tus preguntas</strong></h3>

<ul>
	<li>
	<p>Describe tu duda de manera detallada (ej.: menciona el curso, lecci&oacute;n o tema).</p>
	</li>
	<li>
	<p>Evita titulos gen&eacute;ricos como&nbsp;<em>&quot;Ayuda&quot;</em>&nbsp;o&nbsp;<em>&quot;No entiendo&quot;</em>. Mejor:&nbsp;*&quot;Duda sobre ejercicio de Python (Curso B&aacute;sico - Lecci&oacute;n 5)&quot;*.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>2. Mant&eacute;n el respeto</strong></h3>

<ul>
	<li>
	<p>Trata a todos con amabilidad. No se toleran insultos, discriminaci&oacute;n o comentarios ofensivos.</p>
	</li>
	<li>
	<p>Si no est&aacute;s de acuerdo con una respuesta, discute con argumentos, no con ataques.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>3. Evita el spam o autopromoci&oacute;n</strong></h3>

<ul>
	<li>
	<p>No compartas enlaces externos no relacionados, publicidad o contenido repetitivo.</p>
	</li>
	<li>
	<p>Si quieres recomendar un recurso, aseg&uacute;rate de que sea relevante para la duda planteada.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>4. Usa el espacio correcto</strong></h3>

<ul>
	<li>
	<p>Publica cada duda en la categor&iacute;a correspondiente (ej.:&nbsp;<em>&quot;Dise&ntilde;o Gr&aacute;fico&quot;</em>,&nbsp;<em>&quot;Programaci&oacute;n&quot;</em>, etc.).</p>
	</li>
	<li>
	<p>Si tu pregunta es sobre problemas t&eacute;cnicos (acceso, plataforma, etc.), usa el soporte oficial.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>5. Revisa antes de publicar</strong></h3>

<ul>
	<li>
	<p>Busca si tu duda ya fue respondida antes de abrir un nuevo hilo.</p>
	</li>
	<li>
	<p>Si encuentras la soluci&oacute;n, marca la respuesta correcta o comp&aacute;rtela para ayudar a otros.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>6. No compartas contenido protegido</strong></h3>

<ul>
	<li>
	<p>Est&aacute; prohibido publicar material de pago (PDFs, videos, etc.) o violar derechos de autor.</p>
	</li>
</ul>

<h3>🚨&nbsp;<strong>Consecuencias por incumplimiento</strong></h3>

<ul>
	<li>
	<p>Los posts que rompan las normas ser&aacute;n editados o eliminados.</p>
	</li>
	<li>
	<p>Usuarios reincidentes podr&iacute;an recibir advertencias o ser suspendidos.</p>
	</li>
</ul>

<p>&iexcl;Gracias por colaborar para hacer de este foro un lugar &uacute;til e inclusivo! 💡 Si tienes dudas sobre las normas, contacta a los moderadores.</p>

<p><strong>&iexcl;Aprende, comparte y crece con nosotros!</strong>&nbsp;🚀</p>', CAST(N'2025-06-30T22:19:16.053' AS DateTime), CAST(N'2025-06-30T22:47:29.647' AS DateTime), 1, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (6, 1, 3, N'¡Bienvenidos/as a Fundamentos de Inteligencia Artificial! 🤖', N'<h4><strong>El futuro est&aacute; aqu&iacute;, y t&uacute; est&aacute;s a punto de construirlo.</strong>&nbsp;🌟 En este curso, desmitificaremos la IA desde sus bases te&oacute;ricas hasta aplicaciones reales, prepar&aacute;ndote para entender (&iexcl;y dominar!) una de las tecnolog&iacute;as m&aacute;s disruptivas de nuestro tiempo.</h4>

<p>&nbsp;</p>

<h3>🔍&nbsp;<strong>Qu&eacute; explorar&aacute;s en este viaje:</strong></h3>

<ul>
	<li>
	<p><strong>Conceptos clave</strong>: Aprendizaje autom&aacute;tico, redes neuronales, procesamiento de lenguaje natural y &eacute;tica en IA.</p>
	</li>
	<li>
	<p><strong>Herramientas esenciales</strong>: Frameworks como TensorFlow o PyTorch (seg&uacute;n enfoque del curso).</p>
	</li>
	<li>
	<p><strong>Casos de uso</strong>: Desde reconocimiento de im&aacute;genes hasta sistemas predictivos.</p>
	</li>
	<li>
	<p><strong>Impacto real</strong>: C&oacute;mo la IA est&aacute; transformando industrias y c&oacute;mo t&uacute; puedes ser parte de ese cambio.</p>
	</li>
</ul>

<h3>🛠️&nbsp;<strong>Para aprovechar al m&aacute;ximo el curso:</strong></h3>

<ol start="1">
	<li>
	<p><strong>Curiosidad activa</strong>: La IA evoluciona r&aacute;pido&mdash;investiga siempre m&aacute;s all&aacute; de lo visto en clase.</p>
	</li>
	<li>
	<p><strong>Matem&aacute;ticas aplicadas</strong>: No temas a la estad&iacute;stica o el &aacute;lgebra; las explicaremos en contexto.</p>
	</li>
	<li>
	<p><strong>Experimentation</strong>: Juega con los modelos, ajusta par&aacute;metros y falla r&aacute;pido (los mejores algoritmos surgieron de errores).</p>
	</li>
</ol>

<h3>⚠️&nbsp;<strong>Avisos clave:</strong></h3>

<ul>
	<li>
	<p><strong>Prerrequisitos</strong>: Conocimientos b&aacute;sicos de programaci&oacute;n (Python recomendado) y l&oacute;gica matem&aacute;tica.</p>
	</li>
	<li>
	<p><strong>Foro de debates</strong>: Discutiremos noticias de IA, dilemas &eacute;ticos y proyectos innovadores&mdash;&iexcl;tu voz cuenta!</p>
	</li>
	<li>
	<p><strong>Soporte</strong>: &iquest;Problemas t&eacute;cnicos o conceptuales? Escr&iacute;benos a [correo/soporte] o usa el canal #dudas-en-ia.</p>
	</li>
</ul>

<p><strong>&quot;La IA no reemplazar&aacute; a los humanos, pero los humanos que usan IA s&iacute;.&quot;</strong><br />
Prep&aacute;rate para ser uno de ellos. 🚀</p>

<p><em>El equipo de [MisCursos]</em></p>', CAST(N'2025-06-30T22:58:58.277' AS DateTime), NULL, 0, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (7, 1, 4, N'Normas de la Comunidad | Foro de Dudas 🚨', N'<p><strong>📌 Normas de la Comunidad | Foro de Dudas</strong></p>

<p>&iexcl;Bienvenido/a al foro de dudas de [MisCursos]! 🎓✨ Este espacio est&aacute; dise&ntilde;ado para que resuelvas tus inquietudes, compartas conocimientos y aprendas en comunidad. Para mantener un ambiente respetuoso y productivo, por favor sigue estas normas:</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<h3>🔹&nbsp;<strong>1. S&eacute; claro y espec&iacute;fico en tus preguntas</strong></h3>

<ul>
	<li>
	<p>Describe tu duda de manera detallada (ej.: menciona el curso, lecci&oacute;n o tema).</p>
	</li>
	<li>
	<p>Evita titulos gen&eacute;ricos como&nbsp;<em>&quot;Ayuda&quot;</em>&nbsp;o&nbsp;<em>&quot;No entiendo&quot;</em>. Mejor:&nbsp;*&quot;Duda sobre ejercicio de Python (Curso B&aacute;sico - Lecci&oacute;n 5)&quot;*.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>2. Mant&eacute;n el respeto</strong></h3>

<ul>
	<li>
	<p>Trata a todos con amabilidad. No se toleran insultos, discriminaci&oacute;n o comentarios ofensivos.</p>
	</li>
	<li>
	<p>Si no est&aacute;s de acuerdo con una respuesta, discute con argumentos, no con ataques.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>3. Evita el spam o autopromoci&oacute;n</strong></h3>

<ul>
	<li>
	<p>No compartas enlaces externos no relacionados, publicidad o contenido repetitivo.</p>
	</li>
	<li>
	<p>Si quieres recomendar un recurso, aseg&uacute;rate de que sea relevante para la duda planteada.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>4. Usa el espacio correcto</strong></h3>

<ul>
	<li>
	<p>Publica cada duda en la categor&iacute;a correspondiente (ej.:&nbsp;<em>&quot;Dise&ntilde;o Gr&aacute;fico&quot;</em>,&nbsp;<em>&quot;Programaci&oacute;n&quot;</em>, etc.).</p>
	</li>
	<li>
	<p>Si tu pregunta es sobre problemas t&eacute;cnicos (acceso, plataforma, etc.), usa el soporte oficial.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>5. Revisa antes de publicar</strong></h3>

<ul>
	<li>
	<p>Busca si tu duda ya fue respondida antes de abrir un nuevo hilo.</p>
	</li>
	<li>
	<p>Si encuentras la soluci&oacute;n, marca la respuesta correcta o comp&aacute;rtela para ayudar a otros.</p>
	</li>
</ul>

<h3>🔹&nbsp;<strong>6. No compartas contenido protegido</strong></h3>

<ul>
	<li>
	<p>Est&aacute; prohibido publicar material de pago (PDFs, videos, etc.) o violar derechos de autor.</p>
	</li>
</ul>

<h3>🚨&nbsp;<strong>Consecuencias por incumplimiento</strong></h3>

<ul>
	<li>
	<p>Los posts que rompan las normas ser&aacute;n editados o eliminados.</p>
	</li>
	<li>
	<p>Usuarios reincidentes podr&iacute;an recibir advertencias o ser suspendidos.</p>
	</li>
</ul>

<p>&iexcl;Gracias por colaborar para hacer de este foro un lugar &uacute;til e inclusivo! 💡 Si tienes dudas sobre las normas, contacta a los moderadores.</p>

<p><strong>&iexcl;Aprende, comparte y crece con nosotros!</strong>&nbsp;🚀</p>', CAST(N'2025-06-30T22:19:16.053' AS DateTime), CAST(N'2025-06-30T22:47:29.647' AS DateTime), 1, 1, 1)
GO
INSERT [dbo].[Debate] ([IdDebate], [IdUsuario], [IdOrigen], [Titulo], [Contenido], [FechaCreacion], [FechaEdicion], [EsEditado], [EsAviso], [Activo]) VALUES (8, 1, 4, N'¡Bienvenidos al curso "APIs desde Cero"! 🚀', N'<p><strong>&iexcl;Prep&aacute;rate para conectar el mundo digital!</strong>&nbsp;🌍 En este curso, dominar&aacute;s el arte de crear, consumir y gestionar APIs, el puente esencial entre aplicaciones y servicios modernos.</p>

<p>&nbsp;</p>

<h3>🔥&nbsp;<strong>Qu&eacute; lograr&aacute;s en este curso:</strong></h3>

<ul>
	<li>
	<p><strong>Conceptos clave</strong>: Entender qu&eacute; son las APIs, REST, GraphQL, SOAP y c&oacute;mo funcionan</p>
	</li>
	<li>
	<p><strong>Desarrollo pr&aacute;ctico</strong>: Construir&aacute;s tus propias APIs desde cero</p>
	</li>
	<li>
	<p><strong>Consumo de APIs</strong>: Aprender&aacute;s a integrar servicios externos en tus proyectos</p>
	</li>
	<li>
	<p><strong>Seguridad y buenas pr&aacute;cticas</strong>: Autenticaci&oacute;n (JWT, OAuth), manejo de errores y documentaci&oacute;n</p>
	</li>
</ul>

<h3>🛠️&nbsp;<strong>Requisitos para el &eacute;xito:</strong></h3>

<ol start="1">
	<li>
	<p><strong>Mentalidad de integraci&oacute;n</strong>: Las APIs son sobre comunicaci&oacute;n entre sistemas</p>
	</li>
	<li>
	<p><strong>Conocimientos b&aacute;sicos</strong>&nbsp;de programaci&oacute;n (preferiblemente JavaScript/Python)</p>
	</li>
	<li>
	<p><strong>Herramientas esenciales</strong>: Postman, cURL o Insomnia para probar tus APIs</p>
	</li>
	<li>
	<p><strong>Curiosidad por explorar</strong>: &iexcl;Hay miles de APIs p&uacute;blicas esperando por ti!</p>
	</li>
</ol>

<h3>💡&nbsp;<strong>Tips para aprovechar al m&aacute;ximo:</strong></h3>

<ul>
	<li>
	<p><strong>Practica con ejemplos reales</strong>: Clima, redes sociales, pagos, etc.</p>
	</li>
	<li>
	<p><strong>Documenta tus proyectos</strong>: Usa Swagger/OpenAPI</p>
	</li>
	<li>
	<p><strong>&Uacute;nete a la comunidad</strong>: Comparte tus dudas y proyectos en el foro</p>
	</li>
</ul>

<h3>📌&nbsp;<strong>Importante:</strong></h3>

<ul>
	<li>
	<p><strong>Foro activo</strong>: Usa #dudas-api para preguntas t&eacute;cnicas</p>
	</li>
	<li>
	<p><strong>Proyecto final</strong>: Crear&aacute;s tu propia API funcional</p>
	</li>
	<li>
	<p><strong>Soporte</strong>: Equipo disponible en [correo/soporte]</p>
	</li>
</ul>

<p><strong>&quot;En el mundo digital, las APIs son los nuevos diplom&aacute;ticos&quot;</strong><br />
&iexcl;Comienza tu viaje para dominar este lenguaje universal!</p>

<p><em>El equipo de [MisCursos]</em></p>', CAST(N'2025-06-30T23:00:27.230' AS DateTime), NULL, 0, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Debate] OFF
GO

INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(4, 1, '¿Cuándo aplicar la tercera forma normal?', 
'Estoy diseñando una DB para un sistema de ventas y tengo dudas sobre cuándo es estrictamente necesario normalizar hasta 3FN. ¿Algún ejemplo práctico donde sea contraproducente?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(7, 1, 'Índices en MySQL - ¿Cuántos son demasiados?', 
'En mi tabla de usuarios (500k registros) ya tengo 5 índices. Noté que las inserciones son más lentas. ¿Existe un límite recomendado o depende del uso?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(2, 1, 'SQL vs NoSQL para proyecto nuevo', 
'Voy a desarrollar una app de gestión de contenido con muchos datos semi-estructurados. ¿Recomiendan PostgreSQL o MongoDB? ¿Qué criterios debo priorizar?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(5, 2, '¿Cuándo usar for vs while en Python?', 
'Estoy haciendo los ejercicios de bucles pero no termino de entender en qué casos es mejor usar un "for" en lugar de un "while". ¿Podrían darme ejemplos concretos de cada uso?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(3, 2, 'Error al modificar lista dentro de función', 
'Cuando paso una lista a una función y la modifico, los cambios se mantienen fuera de la función. ¿Por qué pasa esto si Python pasa los argumentos por valor? ¿Es un bug?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(8, 2, '¿Qué librerías de Python debo aprender después de lo básico?', 
'Ya domino los fundamentos del lenguaje. ¿Qué módulos o librerías recomiendan para seguir avanzando? Estoy entre Pandas para datos o Flask para web, pero no sé cuál tiene mejor salida laboral.')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(6, 3, '¿Cómo elegir entre Random Forest y Red Neuronal para mi dataset?', 
'Tengo datos tabulares con 10,000 registros y 15 características. ¿Qué modelo sería más adecuado para comenzar y por qué? Me preocupa el overfitting con redes neuronales.')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(9, 3, '¿Realmente las IA "aprenden" o solo memorizan patrones?', 
'Después de la lección sobre backpropagation, me quedó la duda: ¿en qué punto podemos decir que un modelo realmente "aprende" en lugar de simplemente optimizar una función matemática compleja?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(2, 3, 'Error en TensorFlow: "Failed to convert a NumPy array to a Tensor"', 
'Al entrenar mi primer modelo, obtengo este error aunque mis datos parecen estar bien formateados. Adjunto código y sample de datos. ¿Alguien ha enfrentado esto?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(7, 4, '¿JWT vs OAuth2 para API de microservicios?', 
'Estoy diseñando un sistema con 3 microservicios que necesitan compartir autenticación. ¿Cuál método recomiendan para mantener la seguridad sin afectar el rendimiento? Ejemplos prácticos serían útiles.')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(4, 4, 'Error CORS al consumir API desde frontend React', 
'Mi API en Node.js funciona bien en Postman pero al llamarla desde React obtengo "No Access-Control-Allow-Origin". Ya probé los middlewares básicos. ¿Solución definitiva para entornos de desarrollo/producción?')
GO
INSERT INTO Debate(IdUsuario, IdOrigen, Titulo, Contenido) 
VALUES(10, 4, 'REST vs GraphQL para e-commerce emergente', 
'Vamos a desarrollar la API para nuestra tienda online (1000 productos, 50k usuarios). ¿Qué arquitectura recomiendan considerando escalabilidad y velocidad de desarrollo?')
