from fastapi import APIRouter
from models.red import Red
from helpers.inter import interpretacion_cita
from helpers.model import new_model as model
from os import environ as env
from notigram import ping

red = APIRouter()

@red.post('/red', response_model= list[str], tags=["Text"])
def testDeRed(red: Red):
    ping(env['TOKEN'], 'Iniciando análisis de APICita')
    analisis = model.predict(red.citas)
    ping(env['TOKEN'], 'resultados de APICita listos')
    return interpretacion_cita(analisis)