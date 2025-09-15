# Use official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install Flask
RUN pip install flask

# Copy application code
COPY app.py .

# Expose port
EXPOSE 8080

# Run the app
CMD ["python", "app.py"]
