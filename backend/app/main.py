from datetime import date
from typing import Optional

from fastapi import FastAPI
from pydantic import BaseModel

from app.animals import create_animal, get_animals
from app.crops import create_crop, get_crops
from app.database import get_connection

app = FastAPI(
    title="FarmManager API",
    description="API para la gestión de una granja",
    version="0.1.0",
)


@app.get("/health")
def health_check():
    return {
        "status": "ok",
        "message": "FarmManager API funcionando"
    }


@app.get("/especies")
def listar_especies():
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT id, nombre, descripcion FROM especies ORDER BY id"
            )

            rows = cursor.fetchall()

    return [
        {
            "id": row[0],
            "nombre": row[1],
            "descripcion": row[2],
        }
        for row in rows
    ]

class AnimalCreate(BaseModel):
    codigo: str
    especie_id: int
    ubicacion_id: Optional[int] = None
    sexo: Optional[str] = None
    fecha_nacimiento: Optional[date] = None
    observaciones: Optional[str] = None


@app.get("/animales")
def listar_animales():
    return get_animals()


@app.post("/animales")
def registrar_animal(animal: AnimalCreate):
    animal_id = create_animal(
        animal.codigo,
        animal.especie_id,
        animal.ubicacion_id,
        animal.sexo,
        animal.fecha_nacimiento,
        animal.observaciones,
    )

    return {
        "message": "Animal registrado correctamente",
        "id": animal_id,
    }

class CropCreate(BaseModel):
    codigo: str
    nombre: str
    tipo_cultivo_id: int
    ubicacion_id: Optional[int] = None
    fecha_siembra: Optional[date] = None
    observaciones: Optional[str] = None


@app.get("/cultivos")
def listar_cultivos():
    return get_crops()


@app.post("/cultivos")
def registrar_cultivo(cultivo: CropCreate):
    crop_id = create_crop(
        cultivo.codigo,
        cultivo.nombre,
        cultivo.tipo_cultivo_id,
        cultivo.ubicacion_id,
        cultivo.fecha_siembra,
        cultivo.observaciones,
    )

    return {
        "message": "Cultivo registrado correctamente",
        "id": crop_id,
    }