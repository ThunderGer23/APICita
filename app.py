from fastapi import FastAPI
from routes.red import red
from docs import tags_metadata
from os import environ as env
from notigram import ping

ping(env['TOKEN'], 'Aquí APICita que buen estereo :v/!')
# Creating a FastAPI object.
app = FastAPI(
    title= "API para las citas",
    description= "API que determina si la cita de un documento esta en formato APA o IEEE",
    version = "1.0",
    contact={
        "name": "Luis Gerardo Baesa Ramirez, Susana Itzel Garduño Sandoval, Arturo Emmanuel Toledo Aguado",
        "url": "https://github.com/ThunderGer23/APICita",
        "email": "dp@x-force.example.com",
    },
    openapi_tags= tags_metadata
)

# Importing the `user` module from the `routes` folder.
app.include_router(red)