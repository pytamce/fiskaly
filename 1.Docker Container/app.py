import os
from flask import Flask
app = Flask(__name__)
# added to test nginx LB from 2nd challenge
pod_name = os.environ.get('HOSTNAME', 'unknown')

@app.route("/")
def hello():
    return f"Hello world from pod {pod_name}!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)