import json
import os
import functions_framework


@functions_framework.http
def hello_http(request):
    """
    Cloud Function de ejemplo para el laboratorio UTEC.
    Acepta requests GET y POST y retorna un JSON de respuesta.
    """
    entorno = os.environ.get("ENTORNO", "desconocido")
    curso = os.environ.get("CURSO", "desconocido")
    student_name = os.environ.get("STUDENT_NAME", "desconocido")
    student_id = os.environ.get("STUDENT_ID", "desconocido")

    # Obtener nombre del query param o del body JSON
    nombre = "Estudiante"
    if request.method == "GET":
        nombre = request.args.get("nombre", "Estudiante")
    elif request.method == "POST":
        try:
            data = request.get_json(silent=True) or {}
            nombre = data.get("nombre", "Estudiante")
        except Exception:
            pass

    respuesta = {
        "mensaje": f"Hola {nombre} desde Cloud Functions Gen 2!",
        "entorno": entorno,
        "curso": curso,
        "student_name": student_name,
        "student_id": student_id,
        "metodo": request.method,
        "path": request.path,
    }

    print(f"[INFO] Request de {nombre} via {request.method} por estudiante {student_name} (ID: {student_id})")

    return (
        json.dumps(respuesta, ensure_ascii=False),
        200,
        {"Content-Type": "application/json; charset=utf-8"},
    )
