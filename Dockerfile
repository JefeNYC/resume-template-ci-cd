FROM python:3.9-slim

# 1. Set the working directory
WORKDIR /app

# 2. Fix OS-level vulnerabilities (Best Practice)
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

# 3. Fix the specific 'setuptools' vulnerability (Task 10 Fix)
RUN pip install --no-cache-dir --upgrade setuptools

# 4. Copy your project files
COPY . .

# 5. Install your app dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Metadata and Execution
EXPOSE 5001

ENV FLASK_APP=app.py

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0", "--port=5001"]