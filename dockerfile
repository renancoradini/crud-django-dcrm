FROM python:3.10
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt

COPY . /app
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate


ARG SECRET_KEY="django-insecure-#s)!uwp$&gyz%$f36)-wx!cp%e94zv*qus6l(i-+ff10xxc8ef"
ENV SECRET_KEY ${SECRET_KEY}

ARG DATABASE_NAME
ENV DATABASE_NAME ${DATABASE_NAME}

ARG DATABASE_USER
ENV DATABASE_USER ${DATABASE_USER}

ARG DATABASE_PASS
ENV DATABASE_PASS ${DATABASE_PASS}

ARG DATABASE_HOST
ENV DATABASE_HOST ${DATABASE_HOST}

ARG DATABASE_ROOT_PASS
ENV DATABASE_ROOT_PASS ${DATABASE_ROOT_PASS}

ARG TESTE_ENV
ENV TESTE_ENV ${TESTE_ENV}

EXPOSE 8000

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000"]
