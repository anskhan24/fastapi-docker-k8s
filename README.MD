# fastapi-docker-k8s

A minimal, production-oriented example of running a **FastAPI** application in **Docker** and deploying it to **Kubernetes**.

## What’s in this repo

- **FastAPI app** (Python)
- **Dockerfile** to containerize the app
- **Kubernetes manifests** to run the app in a cluster
- (Optional) **Ingress / Service / Config** files depending on your setup

## Prerequisites

- Python 3.10+ (for local dev)
- Docker
- kubectl
- A Kubernetes cluster (kind, minikube, k3d, or a managed cluster)

## Local development

1. Create and activate a virtual environment.
2. Install dependencies.
3. Run the app.

Example:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

Then open:

- http://localhost:8000
- http://localhost:8000/docs (Swagger UI)
- http://localhost:8000/redoc

## Build and run with Docker

### Build

```bash
docker build -t fastapi-docker-k8s:local .
```

### Run

```bash
docker run --rm -p 8000:8000 fastapi-docker-k8s:local
```

Visit:

- http://localhost:8000/docs

## Deploy to Kubernetes

> Update image name/tag and namespace to match your environment.

### Apply manifests

```bash
kubectl apply -f k8s/
```

### Verify

```bash
kubectl get pods
kubectl get svc
```

### Port-forward (quick test)

If your service is called `fastapi-service` and exposes port 80:

```bash
kubectl port-forward svc/fastapi-service 8080:80
```

Then open:

- http://localhost:8080/docs

## Configuration

Common knobs you may want to parameterize:

- App host/port
- Environment variables (e.g., `ENV`, `LOG_LEVEL`)
- Liveness/Readiness probes
- Resource requests/limits

## Project structure (example)

```text
.
├── app/
│   ├── main.py
│   └── ...
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ...
├── Dockerfile
├── requirements.txt
└── README.MD
```

## Troubleshooting

- **Image pull errors**: ensure your cluster can access the image registry, or load the image into kind/minikube.
- **CrashLoopBackOff**: check logs with `kubectl logs <pod>` and describe the pod with `kubectl describe pod <pod>`.
- **Ingress not working**: verify your ingress controller is installed and your hostnames resolve.

## License

Add a license file if you plan to distribute this project.