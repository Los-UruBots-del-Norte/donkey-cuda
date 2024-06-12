# DonkeyCar Trainer with CUDA and cudnn
This starts a container with a Jupyter Lab server which provides a ready-to-use script for training a Donkey Car pilot. Instructions are provided in the ipynb.

### Requirements
- Docker
- docker-compose


### How to use
1 - Check your docker-compose version

```bash
docker-compose -v
```
2 - You need to have installed a version 1.29.2 or higher.
Can you update your version running this command:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

3 - On a terminal in the same folder run:

```bash
docker-compose up
```
OR:

```bash
docker compose up
```

4 - Access http://localhost:8888 for Jupyter Lab.

5 - Open the Donkey.ipynb file and run the cells.

### Credits
- Chris
- Seba
- Urubots
