from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello Nozha 👋, ton pipeline Jenkins + Docker + CD fonctionne !"

@app.route("/health")
def health():
    return "OK"

if __name__ == "__main__":
    # Très important : 0.0.0.0 pour que Docker puisse exposer le port
    app.run(host="0.0.0.0", port=5000)
