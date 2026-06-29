# Base image
FROM python:3.12-slim

# Prevent Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Ensure logs are sent directly to stdout
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy dependency list first (better layer caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application
COPY . .

# Expose the FastAPI port
EXPOSE 8000

# Start the API
CMD ["uvicorn", "app.api:app", "--host", "0.0.0.0", "--port", "8000"]