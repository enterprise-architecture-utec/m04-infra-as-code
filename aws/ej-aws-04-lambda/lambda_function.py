import json
import os


def lambda_handler(event, context):
    """
    Funcion Lambda de ejemplo para el laboratorio UTEC.
    Recibe un evento con un campo 'nombre' y retorna un saludo.
    """
    entorno = os.environ.get("ENTORNO", "desconocido")
    curso = os.environ.get("CURSO", "desconocido")

    nombre = event.get("nombre", "Estudiante")

    mensaje = f"Hola {nombre} desde Lambda! Entorno: {entorno} | Curso: {curso}"

    print(f"[INFO] Evento recibido: {json.dumps(event)}")
    print(f"[INFO] Mensaje: {mensaje}")

    return {
        "statusCode": 200,
        "body": mensaje,
        "metadata": {
            "entorno": entorno,
            "curso": curso,
            "function_version": context.function_version,
            "request_id": context.aws_request_id,
        },
    }
