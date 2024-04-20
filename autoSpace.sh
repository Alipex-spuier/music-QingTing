#!/bin/bash
# toggle_space.sh

while true; do
  # 第一个命令：添加空格
  sudo bash -c 'echo " " >> /home/ubuntu/face/src/web/faces.py'
  sleep 10  # 等待10秒

  # 第二个命令：删除空格
  sudo sed -i '${/^[[:space:]]*$/d}' /home/ubuntu/face/src/web/faces.py
  sleep 10  # 等待10秒
done
