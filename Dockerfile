FROM python:3.9-alpine as builder
RUN apk --update add build-base libffi-dev cargo patchelf
ADD ./src/requirements.txt /requirements.txt
RUN pip install virtualenv
RUN virtualenv /venv
RUN /venv/bin/pip install -r /requirements.txt


FROM python:3.9-alpine as main

EXPOSE 8000

COPY --from=builder /venv /venv
COPY ./src /src

WORKDIR /src

ENV PYTHONPATH=$PYTHONPATH:/src
RUN adduser -D -u 1001 -g api api
USER api

ENTRYPOINT ["/venv/bin/uvicorn"]
CMD ["main:app", "--host", "0.0.0.0", "--port", "8000"]
