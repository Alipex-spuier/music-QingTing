FROM spuieralipex/face:v1

ADD . /alipex/face

WORKDIR /alipex/face

ENV PYTHONPATH=$PYTHONPATH:src
ENV FACE_PORT=8084
EXPOSE $FACE_PORT

ENTRYPOINT ["python3"]
CMD ["src/web/faces.py"]
