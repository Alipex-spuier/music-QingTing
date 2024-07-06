sudo docker build -t face:v2 .
sudo docker run -itd --network=host -v ~/face:/alipex/face --name=face face:v2
