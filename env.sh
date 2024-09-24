export YQ=$(which yq)
export OC=$(which oc)
export WATCH=$(which watch)
export PODMAN=$(which podman)
export CURL=$(which curl)
export KUBECONFIG=$(pwd)/kubeconfig
export AWS=$(which aws)
export CONFIG=$(pwd)/config.yaml
export BASE64=$(which base64)

[ ! -f $CONFIG ] && echo "config file not found, please add it and try again" && exit 1
[ ! -f $KUBECONFIG ] && echo "kubeconfig not found in folder, please run login.sh script"
[ -f $KUBECONFIG ] && chmod 777 $KUBECONFIG
[ -z $WATCH ] && echo "watch not found or not installed" && exit 1
[ -z $OC ] && echo "oc (ocp cli) not found or not installed" && exit 1
[ -z $YQ ] && echo "yq (yaml manipulation cli) not found or not installed" && exit 1
[ -z $CURL ] && echo "curl not found or not installed" && exit 1
[ -z $AWS ] && echo "aws cli not found or not installed" && exit 1
[ -z $BASE64 ] && echo "base64 not found or not installed" && exit 1


export WAIT_DURATION="$(yq ".scenarios.wait-duration" $CONFIG)"
