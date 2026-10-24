from contextlib import asynccontextmanager
from .prediction import load_class_names,load_model
from fastapi import FastAPI
from .config import API_TITLE,API_VERSION
from .routes import router


@asynccontextmanager
async def lifespan(app: FastAPI):
    load_model()
    load_class_names()
    yield
 
 
app = FastAPI(title="EcoSort-AI Waste Classifier", lifespan=lifespan)
app.include_router(router)
