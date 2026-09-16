from app.database import get_connection


def get_crops():
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT
                    c.id,
                    c.codigo,
                    c.nombre,
                    tc.nombre AS tipo_cultivo,
                    u.nombre AS ubicacion,
                    c.fecha_siembra,
                    c.estado,
                    c.observaciones,
                    c.fecha_registro
                FROM cultivos c
                INNER JOIN tipos_cultivo tc
                    ON tc.id = c.tipo_cultivo_id
                LEFT JOIN ubicaciones u
                    ON u.id = c.ubicacion_id
                ORDER BY c.id;
            """)

            rows = cursor.fetchall()

    return [
        {
            "id": row[0],
            "codigo": row[1],
            "nombre": row[2],
            "tipo_cultivo": row[3],
            "ubicacion": row[4],
            "fecha_siembra": row[5],
            "estado": row[6],
            "observaciones": row[7],
            "fecha_registro": row[8],
        }
        for row in rows
    ]


def create_crop(
    codigo,
    nombre,
    tipo_cultivo_id,
    ubicacion_id,
    fecha_siembra,
    observaciones,
):
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute("""
                INSERT INTO cultivos (
                    codigo,
                    nombre,
                    tipo_cultivo_id,
                    ubicacion_id,
                    fecha_siembra,
                    observaciones
                )
                VALUES (%s, %s, %s, %s, %s, %s)
                RETURNING id;
            """, (
                codigo,
                nombre,
                tipo_cultivo_id,
                ubicacion_id,
                fecha_siembra,
                observaciones,
            ))

            crop_id = cursor.fetchone()[0]

        connection.commit()

    return crop_id