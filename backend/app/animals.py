from app.database import get_connection


def get_animals():
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT
                    a.id,
                    a.codigo,
                    e.nombre AS especie,
                    u.nombre AS ubicacion,
                    a.sexo,
                    a.fecha_nacimiento,
                    a.estado,
                    a.observaciones,
                    a.fecha_registro
                FROM animales a
                INNER JOIN especies e ON e.id = a.especie_id
                LEFT JOIN ubicaciones u ON u.id = a.ubicacion_id
                ORDER BY a.id;
            """)

            rows = cursor.fetchall()

    return [
        {
            "id": row[0],
            "codigo": row[1],
            "especie": row[2],
            "ubicacion": row[3],
            "sexo": row[4],
            "fecha_nacimiento": row[5],
            "estado": row[6],
            "observaciones": row[7],
            "fecha_registro": row[8],
        }
        for row in rows
    ]


def create_animal(
    codigo,
    especie_id,
    ubicacion_id,
    sexo,
    fecha_nacimiento,
    observaciones,
):
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO animales (
                    codigo,
                    especie_id,
                    ubicacion_id,
                    sexo,
                    fecha_nacimiento,
                    observaciones
                )
                VALUES (%s, %s, %s, %s, %s, %s)
                RETURNING id;
            """, (
                codigo,
                especie_id,
                ubicacion_id,
                sexo,
                fecha_nacimiento,
                observaciones,
            ))

            animal_id = cursor.fetchone()[0]

        connection.commit()

    return animal_id