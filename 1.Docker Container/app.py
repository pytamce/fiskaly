import os
from flask import Flask

app = Flask(__name__)

# pod_name will help to see which pod handled the request. to test load balancer
pod_name = os.environ.get("HOSTNAME", "unknown")


@app.route("/")
def hello():
    return f"Hello world from pod {pod_name}!"


# Liveness probe: checks if the app is running
@app.route("/healthz")
def healthz():
    return "alive", 200


# Readiness probe: checks if the app is rea
@app.route("/readyz")
def readyz():
    return "ready", 200


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
