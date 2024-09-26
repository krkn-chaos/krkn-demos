# krkn-demos

This is a collection of scripts to easily demo krkn-hub scenarios. All the scenarios, cluster and cloud settings are centralized in the file `config.yaml` from where all the scripts gather the informations needed to run. The platform currently supported by the scripts is Openshift, if needed, without too much
effort they could be ported to Kubernetes as well.

There are three categories of scripts:
- `run` scripts
    - the scripts needed to run the scenarios
- `check` scripts
    - the scripts needed to show live the effects of the respective scenarios
- service scripts
    - `login.sh`
        - performs the login in the OCP cluster
    - `deploy_dittybopper.sh`
        - deploys in the cluster an example workload that can be targeted from different scenario (which settings are the default in the config.yaml)

## requirements 
> [!WARNING]
> These script are currently compatible with Linux. MacOs users need to modify podman commands adding each environment variable as an argument of the podman command since the `--env-host` option is not supported on this platform.

To run these scripts, the following tools must be installed and available in the `$PATH`:

- `yq` yaml manipulation cli [GitHub repo](https://github.com/mikefarah/yq) 
- `oc` ocp CLI [[GitHub repo]](https://github.com/openshift/oc)
- `watch` [[man page]](https://ss64.com/bash/watch.html)
- `podman` containerization platform by RedHat [[website](https://podman.io)]
- `curl` command line http client [[GitHub repo](https://github.com/curl/curl)]
- `aws` Amazon Webservice CLI tool [[GitHub repo](https://github.com/aws/aws-cli)]
- `base64` base 64 encoder/decoder [[man page](https://ss64.com/bash/base64.html)]

> [!TIP]  
> For a better demo experience, it is highly recommended to install `tmux` [[GitHub repo](https://github.com/tmux/tmux)] and use the vertical or horizontal split to run both the `run` and `check` scripts simultaneously. To do this, start `tmux`, then press `ctrl + b`, followed by `%` to split the screen vertically, or `"` to split it horizontally. To navigate between panes, use `ctrl + b` and the appropriate arrow key.


## cluster login

To login in the cluster the `login.sh` can be used. It supports both token and username/password login. To set the required parameters refer to the `ocp` section in the `config.yaml`.
If the login succeeds a `kubeconfig` file will be written in the same folder.

> [!NOTE]  
> If a token value is provided, the username and password will be ignored. Ensure you set only one option and leave the other blank.


## dittybopper deployment

Dittybopper is a comprehensive Prometheus/Grafana distribution that can be deployed on OpenShift, and is frequently used as the target for our pod and service disruption scenarios. To deploy it on the cluster, after successfully logging in, simply run the `deploy_dittybopper.sh` script. Once the workload has been deployed and is ready, the service URL will be displayed and can be configured in the `config.yaml` file under the various `service-url` settings for use by the check scripts. 

All pod and service disruption scenarios are already configured to target this workload, so if it suits your demo, no further adjustments are necessary.

## config.yaml

Each script gathers its parameters from this file, which should be considered the sole source for configuring scenario settings. The file is organized into the following sections:

### `ocp`
Openshift credentials and API endpoint
### `aws`
AWS credentials and region
### `scenarios`
It includes global settings for the scenario, along with a sub-section containing scenario-specific configurations:
- `app-outage`
- `node-outage`
- `pod-scenario`
- `pvc-scenario`
- `service-hijacking`
- `zone-outage`

For an explanation of the specific scenario parameters, please refer to the [available scenarios](#available-scenarios) section below.

Some scenario-specific sub-sections include a `check` section, which is intended to hold parameters required for the corresponding `check` script to function. For example, the `check` section in the `service-hijacking` scenario contains the external URL of the target service, allowing real-time display of the hijacking results in the HTTP response.


## available scenarios

The currently available scenarios, along with their corresponding check scripts, are:
- [Application Outages](https://github.com/krkn-chaos/krkn-hub/blob/main/docs/application-outages.md) (`run_app_outage.sh`, `check_app_outage.sh`)
- [Node Failures](https://github.com/krkn-chaos/krkn-hub/blob/main/docs/node-scenarios.md) (`run_master_node_outage.sh`, `check_master_node_outage.sh`)
- [Pod Failures](https://github.com/krkn-chaos/krkn-hub/blob/main/docs/pod-scenarios.md) (`run_pod_scenarios.sh`, `run_pod_scenarios.sh`)
- [PVC Disk Fill](https://github.com/krkn-chaos/krkn-hub/blob/main/docs/pvc-scenarios.md) (`run_pvc_scenario.sh`, `check_pvc_scenario.sh`)
- [Service Hijacking](https://github.com/krkn-chaos/krkn-hub/blob/main/docs/service-hijacking.md) (`run_service_hijacking.sh`, `check_service_hijacking.sh`)
- [Zone Outages](https://github.com/krkn-chaos/krkn-hub/blob/main/docs/zone-outages.md) (`run_zone_outage.sh`, `check_zone_outage.sh`)


## documentation

These scripts serve as an example of how to run [Krkn-hub](https://github.com/krkn-chaos/krkn-hub) scenarios in an automated and reproducible manner. Feel free to open a PR with your suggestions for additional scenarios or use cases.

For a complete overview of our chaos scenarios, please refer to our [chaos testing guide](https://krkn-chaos.github.io/krkn/), the [Krkn GitHub repository](https://github.com/krkn-chaos/krkn), the [Krkn-hub GitHub repository](https://github.com/krkn-chaos/krkn-hub), and the [Krkn website](https://krkn-chaos.dev).

If you'd like to get in touch with the team or just say hello 👋, you can find us on the [Kubernetes Slack workspace](https://kubernetes.slack.com) in the `#krkn` channel.

And now, __release the Krkn!__


