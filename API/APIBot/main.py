from fastapi import FastAPI
from decouple import config

app = FastAPI()

@app.get('/')
async def root():
    return {"teste":"Hello world"}