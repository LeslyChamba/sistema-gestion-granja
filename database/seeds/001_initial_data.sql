-- ============================================================
-- FARM MANAGER
-- Datos iniciales de la base de datos
-- ============================================================

-- ============================================================
-- ESPECIES
-- ============================================================

INSERT INTO especies (nombre, descripcion)
VALUES
    ('Gallina', 'Ave doméstica criada para producción de huevos y carne.'),
    ('Pato', 'Ave doméstica criada para producción de huevos y carne.');


-- ============================================================
-- UBICACIONES
-- ============================================================

INSERT INTO ubicaciones (nombre, tipo, descripcion)
VALUES
    ('Gallinero', 'Animal', 'Espacio destinado a las gallinas.'),
    ('Área de patos', 'Animal', 'Espacio destinado a los patos.'),
    ('Parcela 1', 'Cultivo', 'Primera parcela de cultivo de la granja.'),
    ('Parcela 2', 'Cultivo', 'Segunda parcela de cultivo de la granja.'),
    ('Huerto', 'Cultivo', 'Área destinada a hortalizas.');


-- ============================================================
-- TIPOS DE CULTIVO
-- ============================================================

INSERT INTO tipos_cultivo (nombre, descripcion)
VALUES
    ('Cereal', 'Cultivos destinados principalmente a cereales.'),
    ('Hortaliza', 'Cultivos destinados a producción de hortalizas.');


-- ============================================================
-- TIPOS DE ACTIVIDAD
-- ============================================================

INSERT INTO tipos_actividad (nombre, descripcion)
VALUES
    ('Alimentación', 'Registro de alimentación de un animal.'),
    ('Vacunación', 'Aplicación de vacunas a un animal.'),
    ('Tratamiento', 'Tratamiento aplicado a un animal.'),
    ('Observación', 'Registro de una observación sobre un animal o cultivo.'),
    ('Riego', 'Riego realizado a un cultivo.'),
    ('Fertilización', 'Aplicación de fertilizante a un cultivo.'),
    ('Siembra', 'Registro de siembra de un cultivo.'),
    ('Cosecha', 'Registro de cosecha de un cultivo.'),
    ('Tratamiento de cultivo', 'Tratamiento aplicado a un cultivo.');