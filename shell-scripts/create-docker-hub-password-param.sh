read -s -p "Docker Hub password: " DOCKER_HUB_PASSWORD

aws ssm put-parameter \
    --name "/docker/DOCKER_HUB_PASSWORD" \
    --description "Password for Docker Hub" \
    --value ${DOCKER_HUB_PASSWORD} \
    --type "SecureString"