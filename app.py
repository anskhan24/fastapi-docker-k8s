from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello from DockerHub + Kubernetes + Github Actions"}
    return {"message": "CI/CD working on AKS 🚀"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}

