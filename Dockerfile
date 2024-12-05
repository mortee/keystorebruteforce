FROM python:2-alpine AS base

FROM base AS build

RUN apk update
RUN apk add alpine-sdk

# see https://pythonspeed.com/articles/multi-stage-docker-python/ Solution #1
WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

FROM base

WORKDIR /usr/src/app
COPY keystorebrute.py entrypoint.sh dictionary.txt OIDs.txt keystore1 keystore2 ks.list .
COPY --from=build /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
CMD ["--keystore-list=ks.list", "--dictionary=dictionary.txt"]
