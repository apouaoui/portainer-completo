```
git clone https://github.com/apouaoui/portainer-completo.git
cd portainer-completo
chmod +X portainer-completo.sh
bash portainer-completo.sh
echo finalizado
```

Esse script instala:
- docker
- docker compose
- portainer


Ele tbm nao expoe a porta, mas eh necessario ver qual o ip que ele ta usando.
Use o Docker ps pra ver o nome e portas, e o docker inspect <name> para ver o ip interno.