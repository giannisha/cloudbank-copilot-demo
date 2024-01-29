FROM python:3.9-slim

WORKDIR /usr/src/app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

# Run app.py using gunicorn wsgi server
CMD ["gunicorn", "-c", "gunicorn_config.py", "api:app"]