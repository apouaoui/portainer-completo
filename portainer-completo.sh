#!/bin/bash

# NOME: portainer-completo.sh
# OBJETIVO: Instalar Docker, Docker Compose e Portainer CE

echo "=============================="
echo " Instalando Docker e Compose  "
echo "=============================="

# Atualiza pacotes
sudo apt update -y
sudo apt upgrade -y

# Remove versões antigas do Docker se houver
sudo apt remove docker docker-engine docker.io containerd runc -y

# Instala dependências
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Adiciona chave oficial do Docker
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Adiciona repositório do Docker
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza pacotes com novo repositório
sudo apt update -y

# Instala Docker e Compose
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verifica versões
sudo docker --version
sudo docker compose version

echo "=============================="
echo " Instalando Portainer         "
echo "=============================="

# Cria volume para persistência
sudo docker volume create portainer_data

# Sobe container do Portainer
sudo docker run -d \
  --name=portainer \
  --restart=unless-stopped \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce

echo "=============================="
echo " Portainer instalado com sucesso!"
echo " Acesse pelo navegador:"
echo " -> https://SEU_IP:9443 (Seguro HTTPS)"
echo " -> http://SEU_IP:9000 (Não seguro HTTP)"
echo "=============================="
