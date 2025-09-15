# 🐳 Docker Container — Hello world

This repository contains a minimal example that builds a small web application container image which responds **"Hello world"** to HTTP requests on **port 8080**.

---

## Task

* Build a minimal HTTP server (Python/Flask) that returns `Hello world` on `/`.
* Container listens on port **8080**.
* Provide commands to build and run the container so it is reachable from the local machine and other machines on the same network.

---

## Files

```
README.md
Dockerfile          # simple Dockerfile
app.py              # Flask app
requirements.txt    # pin exact version of Flask
```

---

## Build and run

1. Build the imag:

```bash
docker build -t hello-8080:latest .
```

2. Run the container and map container port 8080 to host port 8080:

```bash
docker run --rm -p 8080:8080 --name hello-app hello-8080:latest
```

3. Test locally on the host machine:

```bash
curl http://localhost:8080/
# => Hello world
```
