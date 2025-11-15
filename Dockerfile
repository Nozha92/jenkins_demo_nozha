# Image de base Python
FROM python:3.10-slim

# Crée un dossier pour l'app
WORKDIR /app

# Copie le script Python dans l'image
COPY script.py /app/script.py

# (optionnel) Installer des dépendances si tu as un requirements.txt
# COPY requirements.txt /app/requirements.txt
# RUN pip install -r requirements.txt

# Commande par défaut : exécuter le script
CMD ["python", "script.py"]
