from fastapi import FastAPI
from app.api.routes import router

app = FastAPI(title="AI Voice2Task API")

app.include_router(router)

@app.get("/")
def read_root():
    return {"message": "Welcome to AI Voice2Task API"}
