read -p "Is Linux jq installed (y/n)? " -n 1 -r
echo # Move to new line

if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Please install Linux jq to parse the params.json file. Alternatively, "\
      "run the AWS CLI command in this file manually."
    exit 1
else
    read -s -p "Cloudflare Turnstile secret key: " TURNSTILE_SECRET_KEY
    PROJECT_NAME=$(jq -r '.[] | select(.ParameterKey=="ProjectName") | .ParameterValue' params.json)
    
    echo "\nSaving secret key to SSM at: /cloudflare/${PROJECT_NAME}/TURNSTILE_SECRET_KEY"
    aws ssm put-parameter \
    --name "/cloudflare/${PROJECT_NAME}/TURNSTILE_SECRET_KEY" \
    --description "Cloudflare Turnstile secret key to protect ${PROJECT_NAME}" \
    --value ${TURNSTILE_SECRET_KEY} \
    --type "SecureString" \
    --overwrite
fi
