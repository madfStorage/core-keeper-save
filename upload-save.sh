#!/bin/bash

# Lista dos nomes dos containers
CONTAINERS=("beginner-server_begginer-core-keeper_1" "secondary-server_secondary-core-keeper_1")  # Altere os nomes conforme necessário
# Caminho do arquivo dentro dos containers
SOURCE_PATH="/home/steam/core-keeper-data/worlds/0.world.gzip"
# Diretório de destino no host
BASE_DESTINATION_PATH="./worlds/"

# Loop através da lista de containers
for CONTAINER_NAME in "${CONTAINERS[@]}"; do
    echo "Copiando de $CONTAINER_NAME..."
    
    # Cria o diretório de destino para o container, se não existir
    DESTINATION_PATH="$BASE_DESTINATION_PATH/$CONTAINER_NAME"
    mkdir -p "$DESTINATION_PATH"

    # Copia o arquivo do container para o diretório de destino
    docker cp "$CONTAINER_NAME:$SOURCE_PATH" "$DESTINATION_PATH"

    # Verifica se a cópia foi bem-sucedida
    if [ $? -eq 0 ]; then
        echo "Arquivo copiado com sucesso de $CONTAINER_NAME para $DESTINATION_PATH"
        git add . 
        git commit -m "save updated"
        git push
    else
        echo "Erro ao copiar o arquivo de $CONTAINER_NAME."
    fi
done
