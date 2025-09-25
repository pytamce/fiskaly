
# Stage 1: Build dependencies
FROM python:3.11-slim AS builder

# Set working directory
WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements for better caching
COPY requirements.txt .

# Install dependencies into a target folder (not system-wide)
RUN pip install --upgrade pip \
    && pip install --prefix=/install -r requirements.txt


# Stage 2: Runtime image
FROM python:3.11-slim

WORKDIR /app

# Create non-root user
RUN useradd --create-home appuser

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Copy application code
COPY app.py .

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8080

# Run the app
CMD ["python", "app.py"]
