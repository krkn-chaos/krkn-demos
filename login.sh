source ./env.sh

export OCP_USERNAME="$(yq ".ocp.username" $CONFIG)"
export OCP_PASSWORD="$(yq ".ocp.password" $CONFIG)"
export OCP_TOKEN="$(yq ".ocp.token" $CONFIG)"
export OCP_API_URL="$(yq ".ocp.api-url" $CONFIG)"

[ -z $OCP_API_URL ] && echo "please set ocp api url and try again" && exit 1
[ -z $OCP_USERNAME ] && [ -z $OCP_PASSWORD ] && [ -z $OCP_TOKEN ] && echo "please set ocp username/password or token in config.yaml and retry" && exit 1 

if [ ! -z $OCP_TOKEN ]; then
    $OC login --insecure-skip-tls-verify --token=$OCP_TOKEN --server=$OCP_API_URL
elif [ ! -z $OCP_USERNAME ] && [ ! -z $OCP_PASSWORD ]; then
    $OC login --insecure-skip-tls-verify -u "$OCP_USERNAME" -p "$OCP_PASSWORD" $OCP_API_URL
fi