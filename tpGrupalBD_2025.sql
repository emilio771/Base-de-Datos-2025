     --- Tablas ---

CREATE TABLE persona (
    nroDoc VARCHAR(20) NOT NULL,
    tipoDoc VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    fechaNac DATE,
    telefono VARCHAR(20),
    apellido VARCHAR(50),
    nombre VARCHAR(50),
    PRIMARY KEY (nroDoc, tipoDoc)
);

CREATE TABLE libro (
    ISBN VARCHAR(20) PRIMARY KEY,
    portada VARCHAR(255),
    nombreLibro VARCHAR(100)
);

CREATE TABLE tema (
    codigoTema VARCHAR(10) PRIMARY KEY,
    nombreTema VARCHAR(50)
);

CREATE TABLE edicion (
    idEdicion VARCHAR(10) PRIMARY KEY,
    fechaInicio DATE,
    fechaCierre DATE,
    horaInicio TIME,
    horaCierre TIME,
    codigoTemaCierre VARCHAR(10),
    codigoTemaApertura VARCHAR(10),
    FOREIGN KEY (codigoTemaCierre) REFERENCES TEMA(codigoTema),
    FOREIGN KEY (codigoTemaApertura) REFERENCES TEMA(codigoTema)
);

CREATE TABLE lector (
    nroDocLector VARCHAR(20) NOT NULL,
    tipoDocLector VARCHAR(5) NOT NULL,
    actividad VARCHAR(50),
    PRIMARY KEY (nroDocLector, tipoDocLector),
    FOREIGN KEY (nroDocLector, tipoDocLector) 
        REFERENCES PERSONA(nroDoc, tipoDoc)
);

CREATE TABLE autor (
    nroDocAutor VARCHAR(20) NOT NULL,
    tipoDocAutor VARCHAR(5) NOT NULL,
    nacionalidad VARCHAR(30),
    PRIMARY KEY (nroDocAutor, tipoDocAutor),
    FOREIGN KEY (nroDocAutor, tipoDocAutor) 
        REFERENCES PERSONA(nroDoc, tipoDoc)
);

CREATE TABLE ejemplar (
    nroCopia VARCHAR(10) NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    nroMesaExpone VARCHAR(10),
    PRIMARY KEY (nroCopia, ISBN),
    FOREIGN KEY (ISBN) REFERENCES LIBRO(ISBN)
);

CREATE TABLE lectura (
    idLectura VARCHAR(10) PRIMARY KEY,
    fechaLectura DATE,
    ISBN VARCHAR(20) NOT NULL,
    nroCopia VARCHAR(10) NOT NULL,
    FOREIGN KEY (nroCopia, ISBN) 
        REFERENCES EJEMPLAR(nroCopia, ISBN)
);

-- Tablas de relaciones
CREATE TABLE realiza (
    nroDocLector VARCHAR(20) NOT NULL,
    tipoDocLector VARCHAR(5) NOT NULL,
    idLectura VARCHAR(10) NOT NULL,
    PRIMARY KEY (nroDocLector, tipoDocLector, idLectura),
    FOREIGN KEY (nroDocLector, tipoDocLector) 
        REFERENCES LECTOR(nroDocLector, tipoDocLector),
    FOREIGN KEY (idLectura) REFERENCES LECTURA(idLectura)
);

CREATE TABLE pertenece (
    idLectura VARCHAR(10) PRIMARY KEY,
    idEdicion VARCHAR(10) NOT NULL,
    FOREIGN KEY (idLectura) REFERENCES LECTURA(idLectura),
    FOREIGN KEY (idEdicion) REFERENCES EDICION(idEdicion)
);

CREATE TABLE expone (
    idEdicion VARCHAR(10) NOT NULL,
    codigoTema VARCHAR(10) NOT NULL,
    PRIMARY KEY (idEdicion, codigoTema),
    FOREIGN KEY (idEdicion) REFERENCES EDICION(idEdicion),
    FOREIGN KEY (codigoTema) REFERENCES TEMA(codigoTema)
);

CREATE TABLE prefiere (
    motivo TEXT,
    ISBN VARCHAR(20) NOT NULL,
    nroDocLector VARCHAR(20) NOT NULL,
    tipoDocLector VARCHAR(5) NOT NULL,
    PRIMARY KEY (ISBN, nroDocLector, tipoDocLector),
    FOREIGN KEY (ISBN) REFERENCES LIBRO(ISBN),
    FOREIGN KEY (nroDocLector, tipoDocLector) 
        REFERENCES LECTOR(nroDocLector, tipoDocLector)
);
