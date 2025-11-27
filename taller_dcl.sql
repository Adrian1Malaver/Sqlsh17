/* 
-- ######################################################################
-- # FASE 0: PREPARACIÓN Y LIMPIEZA
-- ######################################################################

-- Eliminación de tablas y roles previos para una ejecución limpia
DROP TABLE IF EXISTS Telefono, Preferencia, Visita, Comercializa, TelefonoF, Paciente, Medicina, Farmacia CASCADE;
DROP ROLE IF EXISTS ana, bruno, carla, diego, db_admin, gestor_farmacia, farmaceutico, medico, paciente, escritura_completa, lectura_completa;


-- ######################################################################
-- # FASE 1: DDL (CREACIÓN DE TABLAS)
-- ######################################################################

-- Tablas Maestras
CREATE TABLE Medicina (
    idMedicina NUMERIC(5) PRIMARY KEY,
    nombreGenerico VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Farmacia (
    idFarmacia NUMERIC(5) PRIMARY KEY,
    nombreF VARCHAR(100) UNIQUE NOT NULL,
    calle VARCHAR(50),
    carrera VARCHAR(50),
    numero VARCHAR(20)
);

CREATE TABLE Paciente (
    cedula NUMERIC(10) PRIMARY KEY,
    primerN VARCHAR(50) NOT NULL,
    segundon VARCHAR(50), -- Asumido NULLable, no existe en CSV
    primerA VARCHAR(50) NOT NULL,
    segundoa VARCHAR(50), -- Asumido NULLable, no existe en CSV
    fechaNac DATE NOT NULL,
    direccion VARCHAR(100) -- Asumido NULLable, no existe en CSV
);


-- Tablas Relacionales (Con FOREIGN KEYs)
CREATE TABLE Preferencia (
    cedula NUMERIC(10) REFERENCES Paciente(cedula),
    idMedicina NUMERIC(5) REFERENCES Medicina(idMedicina),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (cedula, idMedicina)
);

CREATE TABLE Telefono (
    cedula NUMERIC(10) REFERENCES Paciente(cedula),
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (cedula, telefono)
);

CREATE TABLE TelefonoF (
    idFarmacia NUMERIC(5) REFERENCES Farmacia(idFarmacia),
    telefonoF VARCHAR(20) NOT NULL,
    PRIMARY KEY (idFarmacia, telefonoF)
);

CREATE TABLE Comercializa (
    idFarmacia NUMERIC(5) REFERENCES Farmacia(idFarmacia),
    idMedicina NUMERIC(5) REFERENCES Medicina(idMedicina),
    dosificacion INTEGER,
    cantTabletas INTEGER NOT NULL,
    precioVenta NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (idFarmacia, idMedicina)
);

CREATE TABLE Visita (
    id_visita SERIAL PRIMARY KEY,
    cedula NUMERIC(10) REFERENCES Paciente(cedula) NOT NULL,
    idFarmacia NUMERIC(5) REFERENCES Farmacia(idFarmacia) NOT NULL,
    fecha TIMESTAMP NOT NULL,
    diagnostico TEXT DEFAULT 'Sin Diagnóstico' -- Columna adicional
);


-- ######################################################################
-- # FASE 2: DML (INSERCIÓN DE DATOS DE LOS 8 CSV)
-- ######################################################################

-- Medicina.csv
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (10, 'Paracetamol');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (20, 'Ibuprofeno');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (30, 'Amoxicilina');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (40, 'Aspirina');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (50, 'Cloranfenicol');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (60, 'Metformina');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (70, 'Vitamina C');
INSERT INTO Medicina (idMedicina, nombreGenerico) VALUES (80, 'Azitromicina');

-- Farmacia.csv
INSERT INTO Farmacia (idFarmacia, nombreF, calle, carrera, numero) VALUES (1, 'Farmacia Central', 'Calle 1', 'Carrera 1', '1-1');
INSERT INTO Farmacia (idFarmacia, nombreF, calle, carrera, numero) VALUES (2, 'Farmacia Norte', 'Calle 2', 'Carrera 2', '2-2');
INSERT INTO Farmacia (idFarmacia, nombreF, calle, carrera, numero) VALUES (3, 'Farmacia Sur', 'Calle 3', 'Carrera 3', '3-3');
INSERT INTO Farmacia (idFarmacia, nombreF, calle, carrera, numero) VALUES (4, 'Farmacia Este', 'Calle 4', 'Carrera 4', '4-4');

-- Paciente.csv (Solo usa las columnas del CSV)
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (12345, 'Juan', 'Perez', '1990-05-10');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (23456, 'Pedro', 'Gomez', '2010-07-15');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (34567, 'Maria', 'Lopez', '1985-02-20');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (45678, 'Ana', 'Torres', '1993-09-01');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (56789, 'Carlos', 'Ruiz', '1980-12-12');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (67890, 'Lucia', 'Silva', '1988-11-11');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (67891, 'Laura', 'Diaz', '1999-04-05');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (78901, 'Diego', 'Large', '1992-01-30');
INSERT INTO Paciente (cedula, primerN, primerA, fechaNac) VALUES (65432, 'Sara', 'Simple', '1995-03-03');

-- Comercializa.csv
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (1, 10, 500, 10, 10000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (1, 40, 300, 20, 4000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (1, 60, 850, 12, 10000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (1, 70, 1200, 30, 10000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (1, 80, 1500, 10, 8000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (2, 10, 750, 10, 8000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (2, 20, 600, 10, 12000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (3, 20, 600, 10, 12000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (3, 30, 1000, 20, 18000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (4, 20, 600, 10, 12000.00);
INSERT INTO Comercializa (idFarmacia, idMedicina, dosificacion, cantTabletas, precioVenta) VALUES (4, 60, 850, 12, 11000.00);

-- Preferencia.csv
INSERT INTO Preferencia (cedula, idMedicina) VALUES (12345, 10);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (12345, 30);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (12345, 50);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (23456, 30);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (45678, 20);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (56789, 10);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (56789, 20);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (56789, 30);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (56789, 40);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (56789, 70);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (67891, 40);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (78901, 70);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (78901, 80);
INSERT INTO Preferencia (cedula, idMedicina) VALUES (65432, 40);

-- Telefono.csv
INSERT INTO Telefono (cedula, telefono) VALUES (12345, '3001111');
INSERT INTO Telefono (cedula, telefono) VALUES (23456, '3002222');
INSERT INTO Telefono (cedula, telefono) VALUES (34567, '3003333');
INSERT INTO Telefono (cedula, telefono) VALUES (45678, '3004444');
INSERT INTO Telefono (cedula, telefono) VALUES (56789, '3005555');
INSERT INTO Telefono (cedula, telefono) VALUES (67890, '3006666');
INSERT INTO Telefono (cedula, telefono) VALUES (67891, '3007777');
INSERT INTO Telefono (cedula, telefono) VALUES (78901, '3008888');
INSERT INTO Telefono (cedula, telefono) VALUES (65432, '3009999');

-- TelefonoF.csv
INSERT INTO TelefonoF (idFarmacia, telefonoF) VALUES (1, '1111111');
INSERT INTO TelefonoF (idFarmacia, telefonoF) VALUES (1, '1112222');
INSERT INTO TelefonoF (idFarmacia, telefonoF) VALUES (2, '2223333');
INSERT INTO TelefonoF (idFarmacia, telefonoF) VALUES (3, '3334444');
INSERT INTO TelefonoF (idFarmacia, telefonoF) VALUES (4, '4445555');

-- Visita.csv
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (12345, 1, '2025-05-01 10:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (12345, 1, '2025-05-02 10:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (12345, 1, '2025-05-02 15:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (12345, 2, '2025-05-10 09:30:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (23456, 1, '2025-05-15 11:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (45678, 2, '2025-05-12 13:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (56789, 3, '2025-05-18 14:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (56789, 1, '2025-05-20 16:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (78901, 1, '2025-05-20 10:30:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (65432, 1, '2025-05-21 09:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (65432, 1, '2025-05-21 12:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (65432, 1, '2025-05-22 11:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (65432, 1, '2025-05-23 10:00:00');
INSERT INTO Visita (cedula, idFarmacia, fecha) VALUES (65432, 1, '2025-05-24 10:00:00');


-- ######################################################################
-- # FASE 3: DCL (IMPLEMENTACIÓN DEL TALLER)
-- ######################################################################

-- 2.1 Creación de los roles "grupos" (según Taller DCL)
CREATE ROLE gestor_farmacia;
CREATE ROLE farmaceutico;
CREATE ROLE medico;
CREATE ROLE paciente;

CREATE ROLE lectura_completa;
CREATE ROLE escritura_completa;

-- Creación del rol de ADMINISTRADOR (con capacidad de LOGIN y CREAR OBJETOS)
CREATE ROLE db_admin LOGIN PASSWORD 'adminHospital';
ALTER ROLE db_admin CREATEDB CREATEROLE;


-- 2.2 Construir la jerarquía de privilegios
GRANT lectura_completa TO gestor_farmacia, farmaceutico, medico;
GRANT escritura_completa TO gestor_farmacia, farmaceutico;
GRANT lectura_completa, escritura_completa TO db_admin;


-- 3 Asignación de usuarios (Roles con LOGIN)
-- Usuarios de prueba con sus contraseñas
CREATE ROLE ana LOGIN PASSWORD 'pwd_ana';      -- Gestor de farmacia
CREATE ROLE bruno LOGIN PASSWORD 'pwd_bruno';  -- Farmacéutico
CREATE ROLE carla LOGIN PASSWORD 'pwd_carla';  -- Médico
CREATE ROLE diego LOGIN PASSWORD 'pwd_diego';  -- Paciente

GRANT gestor_farmacia TO ana;
GRANT farmaceutico TO bruno;
GRANT medico TO carla;
GRANT paciente TO diego;


-- 4 Privilegios sobre el ESQUEMA
GRANT USAGE ON SCHEMA public TO lectura_completa;
GRANT CREATE ON SCHEMA public TO gestor_farmacia, db_admin;


-- 5 Privilegios sobre TABLAS
GRANT SELECT ON ALL TABLES IN SCHEMA public TO lectura_completa;
-- Aplicar SELECT a tablas creadas en el futuro (Buenas Prácticas)
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO lectura_completa;

GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO escritura_completa;

-- Gestor de farmacia: DML completo sobre Farmacia y Comercializa
GRANT INSERT, UPDATE, DELETE ON Farmacia, Comercializa TO gestor_farmacia;
-- Farmacéutico: INSERT/UPDATE en Visita, UPDATE de precios/cantidades en Comercializa
GRANT INSERT, UPDATE ON Visita TO farmaceutico;
GRANT UPDATE (precioVenta, cantTabletas) ON Comercializa TO farmaceutico;
-- Médico: INSERT en Preferencia
GRANT INSERT ON Preferencia TO medico;


-- 6 Privilegios sobre COLUMNAS
-- Médico no puede ver la dirección ni el teléfono del paciente
REVOKE SELECT ON TABLE Paciente FROM medico;
GRANT SELECT (cedula, primerN, segundon, primerA, segundoa)
    ON Paciente TO medico;

-- Gestor_farmacia puede actualizar precios/cantidades (ya tiene DELETE/INSERT/UPDATE total por el rol escritura_completa, pero se deja explícito según la consigna)
GRANT UPDATE (precioVenta, cantTabletas) ON Comercializa TO gestor_farmacia;


-- 7 Seguridad a nivel de FILA (RLS) - Paciente solo ve sus visitas
ALTER TABLE Visita ENABLE ROW LEVEL SECURITY;

-- Esta política requiere que el usuario defina su cédula antes de la consulta
CREATE POLICY visita_self
    ON Visita
    FOR SELECT
    USING (cedula = current_setting('app.current user cedula')::numeric);


-- 8 Verificación de privilegios (Consulta para usar en el PDF)
-- Muestra qué roles tienen qué permisos en la tabla Comercializa
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name = 'comercializa'
  AND grantee IN ('gestor_farmacia', 'farmaceutico', 'escritura_completa', 'db_admin');


-- 9 Revocación y buenas prácticas
-- Revocación solicitada como prueba final
REVOKE UPDATE ON Comercializa FROM farmaceutico;

-- Nota: Para eliminar todos los roles y tablas al final, use los siguientes comandos
/*
DROP ROLE IF EXISTS ana, bruno, carla, diego, db_admin;
DROP ROLE IF EXISTS gestor_farmacia, farmaceutico, medico, paciente;
DROP ROLE IF EXISTS escritura_completa, lectura_completa;
*/
-- Este comando permite la inserción de datos para usuarios que tienen el permiso INSERT
CREATE POLICY visita_allow_insert
    ON visita
    FOR INSERT
    WITH CHECK (true);
-- Revocamos el UPDATE en 'paciente' al rol de apoyo 'escritura_completa'
REVOKE UPDATE ON paciente FROM escritura_completa;
-- Revocamos el UPDATE en 'paciente' directamente a 'farmaceutico' (Bruno)
REVOKE UPDATE ON paciente FROM farmaceutico;

UPDATE paciente
SET primerA = 'Apellido Bloqueado'
WHERE cedula = 12345;

-- Ejecutar como usuario: postgres
-- 1. Quitamos SELECT en 'paciente' al rol que lo concedía a todos
REVOKE SELECT ON paciente FROM lectura_completa;

-- Ejecutar como usuario: postgres
-- 2. Damos SELECT de nuevo a gestor_farmacia y farmaceutico (que sí deben verlo todo)
GRANT SELECT ON paciente TO gestor_farmacia;
GRANT SELECT ON paciente TO farmaceutico;
SELECT * FROM paciente LIMIT 1;
SELECT cedula, primern, primera
FROM paciente
WHERE cedula = 12345;

-- Insertar una nueva preferencia (ej. Medicina 80 para paciente 67890)
INSERT INTO preferencia (cedula, idmedicina)
VALUES (67890, 80);
-- Ejecute este comando para "loguear" a Diego en la sesión
-- Este comando ahora es sintácticamente correcto
-- 1. Eliminamos la política existente con el nombre de variable inválido
DROP POLICY visita_self ON visita;
-- 2. Creamos la nueva política RLS con el nombre de variable corregido
CREATE POLICY visita_self
    ON visita
    FOR SELECT
    USING (cedula = current_setting('app.user_cedula')::numeric);
-- A. Establecer la cédula de Diego (78901)
SET app.user_cedula TO '78901';

-- Este comando da permiso de SELECT a la tabla 'visita' al rol 'paciente'
GRANT SELECT ON visita TO paciente;
DROP POLICY visita_self ON visita;
-- Esta es la solución final: RLS basado en el nombre de usuario 'diego'
CREATE POLICY visita_self
    ON visita
    FOR SELECT
    USING (cedula = (SELECT cedula FROM paciente WHERE primern = current_user LIMIT 1));
-- Este comando da permiso de SELECT en la tabla 'paciente' al rol 'paciente'
GRANT SELECT ON paciente TO paciente;
SELECT * FROM visita;
-- Damos SELECT en 'paciente' al usuario específico 'diego'
GRANT SELECT ON paciente TO diego;
DROP POLICY visita_self ON visita;
-- Esta es la solución final: RLS insensible a mayúsculas
CREATE POLICY visita_self
    ON visita
    FOR SELECT
    USING (cedula = (SELECT cedula FROM paciente WHERE LOWER(primern) = current_user LIMIT 1));
DROP POLICY visita_self ON visita;
-- Solución Definitiva: Filtro directo para el usuario 'diego'
CREATE POLICY visita_self
    ON visita
    FOR SELECT
    USING (current_user = 'diego' AND cedula = 78901);
SELECT * FROM visita;
*/