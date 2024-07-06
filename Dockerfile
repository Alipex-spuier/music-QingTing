FROM spuieralipex/face:v1

ADD . /alipex/face

WORKDIR /alipex/face

ENTRYPOINT ["sh", "-c", "sh autoSpace.sh & python3 src/web/faces.py"]
