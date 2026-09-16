-- ============================================================
-- TABLA: ESPECIES
-- Catálogo de especies de animales de la granja.
-- ============================================================
CREATE TABLE especies (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);
-- ============================================================
-- TABLA: UBICACIONES
-- Lugares físicos donde se encuentran animales o cultivos.
-- ============================================================

CREATE TABLE ubicaciones (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    tipo VARCHAR(50) NOT NULL,
    descripcion TEXT
);
-- ============================================================
-- TABLA: ANIMALES
-- Registro individual de los animales de la granja.
-- ============================================================

CREATE TABLE animales (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    especie_id INTEGER NOT NULL,
    ubicacion_id INTEGER,
    sexo VARCHAR(20),
    fecha_nacimiento DATE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    observaciones TEXT,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_animales_especie
        FOREIGN KEY (especie_id)
        REFERENCES especies(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_animales_ubicacion
        FOREIGN KEY (ubicacion_id)
        REFERENCES ubicaciones(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_animales_sexo
        CHECK (sexo IN ('Hembra', 'Macho')),

    CONSTRAINT chk_animales_estado
        CHECK (estado IN ('Activo', 'Inactivo'))
);
-- ============================================================
-- TABLA: TIPOS_CULTIVO
-- Catálogo de tipos de cultivo disponibles en la granja.
-- ============================================================

CREATE TABLE tipos_cultivo (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);
-- ============================================================
-- TABLA: CULTIVOS
-- Registro de lotes o cultivos de la granja.
-- ============================================================

CREATE TABLE cultivos (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    tipo_cultivo_id INTEGER NOT NULL,
    ubicacion_id INTEGER,
    fecha_siembra DATE,
    estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    observaciones TEXT,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_cultivos_tipo
        FOREIGN KEY (tipo_cultivo_id)
        REFERENCES tipos_cultivo(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_cultivos_ubicacion
        FOREIGN KEY (ubicacion_id)
        REFERENCES ubicaciones(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT chk_cultivos_estado
        CHECK (estado IN ('Activo', 'Inactivo'))
);


-- ============================================================
-- TABLA: TIPOS_ACTIVIDAD
-- Catálogo de actividades que pueden registrarse.
-- ============================================================

CREATE TABLE tipos_actividad (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL UNIQUE,
    descripcion TEXT
);


-- ============================================================
-- TABLA: ACTIVIDADES
-- Historial de actividades realizadas sobre un animal
-- o sobre un cultivo.
-- ============================================================

CREATE TABLE actividades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_actividad_id INTEGER NOT NULL,
    animal_id INTEGER,
    cultivo_id INTEGER,
    fecha DATE NOT NULL,
    descripcion TEXT NOT NULL,
    observaciones TEXT,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_actividades_tipo
        FOREIGN KEY (tipo_actividad_id)
        REFERENCES tipos_actividad(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_actividades_animal
        FOREIGN KEY (animal_id)
        REFERENCES animales(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_actividades_cultivo
        FOREIGN KEY (cultivo_id)
        REFERENCES cultivos(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_actividad_referencia
        CHECK (
            (animal_id IS NOT NULL AND cultivo_id IS NULL)
            OR
            (animal_id IS NULL AND cultivo_id IS NOT NULL)
        )
);