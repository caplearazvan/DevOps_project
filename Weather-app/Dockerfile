# 1. Base image
FROM python:3.8.3-slim-buster

# 2. Copy all files 
copy . .

# 3. Install dependencies
RUN pip install -r requirements.txt

# 4. Run command for app
CMD ["python", "./wheather.py"]

