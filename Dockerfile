FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

WORKDIR /app

# Install minimal build deps (add libpq-dev if using Postgres)
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

COPY . .

# collectstatic (ensure STATIC_ROOT is set in settings)
RUN python manage.py collectstatic --noinput

# Create non-root user and use it
RUN useradd --create-home appuser && chown -R appuser /app
USER appuser

# Cloud Run will set $PORT; bind Gunicorn to it
CMD ["gunicorn", "my_club.wsgi:application", "--bind", "0.0.0.0:${PORT}", "--workers", "2", "--threads", "4"]
# ...existing code...