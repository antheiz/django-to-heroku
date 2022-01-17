#Grab the latest alpine image
FROM alpine:latest

# Install python and pip
RUN apk add --no-cache --update python3 py3-pip bash
COPY requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
COPY . /src/src/mydjangoapp/
WORKDIR /src/src/mydjangoapp

# Expose is NOT supported by Heroku
EXPOSE 8000

# Run the image as a non-root user
RUN adduser -D antheiz
USER antheiz

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:8000 myproject.wsgi 

