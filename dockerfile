FROM python:3.10
ENV PYTHONUNBUFFERED 1

ARG SECRET_KEY=teste.com
ENV SECRET_KEY ${SECRET_KEY}

ARG DATABASE_NAME=teste.com
ENV DATABASE_NAME ${DATABASE_NAME}

ARG DATABASE_USER=teste.com
ENV DATABASE_USER ${DATABASE_USER}

ARG DATABASE_PASS=teste.com
ENV DATABASE_PASS ${DATABASE_PASS}

ARG DATABASE_HOST=name1db.ck13dgswr816.us-west-2.rds.amazonaws.com

ENV DATABASE_HOST ${DATABASE_HOST}

ARG DATABASE_ROOT_PASS=teste.com
ENV DATABASE_ROOT_PASS ${DATABASE_ROOT_PASS}

ARG TESTE_ENV=teste.com
ENV TESTE_ENV ${TESTE_ENV}

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY . /app
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate

EXPOSE 80

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:80"]