-- Solemne 1 Topic Avanzados de Base de datos

-- Integrante: Gianfranco Astorga

-- Creación del usuario en Oracle
--en consola CONNECT SYSTEM/123
CREATE USER David IDENTIFIED BY 1234;
GRANT ALL PRIVILEGES TO David;

-- Creación de las tablas

DROP TABLE Habita;
DROP TABLE Visitas;
DROP TABLE Tripulaciones;
DROP TABLE Dependencias;
DROP TABLE Razas;
DROP TABLE Planetas;
DROP TABLE Camaras;
DROP TABLE Servicios;

-- Tabla Servicios
CREATE TABLE Servicios (
    Clave INT NOT NULL CONSTRAINT pk_clave PRIMARY KEY, -- Clave principal
    Nombre VARCHAR(50) NOT NULL CONSTRAINT chk_nombre_servicio CHECK (Nombre <> '') -- Nombre no puede ser vacío
);

-- Tabla Cámaras
CREATE TABLE Camaras (
    Codigo_C INT NOT NULL CONSTRAINT pk_codigo_c PRIMARY KEY,  -- Clave principal
    Categoria VARCHAR(50) NOT NULL CONSTRAINT chk_categoria_cam CHECK (Categoria <> ''),  -- Categoría no puede ser vacía
    Capacidad INT NOT NULL CONSTRAINT chk_capacidad_cam CHECK (Capacidad > 0)  -- Capacidad mayor a 0
);

-- Tabla Planetas
CREATE TABLE Planetas (
    Codigo_p INT NOT NULL CONSTRAINT pk_codigo_p PRIMARY KEY,  -- Clave principal
    Nombre VARCHAR(50) NOT NULL CONSTRAINT chk_nombre_planeta CHECK (Nombre <> ''),  -- Nombre no puede ser vacío
    Galaxia VARCHAR(50) NOT NULL CONSTRAINT chk_galaxia_planeta CHECK (Galaxia <> ''),  -- Galaxia no puede ser vacía
    Coordenadas VARCHAR(50) NOT NULL CONSTRAINT chk_coordenadas_planeta CHECK (Coordenadas <> '')  -- Coordenadas no pueden ser vacías
);

-- Tabla Razas
CREATE TABLE Razas (
    Nombre_r VARCHAR(50) NOT NULL CONSTRAINT pk_nombre_r PRIMARY KEY,  -- Clave principal
    Altura INT NOT NULL CONSTRAINT chk_altura_raza CHECK (Altura > 0),  -- Altura debe ser mayor a 0
    Anchura INT NOT NULL CONSTRAINT chk_anchura_raza CHECK (Anchura > 0),  -- Anchura debe ser mayor a 0
    Peso INT NOT NULL CONSTRAINT chk_peso_raza CHECK (Peso > 0),  -- Peso debe ser mayor a 0
    Poblacion_Total INT NOT NULL CONSTRAINT chk_poblacion_raza CHECK (Poblacion_Total >= 0)  -- Población total no puede ser negativa
);

-- Tabla Dependencias
CREATE TABLE Dependencias (
    Codigo_d INT NOT NULL CONSTRAINT pk_codigo_d PRIMARY KEY,  -- Clave principal
    Nombre VARCHAR(50) NOT NULL CONSTRAINT chk_nombre_dependencia CHECK (Nombre <> ''),  -- Nombre no puede ser vacío
    Funcion VARCHAR(50) NOT NULL CONSTRAINT chk_funcion_dependencia CHECK (Funcion <> ''),  -- Función no puede ser vacía
    Localizacion VARCHAR(50) NOT NULL CONSTRAINT chk_localizacion_dependencia CHECK (Localizacion <> ''),  -- Localización no puede ser vacía
    Clave_Servicio INT NOT NULL,  -- Clave foránea a Servicios
    FOREIGN KEY (Clave_Servicio) REFERENCES Servicios(Clave) 
    ON DELETE CASCADE  -- Eliminación en cascada
);

-- Tabla Tripulaciones
CREATE TABLE Tripulaciones (
    Codigo_t INT NOT NULL CONSTRAINT pk_codigo_t PRIMARY KEY,  -- Clave principal
    Nombre VARCHAR(50) NOT NULL CONSTRAINT chk_nombre_tripulacion CHECK (Nombre <> ''),  -- Nombre no puede ser vacío
    Categoria VARCHAR(50) NOT NULL CONSTRAINT chk_categoria_tripulacion CHECK (Categoria <> ''),  -- Categoría no puede ser vacía
    Antiguedad INT NOT NULL CONSTRAINT chk_antiguedad_tripulacion CHECK (Antiguedad >= 0),  -- Antigüedad no puede ser negativa
    Procedencia VARCHAR(50) NOT NULL CONSTRAINT chk_procedencia_tripulacion CHECK (Procedencia <> ''),  -- Procedencia no puede ser vacía
    Codigo_d INT NOT NULL,  -- Clave foránea a Dependencias
    Codigo_C INT NOT NULL,  -- Clave foránea a Cámaras
    FOREIGN KEY (Codigo_d) REFERENCES Dependencias(Codigo_d)
    ON DELETE CASCADE,  -- Borrado en cascada
    FOREIGN KEY (Codigo_C) REFERENCES Camaras(Codigo_C)
    ON DELETE CASCADE  -- Borrado en cascada
);

-- Tabla Visitas (relación entre Tripulaciones y Planetas)
CREATE TABLE Visitas (
    Codigo_t INT NOT NULL,  -- Clave foránea a Tripulaciones
    Codigo_p INT NOT NULL,  -- Clave foránea a Planetas
    Fecha DATE NOT NULL,  -- Fecha de la visita
    Tiempo INT NOT NULL CONSTRAINT chk_tiempo_visita CHECK (Tiempo >= 0),  -- Tiempo no puede ser negativo
    PRIMARY KEY (Codigo_t, Codigo_p, Fecha),  -- Clave primaria compuesta
    FOREIGN KEY (Codigo_t) REFERENCES Tripulaciones(Codigo_t) 
    ON DELETE CASCADE,  -- Borrado en cascada
    FOREIGN KEY (Codigo_p) REFERENCES Planetas(Codigo_p) 
    ON DELETE CASCADE  -- Borrado en cascada
);

-- Tabla Habita (relación entre Razas y Planetas)
CREATE TABLE Habita (
    Codigo_p INT NOT NULL,  -- Clave foránea a Planetas
    Nombre_r VARCHAR(50) NOT NULL,  -- Clave foránea a Razas
    Poblacion_Parcial INT NOT NULL CONSTRAINT chk_poblacion_parcial CHECK (Poblacion_Parcial >= 0),  -- Población parcial no puede ser negativa
    PRIMARY KEY (Codigo_p, Nombre_r),  -- Clave primaria compuesta
    FOREIGN KEY (Codigo_p) REFERENCES Planetas(Codigo_p) 
    ON DELETE CASCADE,  -- Borrado en cascada
    FOREIGN KEY (Nombre_r) REFERENCES Razas(Nombre_r) 
    ON DELETE CASCADE  -- Borrado en cascada
);

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Inserción de datos

-- Tabla Servicios

INSERT INTO Servicios (Clave, Nombre) VALUES (1, 'Comunicaciones');
INSERT INTO Servicios (Clave, Nombre) VALUES (2, 'Seguridad');
INSERT INTO Servicios (Clave, Nombre) VALUES (3, 'Navegación');
INSERT INTO Servicios (Clave, Nombre) VALUES (4, 'Mantenimiento');
INSERT INTO Servicios (Clave, Nombre) VALUES (5, 'Investigación');
INSERT INTO Servicios (Clave, Nombre) VALUES (6, 'Recreación');

-- Tabla Cámaras

INSERT INTO Camaras (Codigo_C, Categoria, Capacidad) VALUES (1, 'Habitación', 2);
INSERT INTO Camaras (Codigo_C, Categoria, Capacidad) VALUES (2, 'Laboratorio', 5);
INSERT INTO Camaras (Codigo_C, Categoria, Capacidad) VALUES (3, 'Cocina', 3);
INSERT INTO Camaras (Codigo_C, Categoria, Capacidad) VALUES (4, 'Baño', 1);
INSERT INTO Camaras (Codigo_C, Categoria, Capacidad) VALUES (5, 'Sala de estar', 4);
INSERT INTO Camaras (Codigo_C, Categoria, Capacidad) VALUES (6, 'Sala de control', 3);

-- Tabla Planetas

INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (1, 'Tatooine', 'Vía Láctea', '12° 34'' 56" N 123° 45'' 67" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (2, 'Alderaan', 'Vía Láctea', '23° 45'' 67" N 134° 56'' 78" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (3, 'Endor', 'Vía Láctea', '34° 56'' 78" N 145° 67'' 89" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (4, 'Hoth', 'Vía Láctea', '45° 67'' 89" N 156° 78'' 90" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (5, 'Naboo', 'Vía Láctea', '56° 78'' 90" N 167° 89'' 01" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (6, 'Coruscant', 'Vía Láctea', '67° 89'' 01" N 178° 90'' 12" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (7, 'Kamino', 'Vía Láctea', '78° 90'' 12" N 189° 01'' 23" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (8, 'Geonosis', 'Vía Láctea', '89° 01'' 23" N 190° 12'' 34" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (9, 'Yavin IV', 'Vía Láctea', '90° 12'' 34" N 01° 23'' 45" O');
INSERT INTO Planetas (Codigo_p, Nombre, Galaxia, Coordenadas) VALUES (10, 'Jakku', 'Vía Láctea', '01° 23'' 45" N 12° 34'' 56" O');

-- Tabla Razas

INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Humano', 170, 50, 70, 8000000000);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Wookiee', 210, 150, 120, 1000);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Ewok', 100, 50, 20, 500);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Jawa', 120, 60, 30, 700);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Twi''lek', 170, 70, 50, 800);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Rodiano', 180, 80, 60, 900);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Trandoshano', 190, 90, 70, 1100);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Mon Calamari', 200, 100, 80, 1200);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Sullustano', 220, 110, 90, 1300);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Gungan', 230, 120, 100, 1400);
INSERT INTO Razas (Nombre_r, Altura, Anchura, Peso, Poblacion_Total) VALUES ('Geonosiano', 240, 130, 110, 1500);

-- Tabla Dependencias

INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (1, 'Puente de mando', 'Control de la nave', 'Cubierta 1', 3);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (2, 'Sala de máquinas', 'Mantenimiento de la nave', 'Cubierta 2', 4);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (3, 'Sala de comunicaciones', 'Comunicación con otros planetas', 'Cubierta 3', 1);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (4, 'Sala de recreación', 'Recreación de la tripulación', 'Cubierta 4', 6);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (5, 'Sala de seguridad', 'Seguridad de la nave', 'Cubierta 5', 2);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (6, 'Sala de investigación', 'Investigación de nuevos planetas', 'Cubierta 6', 5);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (7, 'Sala de descanso', 'Descanso de la tripulación', 'Cubierta 7', 6);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (8, 'Sala de control', 'Control de la nave', 'Cubierta 8', 3);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (9, 'Sala de mantenimiento', 'Mantenimiento de la nave', 'Cubierta 9', 4);
INSERT INTO Dependencias (Codigo_d, Nombre, Funcion, Localizacion, Clave_Servicio) VALUES (10, 'Sala de navegación', 'Navegación de la nave', 'Cubierta 10', 3);

-- Tabla Tripulaciones

INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (1, 'Luke Skywalker', 'Piloto', 5, 'Tatooine', 1, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (2, 'Han Solo', 'Piloto', 10, 'Corellia', 1, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (3, 'Leia Organa', 'Comunicaciones', 5, 'Alderaan', 3, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (4, 'Chewbacca', 'Seguridad', 10, 'Kashyyyk', 5, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (5, 'R2-D2', 'Mantenimiento', 5, 'Naboo', 2, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (6, 'C-3PO', 'Comunicaciones', 5, 'Tatooine', 3, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (7, 'Obi-Wan Kenobi', 'Investigación', 15, 'Stewjon', 6, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (8, 'Yoda', 'Recreación', 20, 'Desconocida', 4, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (9, 'Anakin Skywalker', 'Piloto', 10, 'Tatooine', 1, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (10, 'Padmé Amidala', 'Comunicaciones', 5, 'Naboo', 3, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (11, 'Flash Gondon', 'Seguridad', 5, 'Tatooine', 5, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (12, 'Darth Vader', 'Seguridad', 10, 'Tatooine', 5, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (13, 'Boba Fett', 'Seguridad', 5, 'Kamino', 5, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (14, 'Jango Fett', 'Seguridad', 5, 'Concord Dawn', 5, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (15, 'Mace Windu', 'Piloto', 10, 'Haruun Kal', 1, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (16, 'Qui-Gon Jinn', 'Piloto', 10, 'Coruscant', 1, 1);
INSERT INTO Tripulaciones (Codigo_t, Nombre, Categoria, Antiguedad, Procedencia, Codigo_d, Codigo_C) VALUES (17, 'Ki-Adi-Mundi', 'Piloto', 10, 'Cerea', 1, 1);

-- Tabla Visitas

INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (1, 1, '2021-01-01', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (1, 2, '2021-01-01', 2);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (2, 2, '2021-01-02', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (3, 3, '2021-01-03', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (4, 4, '2021-01-04', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (5, 5, '2021-01-05', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (6, 6, '2021-01-06', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (7, 7, '2021-01-07', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (8, 8, '2021-01-08', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (9, 9, '2021-01-09', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (10, 10, '2021-01-10', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (11, 1, '2021-01-11', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (12, 2, '2021-01-12', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (13, 3, '2021-01-13', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (14, 4, '2021-01-14', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (15, 5, '2021-01-15', 5);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (16, 6, '2021-01-16', 10);
INSERT INTO Visitas (Codigo_t, Codigo_p, Fecha, Tiempo) VALUES (17, 7, '2021-01-17', 5);

-- Tabla Habita

INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (1, 'Humano', 1000000);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (2, 'Wookiee', 100);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (3, 'Ewok', 50);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (4, 'Jawa', 70);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (5, 'Twi''lek', 80);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (6, 'Rodiano', 90);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (7, 'Trandoshano', 110);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (8, 'Mon Calamari', 120);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (9, 'Sullustano', 130);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (10, 'Gungan', 140);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (1, 'Geonosiano', 150);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (2, 'Humano', 200);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (3, 'Wookiee', 200);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (4, 'Ewok', 100);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (5, 'Jawa', 140);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (6, 'Twi''lek', 160);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (7, 'Rodiano', 180);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (8, 'Trandoshano', 220);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (9, 'Mon Calamari', 240);
INSERT INTO Habita (Codigo_p, Nombre_r, Poblacion_Parcial) VALUES (10, 'Sullustano', 260);

-- Consultas

-- Consulta 1: Listar todas las tripulaciones

SELECT * FROM Tripulaciones;

-- Consulta 2: Listar todas las visitas

SELECT * FROM Visitas;

-- Consulta 3: Listar todas las razas

SELECT * FROM Razas;

-- Consulta 4: Listar todas las dependencias

SELECT * FROM Dependencias;

-- Consulta 5: Listar todas las cámaras

SELECT * FROM Camaras;

-- Consulta 6: Listar todos los servicios

SELECT * FROM Servicios;

-- Consulta 7: Listar todos los planetas

SELECT * FROM Planetas;

-- Update

-- Actualizar la categoría de la tripulación con código 1 a 'Piloto de combate'

UPDATE Tripulaciones
SET Categoria = 'Piloto de combate'
WHERE Codigo_t = 1;

-- Ejercicios

-- Ejercicio 1: Raza que habitan en los planetas visitados por Flash Gondon

SELECT H.Nombre_r
FROM Habita H, Visitas V, Tripulaciones T
WHERE H.Codigo_p = V.Codigo_p
AND V.Codigo_t = T.Codigo_t
AND T.Nombre = 'Flash Gondon';

-- Ejercicio 2: Cámara que han llegado a su capacidad máxima.

SELECT C.Codigo_C, C.Categoria
FROM Camaras C
WHERE C.Capacidad = (SELECT MAX(Capacidad) FROM Camaras);

-- Ejercicio 3: Nombre de los tripulantes de alguna dependencia de Sala de seguridad.

SELECT T.Nombre
FROM Tripulaciones T, Dependencias D
WHERE T.Codigo_d = D.Codigo_d
AND D.Nombre = 'Sala de seguridad';

-- Ejercicio 4: Genera una consulta que calcule Max, Min, AVG entre otros.

SELECT MAX(Poblacion_Total) AS Max_Poblacion, MIN(Poblacion_Total) AS Min_Poblacion, AVG(Poblacion_Total) AS Avg_Poblacion
FROM Razas;

-- Ejercicio 5: Genere vistas de una misma consulta con select anidado y otro con join.

-- Vista con select anidado

CREATE VIEW Vista_Select_A AS
SELECT T.Nombre, T.Categoria, T.Antiguedad, T.Procedencia, 
    (SELECT D.Nombre FROM Dependencias D WHERE D.Codigo_d = T.Codigo_d) AS Dependencia,
    (SELECT C.Categoria FROM Camaras C WHERE C.Codigo_C = T.Codigo_C) AS Camara
FROM Tripulaciones T;

-- Vista con join

CREATE VIEW Vista_Join AS
SELECT T.Nombre, T.Categoria, T.Antiguedad, T.Procedencia, D.Nombre AS Dependencia, C.Categoria AS Camara
FROM Tripulaciones T
JOIN Dependencias D ON T.Codigo_d = D.Codigo_d
JOIN Camaras C ON T.Codigo_C = C.Codigo_C;

-- Pregunta 4: Seleccione y discuta claramente un trabajo presentado en clases de optimzacion de consultas realizadas de 2 formas diferentes u otra discusion que le parecio interesante.ALTER

-- Trabajo presentado en clases de optimización de consultas

-- Consulta original

SELECT T.Nombre, T.Categoria, T.Antiguedad, T.Procedencia, D.Nombre AS Dependencia, C.Categoria AS Camara
FROM Tripulaciones T, Dependencias D, Camaras C
WHERE T.Codigo_d = D.Codigo_d
AND T.Codigo_C = C.Codigo_C;

-- Consulta optimizada

SELECT T.Nombre, T.Categoria, T.Antiguedad, T.Procedencia, D.Nombre AS Dependencia, C.Categoria AS Camara
FROM Tripulaciones T
JOIN Dependencias D ON T.Codigo_d = D.Codigo_d
JOIN Camaras C ON T.Codigo_C = C.Codigo_C;

-- Discusión

-- La consulta original utiliza la notación de join implícito, que es menos clara y más propensa a errores. 
-- La consulta optimizada utiliza la notación de join explícito, que es más clara y fácil de entender. 
-- Además, la notación de join explícito es más eficiente en términos de rendimiento, ya que permite al optimizador de consultas del motor de base de datos tomar decisiones más informadas sobre cómo ejecutar la consulta. 
-- En general, es una buena práctica utilizar la notación de join explícito en lugar de la notación de join implícito para mejorar la legibilidad y el rendimiento de las consultas SQL.





