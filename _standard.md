OBJETIVO

Este documento tiene por objetivo establecer los estándares que se emplearán en la programación y documentación de la aplicación desarrollada.

ALCANCE

Aplicación desarrollada por el equipo conjunto de desarrollo del curso de Base de datos II, del VI ciclo de ESIS - UNJBG.

DIRECTORIOS Y ARCHIVOS

Los archivos que conforman los proyectos de desarrollo se almacenarán en un directorio cuyo nombre será el número de solicitud que lo generó y una breve descripción. Este directorio estará en el servidor asignado.

TipoSolicitud-NúmeroSolicitud-Descripcion

Donde:

TipoSolicitud: SN=Solicitud nuevo sistema, SM=Solicitud mantenimiento

Ejemplo:
SM-067-2011-Logística

Los script de la base de datos de los pases a producción serán almacenados por el DBA y nombrados de acuerdo a lo siguiente:

TipoSolicitud-NúmeroSolicitud-Descripcion

Donde:

TipoSolicitud: SN=Solicitud nuevo sistema, SM=Solicitud mantenimiento

Ejemplo:
SM-067-2011-Logística.sql

CRONOGRAMA DEL PROYECTO

Los nuevos sistemas y mantenimientos mayores tendrán un cronograma asociado, el mismo que se almacenará en el directorio de red asignado al seguimiento de proyectos, con el siguiente nombre:

TipoSolicitud-NúmeroSolicitud-Descripcion

Donde:

TipoSolicitud: SN=Solicitud nuevo sistema, SM=Solicitud mantenimiento

Ejemplo:
SM-067-2011-Logística.mpp

Este cronograma se creará de acuerdo con el archivo PlantillaProyectos.mpp, modificado a propuesta del desarrollador según corresponda a cada trabajo encomendado.

ESTÁNDAR DE CONFIGURACIÓN DE BASE DE DATOS

Durante la instalación del servidor se recomienda utilizar el conjunto de caracteres UTF-8, ya que garantiza la representación de todos los caracteres Unicode, incluyendo letras acentuadas y la letra ñ, además de mantener compatibilidad con el ASCII básico. Para el ordenamiento y las comparaciones de cadenas se debe establecer un collation insensible a mayúsculas y minúsculas (case insensitive), lo que permite que valores como Ana, ana o ANA sean tratados como equivalentes y que el ordenamiento se realice de forma natural para los usuarios. Esta configuración asegura que la base de datos maneje correctamente tanto búsquedas como ordenamientos de texto, evitando problemas de compatibilidad y facilitando la interacción con los datos en diferentes entornos.

OBJETOS DE LA BASE DE DATOS
DEFINICIÓN DE LOS DATOS (DDL)

Este documento tiene por objetivo establecer los estándares que se emplearán en la programación y documentación.

CREATE: Permite crear nuevos objetos (tablas, funciones, vistas, índices, etc.) en la base de datos.

CREATE TABLE table_name (
    column1_name data_type [column_constraint],
    column2_name data_type [column_constraint],
    ...
    columnN_name data_type [column_constraint],
    [table_constraint]
);

CREATE TABLE oficina_usuario (
    id SERIAL PRIMARY KEY NOT NULL,
    nombre VARCHAR(15) NOT NULL
);

ALTER: Modifica la definición de un objeto existente, ya sea agregando, cambiando o eliminando atributos.

ALTER TABLE table_name
ADD COLUMN column_name data_type [column_constraint];

ALTER TABLE oficina_usuario
ADD COLUMN direccion VARCHAR(50);

DROP: Elimina un objeto de la base de datos de manera permanente.

   	     DROP TABLE [IF EXISTS] table_name [CASCADE | RESTRICT];

DEFINICIÓN DE LOS DATOS (DDL)
El Lenguaje de Manipulación de Datos (DML) permite realizar operaciones sobre los registros almacenados en las tablas de la base de datos.
Incluye las sentencias:

SELECT: Consultar registros.
SELECT column1, column2, ...
FROM table_name
[WHERE condition]
[ORDER BY column1, column2, ... [ASC | DESC]];

INSERT: Insertar nuevos registros.
INSERT INTO table_name (column1, column2, column3)
VALUES (value1, value2, value3);

UPDATE: Modificar registros existentes.
UPDATE table_name
SET column = value'
[WHERE condition];

DELETE: Eliminar registros existentes.
DELETE FROM table_name
[WHERE condition];

LENGUAJE DE CONTROL DE DATOS (DCL)

El Lenguaje de Control de Datos (DCL) permite definir y gestionar los permisos de acceso a los objetos de la base de datos.
Incluye principalmente las sentencias:

GRANT: Concede permisos a usuarios o roles.

REVOKE privilege [, ...] ON TABLE table_name [, ...] FROM role_name [, ...];

GRANT SELECT ON oficinas_usuarios TO usuario1;

REVOKE: Revocar permisos previamente otorgados.

REVOKE INSERT ON oficina_usuario FROM usuario1;


Normas Generales de Nomenclatura
El tamaño de los identificadores varía desde 1 hasta 63 caracteres, incluyendo letras, símbolos y números. Los identificadores de todos los objetos (tablas, columnas, entre otros) deben cumplir los siguientes requisitos:

Los identificadores pueden contener letras (a–z)(A–Z), dígitos (0–9) y guión bajo (_).
No se permiten espacios en blanco dentro de los identificadores.
Todos los identificadores deben escribirse en minúsculas.
En caso de nombres compuestos por varias palabras, se debe utilizar el formato snake_case.

Nomenclatura de Base de Datos
El nombre de la base de datos debe reflejar el sistema o aplicación a la que pertenece.

Prefijo
NombreBaseDatos = AliasAplicacion_SufijoBaseDatos
Ejemplo
La aplicación administradora de recursos humanos tiene como alias: admi.
Base de datos principal		:	admi_db 
Base de datos para pruebas	:	admi_test 
Base de datos de desarrollo	:	admi_dev
Comentarios
El nombre físico de la base de datos debe corresponder al alias de la aplicación.


Nomenclatura de Tablas

Prefijo
NombreTabla = NombreTabla
Comentarios
Las tablas se nombrarán en singular.
El nombre debe ser lo más descriptivo posible, colocando al final del mismo la descripción complementaria que indique si es un detalle, tabla de control, histórica, de auditoría, entre otros.
El nombre de la tabla debe ser descriptivo, en singular y usando subguión si fuese más de una palabra necesaria para el nombramiento de la tabla.
El nombre de la tabla debe identificar claramente a la entidad del sistema con un nombre completo.
Una Tabla hija debe llevar el nombre de la tabla padre hasta un máximo de un nivel.
Las tablas deberán llevar campos de auditoría, tales como el usuario creador, fecha creación, usuario modificador, fecha de modificación.
Los campos identificadores de las tablas utilizan el prefijo “id”.
Ejemplo
Antes
Ahora
IngresoCabecera
ingreso_cabecera
Pecosa
pecosa
DetallePecosa
pecosa_detalle
ALiquidacion
liquidacion_auditoria
UsuarioCentroCosto
usuario_centro_costo
HistoricoBien
bien_historico
Notas
Para tablas temporales, añadir el sufijo “_temp” al final.
(sav_producto_temp)



Nomenclatura de Parámetros

Prefijo
NombreParametroCampo = MuyDescriptivos
Ejemplo
La Tabla Personal por lo cual tiene los siguientes campos:
id
apellido_paterno
Comentarios
Los nombres de los campos deben ser descriptivos.
Se deben usar subguión para diferenciar los grupos de identificación en el nombre.


Nomenclatura de Constraints

Prefijo
PK		:	pk_NombreTabla
FK	:   fk_NombreTablaOrigen_NombreTablaReferenciada
Unique	:	uq_NemónicoTabla_NombreUnique
Default	:	df_NemónicoTabla_NombreColumna
Check		:	ch_NemonicoTabla_NombreCheck
Ejemplo
pk_orden_compra
fk_orden_compra_detalle_orden_compra
uq_funcionario_promocion_apellido_nombre
df_funcionario_promocion_sede_oficina
ch_usuario_potencial_telefono


Nomenclatura de Índices

Prefijo
Cluster	:	ic_ NombreTabla_NombreIndice
Ejemplo
No Cluster	:	id_ NombreTabla_NombreIndice
Comentarios
Usar esta nomenclatura para índices que no dependen de un constraint.


Nomenclatura de Vistas

Prefijo
vw_NombreVista
Ejemplo
vw_orden_compra
Comentarios
Ninguno


Nomenclatura de Reglas (RULES)

Prefijo
ru_NombreRule
Ejemplo
ru_codigo_cliente
Comentarios
Usar reglas sólo para datatypes definidos por el usuario. En caso de columnas usar CHECKS.


Nomenclatura de Defaults 

Prefijo
df_Nombre_Default
Ejemplo
df_fecha_sistema
Comentarios
Usar DEFAULT (Procedural) solo para datatypes definidos por el usuario. En caso de columnas usar DEFAULT (Declarativo).


Nomenclatura de Stored Procedures

Prefijo
Accion_NombredelStoredProcedure_Tipo

Donde: 
Acción: 
i	:	Insert
u	:	Update
d	:	Delete
s	:	Select

Nombre del Stored Procedure:
Debe corresponder al nombre de la tabla sin incluir el prefijo del módulo. Únicamente en el caso de que la función realice una acción de update o delete, se agregará también el nombre de la columna afectada.

Tipo
En el caso de que la función devuelva datos a través de parámetros de salida, se añadirá al final el sufijo “_out”.
NombreParametro

Donde:
Parámetros
Los parámetros deben escribirse en snake_case.
Los nombres de los parámetros deben corresponderse con los campos de la tabla.
Ejemplo
i_personal
u_producto
d_orden_compra
u_personal_apellido
u_personal_estado
Comentarios
Las funciones en PostgreSQL no requieren SET NOCOUNT ON.



Nomenclatura de Schemas

Prefijo
NombreSchema


Nombre debe ser descriptivo y representar el módulo, área o contexto, con máximo de 3 letras.
Ejemplo
imp			Impuesto Predial
caj			Caja
lic			Licencias de Funcionamiento
alc 			Impuesto alcabala
saa			Agua y alcantarillado
arb                           Arbitrios Municipales
Comentarios
Cada schema debe documentarse con su responsabilidad funcional.


Nomenclatura de Triggers

Prefijo
TR_Nombre_Tipo de trigger

Donde	:
Tipo de trigger:
i	:	Insert
u	:	Update
d	:	Delete
Ejemplo
tr_usuario_potencial_i	Trigger para inserción
tr_nandina_iu		Trigger para inserción y Actualización
Comentarios
Si el trigger hace más de una cosa, se pondrá IU, ID, UD, o las respectivas combinaciones.


Nomenclatura de Datatypes definidos por el usuario

Prefijo
dt_NombreTipoDato
Ejemplo
dt_fecha_nacimiento
dt_ruc
Comentarios
N/A


Nomenclatura de Funciones 

Prefijo
fn_NombreFuncion
Ejemplo
fn_telefono_persona
Comentarios
N/A



Reglas de Programación PostgreSQL

Stored Procedures
Los nombres de las funciones no deben incluir prefijos reservados del sistema, ya que en PostgreSQL existen funciones internas con nombres específicos y se puede generar confusión o errores de compatibilidad.
En PostgreSQL se recomienda que las funciones se definan siempre con RETURNS VOID cuando no devuelvan datos, y con RETURNS TABLE cuando devuelvan registros, asegurando así un uso más claro y eficiente.
Todos los sistemas desarrollados deberán invocar funciones para operaciones de inserción, actualización, consulta y eliminación, evitando colocar sentencias SQL directas en el cliente. Esto garantiza mejor seguridad, reutilización y mantenibilidad del código.
El desarrollador no debe forzar el uso de un índice dentro de una función, ya que el planificador de PostgreSQL (query planner) determina automáticamente el plan de ejecución más eficiente.
En funciones que únicamente consultan información, se debe evitar construir lógica condicional poco óptima que afecte el plan de ejecución.

Reglas Generales
Evitar el uso de cursores en PostgreSQL, ya que consumen más recursos y en la mayoría de casos se pueden reemplazar por consultas con RETURN QUERY.
Usar vistas para simplificar queries complejos y centralizar la lógica de consultas.
Los permisos deben otorgarse sobre tablas o vistas completas, nunca sobre columnas individuales.
Optimizar siempre el uso de los tipos de datos, eligiendo el más adecuado (por ejemplo, INTEGER en lugar de BIGINT si los valores son pequeños, TEXT solo cuando sea necesario).


SEGURIDAD DE ACCESOS

APLICACIONES VISUALES – POSTGRESQL
Los sistemas de información desarrollados en PostgreSQL utilizan una base de datos dedicada para validar los accesos de los usuarios de las aplicaciones.
Las contraseñas se almacenarán en forma encriptada, usando funciones como pgcrypto o gestionadas a nivel de aplicación.
Las contraseñas tendrán un tiempo de vigencia de 3 meses, el sistema deberá forzar al usuario a cambiarla al momento de expirar.
No se permitirán contraseñas idénticas al login del usuario, y tendrán una longitud mínima de 8 caracteres alfanuméricos.
Se almacenará un historial con las últimas 3 contraseñas utilizadas por cada usuario, de forma que no se puedan reutilizar.
Las pantallas de identificación de usuario no permitirán modificar el ID del usuario, solamente se ingresará la contraseña. El ID utilizado será el proporcionado por la sesión de red o por el sistema de autenticación externo.
Los sistemas de información deberán gestionarse mediante perfiles de usuario y roles de PostgreSQL, asignando permisos de lectura, escritura, borrado y ejecución según las necesidades.
En caso de intentos fallidos de acceso, la aplicación deberá bloquear el ingreso al tercer intento consecutivo fallido, registrando el evento en una tabla de auditoría.

CONTROL DE DATOS EN LAS APLICACIONES

Los controles de aplicación se refieren a las transacciones y a los datos relativos a cada sistema basado en una computadora, y por lo tanto, son específicos para cada aplicación. Los objetivos de los controles de aplicación, que pueden ser manuales o programados, deben asegurar la integridad y la exactitud de los registros y la validez de las entradas realizadas, tanto sean resultantes del procesamiento manual como programado. Los controles de la aplicación son controles sobre las funciones de entrada (input), procesamiento y salida (output) de datos. Incluyen métodos para asegurar:

Que sólo se introducen y actualizan datos completos, exactos y válidos en un sistema de información.
Que el procesamiento realice la tarea correcta
Que los resultados del procesamiento satisfagan las expectativas
Que se mantengan los datos

Procesamiento, Validación y Edición

Validación y edición de datos
En los casos de que se posean documentos electrónicos que deban ser revisados por otra área, debe manejarse un “Estado” que bloqueará las modificaciones del documento ya revisado. La revisión/aprobación/ validación se manejará en línea a través del mismo sistema o de otro que posea tales opciones, empleando un usuario y contraseña para efectuarla. Asimismo, deben guardarse los datos del usuario que autorizó el documento, la fecha y la hora.

Procedimientos de control de procesamiento
Los controles de procesamiento aseguran la integridad y la exactitud de los datos acumulados. Ellos aseguran que los datos contenidos en el archivo/base de datos sigan siendo completos y exactos hasta que sean cambiados como resultado de un procesamiento o de rutinas de modificación autorizadas.

Las técnicas de control de procesamiento que pueden ser usadas para tratar el aspecto de integridad y exactitud de los datos acumulados son:

Reportes de verificación
Totales de Proceso a Proceso 
Verificación de Razonabilidad de los Valores Calculados 
Verificaciones de Límite sobre los Valores Calculados 
Reconciliación de los Totales de los Archivos con los documentos fuente, sobre todo en aspectos delicados como el Ingreso y la Salida de Mercancías.

Controles de Salida
Los controles de salida proveen garantía de que los datos entregados a los usuarios serán presentados, formateados y entregados en una forma consistente y segura.

Dentro de estos controles, se puede considerar:

Distribución de Reportes
Los reportes de las aplicaciones deberán ser emitidos por usuarios que tengan autorización de acceso a ellos. Esta autorización la dará el dueño de la aplicación.

Los reportes confidenciales deberán ser etiquetados en el momento de su emisión.

Manejo de Errores
El procesamiento de los datos introducidos al sistema requiere que existan controles que permitan verificar que los datos son aceptados en el sistema correctamente, y que los errores que se presentan en su ingreso son reconocidos y corregidos.

Los errores que se presenten deberán indicar al usuario la naturaleza del error, además de almacenar el número de error y descripción del mismo y programa que lo originó.

No se debe aceptar el ingreso de datos que hayan generado un error.


DOCUMENTACIÓN DE LOS SISTEMAS

La documentación de los módulos de sistemas se mantendrá en línea, responsable de cada líder de grupo. 

Cada sistema deberá generar:

Manual del usuario: Describe la funcionalidad del sistema a través de casos prácticos y de una FAQ. Deberá contener como mínimo:
Objetivos
Responsabilidades
Límites
Descripción de casos
FAQ

Manual del sistema: Describe la estructura y funcionamiento del sistema utilizando diagramas. Deberá contener como mínimo:
Objetivos
Responsabilidades
Límites
Descripción del proceso que soporta
Documentación de requerimientos
Documentación de análisis
Documentación de arquitectura
Documentación de diseño

Asimismo, para la instalación de los sistemas, los desarrolladores crearán un archivo llamado README.txt almacenado junto con los instaladores.

Diccionario de Datos
El diccionario de datos se almacenará en una herramienta de modelado compatible con PostgreSQL, generando reportes en formato HTML.

ESTANDARIZACIÓN DE LENGUAJE DE PROGRAMACIÓN

Funciones

Nombre
Prefijo_NombreFuncion
Ejemplo
------------------------------------------------------------------
--DESCRIPCION: Funcion de retorna el pago empleado
--Usado por: SYTE - Módulo de Tesoreria
--SN ### - yyyy Proyecto ### - Módulo de Administración, Autor: NMOLLO dd/mm/yyyy
int fn_obtner_pago(){
}
Comentarios
N/A


Procedimientos

Nombre
Prefijo_NombreProcedimiento
Ejemplo
------------------------------------------------------------------
--DESCRIPCION: Funcion de Calcula del impuesto
--Usado por: SYTE - Módulo de Tesoreria
--SN ### - yyyy Proyecto ### - Módulo de Administración, Autor: NMOLLO dd/mm/yyyy
proc_obtner_calculopago(){
}
Comentarios
N/A


