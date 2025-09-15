import os
from flask import Flask
app = Flask(__name__)
pod_name = os.environ.get('HOSTNAME', 'unknown')

@app.route("/")
def hello():
    return f"Hello from pod {pod_name}!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)