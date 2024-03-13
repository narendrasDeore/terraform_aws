#!/bin/bash
sudo apt update
sudo apt install git -y
sudo git clone https://github.com/narendrasDeore/flaskapp_server_info.git
cd flaskapp_server_info/
sudo apt install pip -y
sudo pip install flask 
sudo python3 app.py