#!/usr/bin/env bash

set -e

function _usage {
  cat <<END

Deploys krkn-visualize, a Grafana dashboard, to your Kubernetes cluster.
Automates setup of Elasticsearch and optional Prometheus datasources.

For more information see: https://krkn-chaos.dev/docs/krknctl/usage/#visualize-flags

Usage: $(basename "${0}") [-e <es_url>] [-u <es_username>] [-s <es_password>]
                          [-P <prometheus_url>] [-b <bearer_token>]
                          [-n <namespace>] [-p <grafana_password>]
                          [-k <kubectl_cmd>] [-c <kubeconfig>] [-d] [-h]

  -e <es_url>        : (E)lasticsearch URL (required)

  -u <es_username>   : Elasticsearch (u)sername

  -s <es_password>   : Elasticsearch pa(s)sword

  -P <prometheus_url>: (P)rometheus datasource URL (optional)

  -b <bearer_token>  : Prometheus (b)earer token (optional)

  -n <namespace>     : Target (n)amespace (defaults to 'krkn-visualize')

  -p <grafana_pass>  : Grafana admin (p)assword (required)

  -k <kubectl_cmd>   : (k)ubectl binary to use (defaults to 'kubectl', use 'oc' for OpenShift)

  -c <kubeconfig>    : Path to kube(c)onfig file (defaults to '~/.kube/config')

  -d                 : (D)elete an existing deployment

  -h                 : Help

END
}

# Defaults
namespace='krkn-visualize'
kubectl_cmd='kubectl'
kubeconfig="${HOME}/.kube/config"

# Capture and act on command options
while getopts ":e:u:s:P:b:n:p:k:c:dh" opt; do
  case ${opt} in
    e)
      es_url="${OPTARG}"
      ;;
    u)
      es_username="${OPTARG}"
      ;;
    s)
      es_password="${OPTARG}"
      ;;
    P)
      prometheus_url="${OPTARG}"
      ;;
    b)
      bearer_token="${OPTARG}"
      ;;
    n)
      namespace="${OPTARG}"
      ;;
    p)
      grafana_password="${OPTARG}"
      ;;
    k)
      kubectl_cmd="${OPTARG}"
      ;;
    c)
      kubeconfig="${OPTARG}"
      ;;
    d)
      delete=true
      ;;
    h)
      _usage
      exit 0
      ;;
    \?)
      echo -e "\033[31mERROR: Invalid option -${OPTARG}\033[0m" >&2
      _usage
      exit 1
      ;;
    :)
      echo -e "\033[31mERROR: Option -${OPTARG} requires an argument.\033[0m" >&2
      _usage
      exit 1
      ;;
  esac
done

if [[ $delete ]]; then
  echo -e "\033[32mRemoving krkn-visualize deployment...\033[0m"
  krknctl visualize --delete --namespace "$namespace" --kubectl "$kubectl_cmd" --kubeconfig "$kubeconfig"
  echo -e "\033[32mDeployment deleted!\033[0m"
  exit 0
fi

if [[ -z "$es_url" ]]; then
  echo -e "\033[31mERROR: Elasticsearch URL (-e) is required.\033[0m" >&2
  _usage
  exit 1
fi

if [[ -z "$grafana_password" ]]; then
  echo -e "\033[31mERROR: Grafana password (-p) is required.\033[0m" >&2
  _usage
  exit 1
fi

# Build krknctl visualize command
cmd=(krknctl visualize
  --es-url "$es_url"
  --namespace "$namespace"
  --grafana-password "$grafana_password"
  --kubectl "$kubectl_cmd"
  --kubeconfig "$kubeconfig"
)

[[ -n "$es_username" ]]    && cmd+=(--es-username "$es_username")
[[ -n "$es_password" ]]    && cmd+=(--es-password "$es_password")
[[ -n "$prometheus_url" ]] && cmd+=(--prometheus-url "$prometheus_url")
[[ -n "$bearer_token" ]]   && cmd+=(--prometheus-bearer-token "$bearer_token")

echo -e "\033[32mDeploying krkn-visualize...\033[0m"
"${cmd[@]}"
echo -e "\033[32mDone! Grafana is available in namespace: $namespace\033[0m"
