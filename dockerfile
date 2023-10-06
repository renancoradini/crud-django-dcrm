FROM python:3.10
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY . /app
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

EXPOSE 8000

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000"]
