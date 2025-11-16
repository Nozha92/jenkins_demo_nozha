FROM python:3.11-slim

WORKDIR /app

# Installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code de l'application
COPY app.py .

# Le conteneur écoutera sur le port 5000
EXPOSE 5000

# Lancer l'application Flask
CMD ["python", "app.py"]
