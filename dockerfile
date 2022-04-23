FROM alpine:3.14

MAINTAINER Dima <dimitry.vlasov@gmail.com>

RUN apk update && apk add \
    python3 \
    py-pip && \
    pip install Flask

COPY . /web-app

WORKDIR /web-app

ENV FLASK_APP=js_example

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
