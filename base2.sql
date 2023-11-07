
rem =====================================================
rem Eliminar tablas de ejemplos en inmgles 
rem =====================================================
DROP TABLE Dept              CASCADE CONSTRAINT;
DROP TABLE Emp               CASCADE CONSTRAINT;
DROP TABLE Bonus             CASCADE CONSTRAINT;
DROP TABLE salgrade          CASCADE CONSTRAINT;
DROP TABLE Customer          CASCADE CONSTRAINT;
DROP TABLE Ord               CASCADE CONSTRAINT;
DROP TABLE Product           CASCADE CONSTRAINT;
DROP TABLE item              CASCADE CONSTRAINT;
DROP TABLE Price             CASCADE CONSTRAINT;
DROP VIEW sales;
DROP SEQUENCE Custid;
DROP SEQUENCE Ordid;
DROP SEQUENCE prodid;


rem SET TERMOUT OFF;
DROP TABLE Departamentos     CASCADE CONSTRAINT;
DROP TABLE Empleados         CASCADE CONSTRAINT;
DROP TABLE Bonificaciones    CASCADE CONSTRAINT;
DROP TABLE GradosDeSalario   CASCADE CONSTRAINT;
DROP TABLE Clientes          CASCADE CONSTRAINT;
DROP TABLE Ordenes           CASCADE CONSTRAINT;
DROP TABLE Productos         CASCADE CONSTRAINT;
DROP TABLE Precios           CASCADE CONSTRAINT;
DROP TABLE ProductosPorOrden CASCADE CONSTRAINT;
DROP VIEW  Ventas;
DROP SEQUENCE Ord_Id;
DROP SEQUENCE Cli_Id;
DROP SEQUENCE Pro_Id;

rem =====================================================
rem Crea la tabla de Departamentos 
rem =====================================================
CREATE TABLE Departamentos
(
   Dep_Id                 NUMBER(2) NOT NULL,
   Dep_Nombre             VARCHAR2(15) NOT NULL,
   Dep_Localizacion       VARCHAR2(15),
   CONSTRAINT Dep_Id_Pk   PRIMARY KEY (Dep_Id),
   CONSTRAINT Dep_Id_Uk   UNIQUE (Dep_Nombre)
);

INSERT INTO Departamentos VALUES (10, 'CONTABILIDAD', 'MEDELLIN');
INSERT INTO Departamentos VALUES (20, 'INVESTIGACION','CALI');
INSERT INTO Departamentos VALUES (30, 'VENTAS',       'BOGOTA');
INSERT INTO Departamentos VALUES (40, 'OPERACIONES',  'BUCARAMANGA');

rem =====================================================
rem Crea la tabla de Empleados
rem =====================================================
CREATE TABLE Empleados
(
   Emp_Id                      NUMBER(4) NOT NULL,
   Emp_Nombre                  VARCHAR2(10) NOT NULL,
   Emp_Cargo                   VARCHAR2(10) NOT NULL,
   Emp_Jefe                    NUMBER(4) CONSTRAINT Emp_Jefe_FK REFERENCES Empleados(Emp_Id),
   Emp_FechaContrato           DATE NOT NULL,
   Emp_Salario                 NUMBER(11,2) CONSTRAINT Emp_Salario_NN NOT NULL,
   Emp_Comision                NUMBER(11,2),
   Dep_Id                      NUMBER(2),
   CONSTRAINT Emp_Fk_Dep       FOREIGN KEY (Dep_Id) REFERENCES Departamentos(Dep_Id),
   CONSTRAINT Emp_Id_PK        PRIMARY KEY (Emp_Id),
   CONSTRAINT Emp_Salario_Min  CHECK (Emp_Salario > 0) 
);

INSERT INTO Empleados
VALUES (1000, 'LOPEZ',    'PRESIDENTE', NULL, TO_DATE('7-AGO-2001','DD-MON-YYYY'),  7000000,    NULL, 10);
INSERT INTO Empleados
VALUES (1100, 'BENAVIDEZ','GERENTE',    1000, TO_DATE('10-JUN-2001','DD-MON-YYYY'), 2900000,    NULL, 30);
INSERT INTO Empleados
VALUES (1200, 'CORDOBA',  'GERENTE',    1000, TO_DATE('19-JUN-2001','DD-MON-YYYY'), 2700000,    NULL, 10);
INSERT INTO Empleados
VALUES (1300, 'JIMENEZ',  'GERENTE',    1000, TO_DATE('12-JUL-2001','DD-MON-YYYY'), 2775000,    NULL, 20);
INSERT INTO Empleados
VALUES (2100, 'MARTINEZ', 'VENDEDOR',   1100, TO_DATE('8-OCT-2001','DD-MON-YYYY'),  1200000, 1100000, 30);
INSERT INTO Empleados
VALUES (2200, 'ARTEAGA',  'VENDEDOR',   1100, TO_DATE('10-FEB-2001','DD-MON-YYYY'), 1600000,  700000, 30);
INSERT INTO Empleados
VALUES (2300, 'TOLEDO',   'VENDEDOR',   1100, TO_DATE('15-NOV-2001','DD-MON-YYYY'), 1550000,       0, 30);
INSERT INTO Empleados
VALUES (2400, 'JARAMILLO','OFICINISTA', 1100, TO_DATE('13-ENE-2001','DD-MON-YYYY'),  900000,    NULL, 30);
INSERT INTO Empleados
VALUES (2500, 'ZAMBRANO', 'VENDEDOR',   1100, TO_DATE('22-FEB-2001','DD-MON-YYYY'), 1250000,  600000, 30);
INSERT INTO Empleados
VALUES (3100, 'MARTINEZ', 'OFICINISTA', 1200, TO_DATE('3-MAR-2002','DD-MON-YYYY'),  1400000,    NULL, 10);
INSERT INTO Empleados
VALUES (4100, 'FERNANDEZ','ANALISTA',   1300, TO_DATE('5-DIC-2001','DD-MON-YYYY'),  3050000,    NULL, 20);
INSERT INTO Empleados
VALUES (4200, 'SANCHEZ',  'ANALISTA',   1300, TO_DATE('4-OCT-2002','DD-MON-YYYY'),  3005000,    NULL, 20);
INSERT INTO Empleados
VALUES (5000, 'SANDOVAL', 'OFICINISTA', 4100, TO_DATE('7-SEP-2003','DD-MON-YYYY'),   855000,    NULL, 20);
INSERT INTO Empleados
VALUES (6000, 'AGREDO',   'OFICINISTA', 4200, TO_DATE('2-ENE-2004','DD-MON-YYYY'),  1200000,    NULL, 20);

SET LINESIZE 200

rem SELECT LEVEL, RPAD('-', (LEVEL-1)*2, '-') || Emp_Nombre Nivel, Emp_Id, Emp_Cargo, Emp_Jefe, 
rem        Emp_FechaContrato, Emp_Salario, Emp_Comision, Dep_Id
rem FROM EMPLEADOS
rem START WITH EMP_jefe IS NULL
rem CONNECT BY PRIOR EMP_ID = EMP_Jefe;

rem =====================================================
rem Crea la tabla de Bonificaciones
rem =====================================================
CREATE TABLE Bonificaciones
(
   Emp_Nombre             VARCHAR2(10),
   Emp_Cargo              VARCHAR2(10) DEFAULT 'NINGUNO',
   Emp_Salario            NUMBER DEFAULT 100000,
   Emp_Comision           NUMBER
);

rem =====================================================
rem Crea la tabla Grados de Salarios
rem =====================================================
CREATE TABLE GradosDeSalario
(
   Gra_Id                 NUMBER NOT NULL,
   Gra_LimiteInferior     NUMBER NOT NULL,
   Gra_LimiteSuperior     NUMBER NOT NULL
);

INSERT INTO GradosDeSalario
VALUES (1,       0, 1100000);
INSERT INTO GradosDeSalario
VALUES (2, 1100001, 1500000);
INSERT INTO GradosDeSalario
VALUES (3, 1500001, 2000000);
INSERT INTO GradosDeSalario
VALUES (4, 2000001, 3000000);
INSERT INTO GradosDeSalario
VALUES (5, 3000001, 9999999);

rem =====================================================
rem Crea la tabla de Clientes
rem =====================================================
CREATE TABLE Clientes
(
   Cli_Id                 NUMBER (6) NOT NULL,
   Cli_Nombre             VARCHAR2 (45) NOT NULL,
   Cli_Direccion          VARCHAR2 (40) NOT NULL,
   Cli_Ciudad             VARCHAR2 (30) NOT NULL,
   Cli_Departamento       VARCHAR2 (2) NOT NULL,
   Cli_Telefono           VARCHAR2 (11) NOT NULL,
   Emp_Id                 NUMBER (4) NOT NULL,
   Cli_CreditoLimite      NUMBER (11,2) NOT NULL,
   Cli_Observaciones      LONG,
   CONSTRAINT Cli_Emp_FK  FOREIGN KEY (Emp_Id) REFERENCES Empleados (Emp_Id),
   CONSTRAINT Cli_Id_PK PRIMARY KEY (Cli_Id),
   CONSTRAINT Cli_Id_CK CHECK (Cli_Id > 0)
);

INSERT INTO Clientes VALUES (10,'COMPUACCESORIOS', 'PASAJE COMERCIAL LOCALES 68 Y 71', 'POPAYAN', 'CA', 
'572-8318591', 2300,  5000000, 'Gente agradable con la que se hacen negocios sin problemas.');
INSERT INTO Clientes VALUES (11,'PUNTO NET COMPUTADORES', 'CARRERA 6 # 16N - 19', 'POPAYAN', 'CA', 
'572-8235352', 2200, 10000000, 'Solo es bueno comunicarse en la mañana temprano.');
INSERT INTO Clientes VALUES (12,'PROWARE', 'CARRERA 9 # 17N - 79', 'POPAYAN', 'CA', 
'572-8231320', 2100,  7000000, 'En diciembre ofrecen grandes promociones.');
INSERT INTO Clientes VALUES (13,'SYSTEM PLUS', 'UNICENTRO LOCAL 12 Y 13', 'SANTIAGO DE CALI', 'VA', 
'572-8213375', 2200,  3000000, 'Se necesita ser muy agresivo en las ventas.');
INSERT INTO Clientes VALUES (14,'COMPU TORRES', 'CENTRO COMERCIAL CHIPI CHAPE LOCAL 15', 'SANTIAGO DE CALI', 'VA', 
'572-8318591', 2500, 10000000, 'Estan interesados en la nueva linea de productos de la compañia.');
INSERT INTO Clientes VALUES (15,'COMPU SUR', 'CALLE 5 # 3-18', 'PASTO', 'NA', 
'572-8255678', 2300,  5000000, 'Pagan a tiempo, pero es necesario sobrepasar el limite del credito.');
INSERT INTO Clientes VALUES (16,'SOLUCIONES COMPUTACIONALES', 'CALLE 8 # 4-12', 'NEIVA', 'HU', 
'573-6899071', 2200,  6000000, 'Son estrictos en el cumplimiento de los pedidos.');
INSERT INTO Clientes VALUES (17,'PENSEMOS LTDA', 'LA TRIADA LOCAL 100-103', 'BUCARAMANGA', 'SA', 
'577-6381602', 2500, 10000000, 'Buscan continuamente el lanzamiento de nuevos productos.');
INSERT INTO Clientes VALUES (18,'COMPU TECH', 'CARRERA 27 # 36-22', 'BUCARAMANGA', 'SA', 
'577-6344010', 2300,  8000000, NULL);

rem =====================================================
rem Crea la tabla de Ordenes
rem =====================================================
CREATE TABLE Ordenes
(
   Ord_Id                 NUMBER (4) NOT NULL,
   Ord_Fecha              DATE NOT NULL,
   Ord_PlanComision       VARCHAR2 (1),
   Cli_Id                 NUMBER (6) NOT NULL,
   Ord_FechaEntrega       DATE NOT NULL,
   Ord_Total              NUMBER (11,2) NOT NULL,
   CONSTRAINT Ord_Total_CK CHECK (Ord_Total >= 0),
   CONSTRAINT Ord_Cli_FK  FOREIGN KEY (Cli_Id) REFERENCES Clientes (Cli_Id),
   CONSTRAINT Ord_Id_PK   PRIMARY KEY (Ord_Id)
);

rem select 'INSERT INTO Ordenes VALUES (' || ordidn || 
rem        ', TO_DATE(''' || to_char(fecha, 'DD-MON-YYYY') || ''',''DD-MON-YYYY'')' ||
rem        ', ''' || commplan || ''', ' || cc ||
rem        ', TO_DATE(''' || to_char(entrega, 'DD-MON-YYYY') || ''',''DD-MON-YYYY'')' ||
rem        ', ' || tt || ');'  ins
rem from (select ordid-150 ordidn, orderdate + 360*19 + 3 fecha, commplan, custid - 100 cc, 
rem       shipdate + 360*19 + 3 entrega, total*1000 tt
rem       from ord)
rem order by ordidn;

INSERT INTO Ordenes VALUES 
(452, TO_DATE('28-FEB-2005','DD-MON-YYYY'),  '2', 12, TO_DATE('15-MAR-2005','DD-MON-YYYY'), 56000);
INSERT INTO Ordenes VALUES 
(453, TO_DATE('28-FEB-2005','DD-MON-YYYY'), NULL, 12, TO_DATE('28-FEB-2005','DD-MON-YYYY'), 224000);
INSERT INTO Ordenes VALUES 
(454, TO_DATE('10-MAR-2005','DD-MON-YYYY'),  '1', 16, TO_DATE('25-MAR-2005','DD-MON-YYYY'), 698000);
INSERT INTO Ordenes VALUES 
(455, TO_DATE('08-ABR-2005','DD-MON-YYYY'),  '1', 16, TO_DATE('24-ABR-2005','DD-MON-YYYY'), 8324000);
INSERT INTO Ordenes VALUES 
(461, TO_DATE('06-OCT-2005','DD-MON-YYYY'),  '2', 12, TO_DATE('06-OCT-2005','DD-MON-YYYY'), 45000);
INSERT INTO Ordenes VALUES 
(462, TO_DATE('10-OCT-2005','DD-MON-YYYY'),  '3', 14, TO_DATE('15-OCT-2005','DD-MON-YYYY'), 5860000);
INSERT INTO Ordenes VALUES 
(463, TO_DATE('27-OCT-2005','DD-MON-YYYY'), NULL, 18, TO_DATE('27-OCT-2005','DD-MON-YYYY'), 6400000);
INSERT INTO Ordenes VALUES 
(464, TO_DATE('27-OCT-2005','DD-MON-YYYY'), NULL, 12, TO_DATE('31-OCT-2005','DD-MON-YYYY'), 23940000);
INSERT INTO Ordenes VALUES 
(465, TO_DATE('27-OCT-2005','DD-MON-YYYY'), NULL, 17, TO_DATE('01-NOV-2005','DD-MON-YYYY'), 710000);
INSERT INTO Ordenes VALUES 
(466, TO_DATE('29-OCT-2005','DD-MON-YYYY'), NULL, 13, TO_DATE('05-NOV-2005','DD-MON-YYYY'), 764000);
INSERT INTO Ordenes VALUES 
(467, TO_DATE('31-OCT-2005','DD-MON-YYYY'), NULL, 15, TO_DATE('26-NOV-2005','DD-MON-YYYY'), 46370000);
INSERT INTO Ordenes VALUES 
(469, TO_DATE('17-NOV-2005','DD-MON-YYYY'), NULL, 14, TO_DATE('30-OCT-2005','DD-MON-YYYY'), 1260000);
INSERT INTO Ordenes VALUES 
(470, TO_DATE('05-DIC-2005','DD-MON-YYYY'), NULL, 10, TO_DATE('05-DIC-2005','DD-MON-YYYY'), 4450000);
INSERT INTO Ordenes VALUES 
(471, TO_DATE('08-DIC-2005','DD-MON-YYYY'),  '1', 10, TO_DATE('26-SEP-2005','DD-MON-YYYY'), 730000);

rem =====================================================
rem Crea la tabla de Productos
rem =====================================================
CREATE TABLE Productos
(
   Pro_Id                 NUMBER (8) NOT NULL,
   Pro_Nombre             VARCHAR2 (40) NOT NULL,
   CONSTRAINT Pro_Id_PK PRIMARY KEY (Pro_Id)
);

INSERT INTO Productos VALUES (30100201, 'SISTEMA OPERATIVO PROFESIONAL'); 
INSERT INTO Productos VALUES (30100202, 'SERVIDOR DE BASE DE DATOS PERSONAL'); 
INSERT INTO Productos VALUES (30100203, 'SERVIDOR DE BASE DE DATOS EMPRESARIAL'); 
INSERT INTO Productos VALUES (30100204, 'DISCO DURO 80 GB'); 
INSERT INTO Productos VALUES (30100205, 'PROCESADOR 3.2 GHZ'); 
INSERT INTO Productos VALUES (30100206, 'MOUSE INALAMBRICO'); 
INSERT INTO Productos VALUES (30100207, 'TARJETA DE SONIDO'); 
INSERT INTO Productos VALUES (30100208, 'IMPORTADO DE VIDEO "IEEE 1394"'); 
INSERT INTO Productos VALUES (30100209, 'MONITOR 17" PLANO LCD'); 
INSERT INTO Productos VALUES (30100210, 'TARJETA DE RED 10/100'); 

rem =====================================================
rem Crea la tabla de ProductosPorOrden
rem =====================================================
CREATE TABLE Precios
(
   Pro_Id                 NUMBER (8) NOT NULL,
   Pre_FechaInicio        DATE NOT NULL,
   Pre_FechaFin           DATE,
   Pre_Estandar           NUMBER (11,2) NOT NULL,
   Pre_Minimo             NUMBER (11,2) NOT NULL,
   CONSTRAINT Pre_Pro_FK FOREIGN KEY (Pro_Id) REFERENCES Productos (Pro_Id)
);

CREATE INDEX Pre_IX ON Precios(Pro_Id, Pre_FechaInicio);

rem select 'INSERT INTO Precios VALUES (' || 
rem        decode(prodid, 100860, 30100201,
rem                       100861, 30100202,
rem                       100870, 30100203,
rem                       100871, 30100204,
rem                       100890, 30100205,
rem                       101860, 30100206,
rem                       101863, 30100207,
rem                       102130, 30100208,
rem                       200376, 30100209,
rem                       200380, 30100210) ||
rem        ', TO_DATE(''' || to_char(startdate+ 360*18 + 8, 'DD-MON-YYYY') || ''',''DD-MON-YYYY''), ' ||
rem        DECODE (enddate, null, 'NULL', 'TO_DATE(''' || to_char(enddate+ 360*18 + 8, 'DD-MON-YYYY') || ''',''DD-MON-YYYY'')') ||
rem        ', ' || stdprice*1000 || ', ' || minprice*1000 || ');'
rem from price
rem order by prodid, startdate

INSERT INTO Precios VALUES 
(30100201, TO_DATE('07-OCT-2002','DD-MON-YYYY'), TO_DATE('06-OCT-2003','DD-MON-YYYY'), 30000, 24000);
INSERT INTO Precios VALUES 
(30100201, TO_DATE('07-OCT-2003','DD-MON-YYYY'), TO_DATE('05-MAR-2004','DD-MON-YYYY'), 32000, 25600);
INSERT INTO Precios VALUES 
(30100201, TO_DATE('06-MAR-2004','DD-MON-YYYY'), NULL, 35000, 28000);
INSERT INTO Precios VALUES 
(30100202, TO_DATE('07-OCT-2002','DD-MON-YYYY'), TO_DATE('06-OCT-2003','DD-MON-YYYY'), 39000, 31200);
INSERT INTO Precios VALUES 
(30100202, TO_DATE('07-OCT-2003','DD-MON-YYYY'), TO_DATE('05-MAR-2004','DD-MON-YYYY'), 42000, 33600);
INSERT INTO Precios VALUES 
(30100202, TO_DATE('06-MAR-2004','DD-MON-YYYY'), NULL, 45000, 36000);
INSERT INTO Precios VALUES 
(30100203, TO_DATE('07-OCT-2002','DD-MON-YYYY'), TO_DATE('06-SEP-2003','DD-MON-YYYY'), 2400, 1900);
INSERT INTO Precios VALUES 
(30100203, TO_DATE('07-OCT-2003','DD-MON-YYYY'), NULL, 2800, 2400);
INSERT INTO Precios VALUES 
(30100204, TO_DATE('07-OCT-2002','DD-MON-YYYY'), TO_DATE('06-SEP-2003','DD-MON-YYYY'), 4800, 3200);
INSERT INTO Precios VALUES 
(30100204, TO_DATE('07-OCT-2003','DD-MON-YYYY'), NULL, 5600, 4800);
INSERT INTO Precios VALUES 
(30100205, TO_DATE('07-MAR-2002','DD-MON-YYYY'), TO_DATE('06-MAR-2002','DD-MON-YYYY'), 54000, 40500);
INSERT INTO Precios VALUES 
(30100205, TO_DATE('07-OCT-2002','DD-MON-YYYY'), NULL, 58000, 46400);
INSERT INTO Precios VALUES 
(30100206, TO_DATE('21-NOV-2002','DD-MON-YYYY'), NULL, 24000, 18000);
INSERT INTO Precios VALUES 
(30100207, TO_DATE('21-NOV-2002','DD-MON-YYYY'), NULL, 12500, 9400);
INSERT INTO Precios VALUES 
(30100208, TO_DATE('24-MAY-2003','DD-MON-YYYY'), NULL, 3400, 2800);
INSERT INTO Precios VALUES 
(30100209, TO_DATE('20-AGO-2004','DD-MON-YYYY'), NULL, 2400, 1750);
INSERT INTO Precios VALUES 
(30100210, TO_DATE('20-AGO-2004','DD-MON-YYYY'), NULL, 4000, 3200);

rem =====================================================
rem Crea la tabla de ProductosPorOrden
rem =====================================================
CREATE TABLE ProductosPorOrden
(
   Ord_Id                 NUMBER (4) NOT NULL,
   Ppo_Id                 NUMBER (4) NOT NULL,
   Pro_Id                 NUMBER (8) NOT NULL,
   Ppo_PrecioActual       NUMBER (11,2) NOT NULL,
   Ppo_Cantidad           NUMBER (8) NOT NULL,
   Ppo_TotalLinea         NUMBER (11,2) NOT NULL,
   CONSTRAINT Ppo_Ord_FK FOREIGN KEY (Ord_Id) REFERENCES Ordenes (Ord_Id),
   CONSTRAINT Ppo_Pro_FK FOREIGN KEY (Pro_Id) REFERENCES Productos (Pro_Id),
   CONSTRAINT Ppo_PK PRIMARY KEY (Ord_Id,Ppo_Id)
);

rem select 'INSERT INTO ProductosPorOrden VALUES (' || 
rem        ordidn || ', ' || itemid || ', ' ||
rem        decode(prodid, 100860, 30100201,
rem                       100861, 30100202,
rem                       100870, 30100203,
rem                       100871, 30100204,
rem                       100890, 30100205,
rem                       101860, 30100206,
rem                       101863, 30100207,
rem                       102130, 30100208,
rem                       200376, 30100209,
rem                       200380, 30100210) ||
rem        ', ' || ap || ', ' || qty || ', ' || it || ');'
rem from (select ordid-150 ordidn, itemid, prodid, actualprice*1000 ap, qty, itemtot*100 it
rem       from item)
rem order by ordidn, itemid

INSERT INTO ProductosPorOrden VALUES (452, 1, 30100203, 2800, 20, 5600);
INSERT INTO ProductosPorOrden VALUES (453, 2, 30100201, 56000, 4, 22400);
INSERT INTO ProductosPorOrden VALUES (454, 1, 30100205, 58000, 3, 17400);
INSERT INTO ProductosPorOrden VALUES (454, 2, 30100202, 42000, 2, 8400);
INSERT INTO ProductosPorOrden VALUES (454, 3, 30100201, 44000, 10, 44000);
INSERT INTO ProductosPorOrden VALUES (455, 1, 30100202, 45000, 100, 450000);
INSERT INTO ProductosPorOrden VALUES (455, 2, 30100203, 2800, 500, 140000);
INSERT INTO ProductosPorOrden VALUES (455, 3, 30100205, 58000, 5, 29000);
INSERT INTO ProductosPorOrden VALUES (455, 4, 30100206, 24000, 50, 120000);
INSERT INTO ProductosPorOrden VALUES (455, 5, 30100207, 9000, 100, 90000);
INSERT INTO ProductosPorOrden VALUES (455, 6, 30100208, 3400, 10, 3400);
INSERT INTO ProductosPorOrden VALUES (461, 1, 30100202, 45000, 1, 4500);
INSERT INTO ProductosPorOrden VALUES (462, 1, 30100201, 30000, 100, 300000);
INSERT INTO ProductosPorOrden VALUES (462, 2, 30100202, 40500, 20, 81000);
INSERT INTO ProductosPorOrden VALUES (462, 3, 30100207, 10000, 150, 150000);
INSERT INTO ProductosPorOrden VALUES (462, 4, 30100204, 5500, 100, 55000);
INSERT INTO ProductosPorOrden VALUES (463, 1, 30100204, 5600, 100, 56000);
INSERT INTO ProductosPorOrden VALUES (463, 2, 30100206, 24000, 200, 480000);
INSERT INTO ProductosPorOrden VALUES (463, 3, 30100210, 4000, 150, 60000);
INSERT INTO ProductosPorOrden VALUES (463, 4, 30100209, 2200, 200, 44000);
INSERT INTO ProductosPorOrden VALUES (464, 1, 30100201, 35000, 444, 1554000);
INSERT INTO ProductosPorOrden VALUES (464, 2, 30100203, 2800, 1000, 280000);
INSERT INTO ProductosPorOrden VALUES (464, 3, 30100204, 5600, 1000, 560000);
INSERT INTO ProductosPorOrden VALUES (465, 1, 30100202, 45000, 4, 18000);
INSERT INTO ProductosPorOrden VALUES (465, 2, 30100203, 2800, 100, 28000);
INSERT INTO ProductosPorOrden VALUES (465, 3, 30100204, 5000, 50, 25000);
INSERT INTO ProductosPorOrden VALUES (466, 1, 30100202, 45000, 10, 45000);
INSERT INTO ProductosPorOrden VALUES (466, 2, 30100203, 2800, 50, 14000);
INSERT INTO ProductosPorOrden VALUES (466, 3, 30100205, 58000, 2, 11600);
INSERT INTO ProductosPorOrden VALUES (466, 4, 30100208, 3400, 10, 3400);
INSERT INTO ProductosPorOrden VALUES (466, 5, 30100209, 2400, 10, 2400);
INSERT INTO ProductosPorOrden VALUES (467, 1, 30100201, 35000, 50, 175000);
INSERT INTO ProductosPorOrden VALUES (467, 2, 30100202, 45000, 100, 450000);
INSERT INTO ProductosPorOrden VALUES (467, 3, 30100203, 2800, 500, 140000);
INSERT INTO ProductosPorOrden VALUES (467, 4, 30100204, 5600, 500, 280000);
INSERT INTO ProductosPorOrden VALUES (467, 5, 30100205, 58000, 500, 2900000);
INSERT INTO ProductosPorOrden VALUES (467, 6, 30100206, 24000, 100, 240000);
INSERT INTO ProductosPorOrden VALUES (467, 7, 30100207, 12500, 200, 250000);
INSERT INTO ProductosPorOrden VALUES (467, 8, 30100208, 3400, 100, 34000);
INSERT INTO ProductosPorOrden VALUES (467, 9, 30100209, 2400, 200, 48000);
INSERT INTO ProductosPorOrden VALUES (467, 10, 30100210, 4000, 300, 120000);
INSERT INTO ProductosPorOrden VALUES (469, 1, 30100210, 4000, 100, 40000);
INSERT INTO ProductosPorOrden VALUES (469, 2, 30100209, 2400, 100, 24000);
INSERT INTO ProductosPorOrden VALUES (469, 3, 30100208, 3400, 100, 34000);
INSERT INTO ProductosPorOrden VALUES (469, 4, 30100204, 5600, 50, 28000);
INSERT INTO ProductosPorOrden VALUES (470, 1, 30100201, 35000, 10, 35000);
INSERT INTO ProductosPorOrden VALUES (470, 2, 30100209, 2400, 1000, 240000);
INSERT INTO ProductosPorOrden VALUES (470, 3, 30100208, 3400, 500, 170000);
INSERT INTO ProductosPorOrden VALUES (471, 1, 30100202, 45000, 10, 45000);
INSERT INTO ProductosPorOrden VALUES (471, 2, 30100203, 2800, 100, 28000);

CREATE SEQUENCE Ord_Id
INCREMENT BY 1
START WITH 472
NOCACHE;

CREATE SEQUENCE Pro_Id
INCREMENT BY 1
START WITH 30100211
NOCACHE;

CREATE SEQUENCE Cli_Id
INCREMENT BY 1
START WITH 19
NOCACHE;

CREATE VIEW Ventas AS
   SELECT   Clientes.Emp_Id, Ordenes.Cli_Id, Clientes.Cli_Nombre, PPO.Pro_Id, 
            Productos.Pro_Nombre, SUM (PPO.Ppo_TotalLinea) EsteTotal
   FROM     ((Ordenes JOIN 
               ProductosPorOrden PPO ON (Ordenes.Ord_Id = PPO.Ord_Id)) JOIN 
                  Productos ON (Productos.Pro_Id = PPO.Pro_Id)) JOIN
                     Clientes ON (Ordenes.Cli_Id = Clientes.Cli_Id)
   GROUP BY Clientes.Emp_Id, Ordenes.Cli_Id, Clientes.Cli_Nombre, PPO.Pro_Id, 
            Productos.Pro_Nombre;

rem SET TERMOUT ON;
