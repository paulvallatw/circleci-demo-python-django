FROM python:3-alpine

WORKDIR /usr/src/app

COPY requirements.txt .

RUN apk update && \
 apk add postgresql-libs && \
 apk add --virtual .build-deps gcc musl-dev postgresql-dev && \
 python3 -m pip install -r requirements.txt --no-cache-dir && \
 apk --purge del .build-deps

COPY . .
CMD ["gunicorn", "locallibrary.wsgi", "--log-file", "-", "--bind", "0.0.0.0:8080"]
