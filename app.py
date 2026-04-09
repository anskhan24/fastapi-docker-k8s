from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from Docker + Kubernetes + Azure project"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}