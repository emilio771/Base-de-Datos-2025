-- Tabla PERSONA (entidad principal)
CREATE TABLE PERSONA (
    tipoDoc VARCHAR(20) NOT NULL,
    nroDoc VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    fechaNac DATE,
    telefono VARCHAR(20),
    apellido VARCHAR(50) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (tipoDoc, nroDoc)
) ENGINE=InnoDB;

-- Tabla TEMA
CREATE TABLE TEMA (
    codigoTema INT NOT NULL AUTO_INCREMENT,
    nombreTema VARCHAR(100) NOT NULL,
    PRIMARY KEY (codigoTema)
) ENGINE=InnoDB;

-- Tabla AUTOR (especialización de PERSONA)
CREATE TABLE AUTOR (
    tipoDocAutor VARCHAR(20) NOT NULL,
    nroDocAutor VARCHAR(20) NOT NULL,
    nacionalidad VARCHAR(50),
    PRIMARY KEY (tipoDocAutor, nroDocAutor),
    FOREIGN KEY (tipoDocAutor, nroDocAutor) 
        REFERENCES PERSONA(tipoDoc, nroDoc)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla LECTOR (especialización de PERSONA)
CREATE TABLE LECTOR (
    tipoDocLector VARCHAR(20) NOT NULL,
    nroDocLector VARCHAR(20) NOT NULL,
    actividad VARCHAR(50),
    PRIMARY KEY (tipoDocLector, nroDocLector),
    FOREIGN KEY (tipoDocLector, nroDocLector) 
        REFERENCES PERSONA(tipoDoc, nroDoc)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla LIBRO
CREATE TABLE LIBRO (
    ISBN VARCHAR(20) NOT NULL,
    portada VARCHAR(255),
    nombreLibro VARCHAR(100) NOT NULL,
    tipoDocAutor VARCHAR(20) NOT NULL,
    nroDocAutor VARCHAR(20) NOT NULL,
    PRIMARY KEY (ISBN),
    FOREIGN KEY (tipoDocAutor, nroDocAutor) 
        REFERENCES AUTOR(tipoDocAutor, nroDocAutor)
        ON DELETE RESTRICT  -- Política RESTRICT para borrado
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla EDICION
CREATE TABLE EDICION (
    idEdicion INT NOT NULL AUTO_INCREMENT,
    fechaInicio DATE,
    fechaCierre DATE,
    horaInicio TIME,
    horaCierre TIME,
    codigoTemaApertura INT NOT NULL,
    codigoTemaCierre INT,  -- Permite NULL para SET NULL
    PRIMARY KEY (idEdicion),
    FOREIGN KEY (codigoTemaApertura) 
        REFERENCES TEMA(codigoTema)
        ON DELETE RESTRICT,  -- Política RESTRICT
    FOREIGN KEY (codigoTemaCierre) 
        REFERENCES TEMA(codigoTema)
        ON DELETE SET NULL  -- Política SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla EJEMPLAR
CREATE TABLE EJEMPLAR (
    ISBN VARCHAR(20) NOT NULL,
    nroCopia INT NOT NULL,
    nroMesaExpone INT,
    PRIMARY KEY (ISBN, nroCopia),
    FOREIGN KEY (ISBN) 
        REFERENCES LIBRO(ISBN)
        ON DELETE CASCADE  -- Política CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla LECTURA
CREATE TABLE LECTURA (
    idLectura INT NOT NULL AUTO_INCREMENT,
    fechaLectura DATE NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    nroCopia INT NOT NULL,
    PRIMARY KEY (idLectura),
    FOREIGN KEY (ISBN, nroCopia) 
        REFERENCES EJEMPLAR(ISBN, nroCopia)
        ON DELETE CASCADE  -- Política CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla REALIZA
CREATE TABLE REALIZA (
    tipoDocLector VARCHAR(20) NOT NULL,
    nroDocLector VARCHAR(20) NOT NULL,
    idLectura INT NOT NULL,
    PRIMARY KEY (idLectura),
    FOREIGN KEY (tipoDocLector, nroDocLector) 
        REFERENCES LECTOR(tipoDocLector, nroDocLector)
        ON DELETE CASCADE,  -- Política CASCADE
    FOREIGN KEY (idLectura) 
        REFERENCES LECTURA(idLectura)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla PERTENECE
CREATE TABLE PERTENECE (
    idLectura INT NOT NULL,
    idEdicion INT NOT NULL,
    PRIMARY KEY (idLectura, idEdicion),
    FOREIGN KEY (idLectura) 
        REFERENCES LECTURA(idLectura)
        ON DELETE CASCADE,  -- Política CASCADE
    FOREIGN KEY (idEdicion) 
        REFERENCES EDICION(idEdicion)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla EXPONE
CREATE TABLE EXPONE (
    idEdicion INT NOT NULL,
    codigoTema INT NOT NULL,
    PRIMARY KEY (idEdicion, codigoTema),
    FOREIGN KEY (idEdicion) 
        REFERENCES EDICION(idEdicion)
        ON DELETE CASCADE,  -- Política CASCADE
    FOREIGN KEY (codigoTema) 
        REFERENCES TEMA(codigoTema)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla PREFIERE
CREATE TABLE PREFIERE (
    motivo TEXT,
    ISBN VARCHAR(20) NOT NULL,
    tipoDocLector VARCHAR(20) NOT NULL,
    nroDocLector VARCHAR(20) NOT NULL,
    PRIMARY KEY (ISBN, tipoDocLector, nroDocLector),
    FOREIGN KEY (ISBN) 
        REFERENCES LIBRO(ISBN)
        ON DELETE CASCADE,  -- Política CASCADE
    FOREIGN KEY (tipoDocLector, nroDocLector) 
        REFERENCES LECTOR(tipoDocLector, nroDocLector)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Tabla ASISTE
CREATE TABLE ASISTE (
    tipoDocAutor VARCHAR(20) NOT NULL,
    nroDocAutor VARCHAR(20) NOT NULL,
    idEdicion INT NOT NULL,
    PRIMARY KEY (tipoDocAutor, nroDocAutor, idEdicion),
    FOREIGN KEY (tipoDocAutor, nroDocAutor) 
        REFERENCES AUTOR(tipoDocAutor, nroDocAutor)
        ON DELETE CASCADE,  -- Política CASCADE
    FOREIGN KEY (idEdicion) 
        REFERENCES EDICION(idEdicion)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
