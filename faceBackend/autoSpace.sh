#!/bin/bash
while true; do
  bash -c 'echo " " >> /alipex/face/src/web/faces.py'
  sleep 20

  sed -i '${/^[[:space:]]*$/d}' /alipex/face/src/web/faces.py
  sleep 20
done
