FROM alpine:latest

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip python3-dev gcc musl-dev make
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser -D app
USER app

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD uvicorn --host 0.0.0.0 --port $PORT main:app
