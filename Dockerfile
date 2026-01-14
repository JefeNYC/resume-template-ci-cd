FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# 1. Force update the OS and the core Python 'setuptools' package 
# We do this in one layer to ensure the fix is applied immediately.
RUN apt-get update && apt-get upgrade -y && \
    pip install --no-cache-dir --upgrade pip setuptools && \
    rm -rf /var/lib/apt/lists/*

# 2. Copy your requirements and project files
COPY requirements.txt .
COPY . .

# 3. Install your specific app dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 4. Config & Launch
EXPOSE 5001

ENV FLASK_APP=app.py

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5001"]