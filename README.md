sudo docker build -t face:v2 .
sudo docker run --network=host --name=face -itd face:v2
