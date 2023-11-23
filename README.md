# umbrel-cloudflared-connector
Controlled connector for Umbrel Cloudflared Tunnel app. 
The image contains the original connector binary from `cloudflare/cloudflared` as well as a simple control loop shell script, 
allowing the [web app](https://github.com/Radiokot/umbrel-cloudflared) to restart the connector and change its configuration (token).

## Environment variables
|Name|Meaning|
|:-|:-|
|`CLOUDFLARED_METRICS_PORT`|Port number to start the `cloudflared` metrics server on. The corresponding value must be set for the web app|
|`CLOUDFLARED_TOKEN_FILE`|Path to a file containing the `cloudflared` tunnel token. The corresponding file must be set for the web app|

## Commands
The control script accepts commands from empty-body HTTP POST requests to port `8018`, although the command can be sent over a pure TCP socket.
The response to all the requests is always `202 Accepted` no matter the content.
**The port `8018` must only be exposed to the internal compose network, it has no access control.**

|Code|HTTP Path|Meaning|
|:-|:-|:-|
|`cfd-start`|`/cfd-start`|Start the tunnel|
|`cfd-stop`|`/cfd-stop`|Stop the tunnel|
|`cfd-restart`|`/cfd-restart`|Restart (stop and start) the tunnel, for example, after changing the token|
