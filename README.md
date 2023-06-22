# Luigi: Reverse Tunnel Server via Wireguard

Luigi is a reverse proxy and Wireguard server that allows me to expose services on my local network to the internet. 

I use it because I have multiple connections to the internet. It also keeps me from exposing my whole home network to the internet.

## How it works

Luigi has two components: the server and the client.

Luigi server runs in the cloud. It is a reverse proxy that listens for incoming connections on a public IP address. When it receives a connection, it forwards the connection to the client.

Luigi client runs on my home network. When the connection to the server is established, it serves a reverse proxy that forwards connections to my services. It also runs a Wireguard server that allows me to connect to my home network from anywhere.

## Deploying

Luigi is deployed using Docker.

You will first need to generate a private key for both the server and the client. 

To generate a private and public key pair, either install Wireguard or spin up a Docker container:

```bash
docker-compose run -it luigi /bin/bash
```

Then, generate the key pair (remember to do this twice, once for the server and once for the client):

```bash
cd /tmp
wg genkey | tee privatekey | wg pubkey > publickey
cat privatekey
cat publickey
rm privatekey publickey
```

### Server

To deploy the server, copy the environment file `.env.example` to `.env`, and update the values.

You will need to provide the private key for the server, and the public key for the client.

You can also adjust the port to host the server on (you will also need to adjust this on the client).

WIP: Finally, you can enable client passthrough. This will allow you to connect to the client as a Wireguard peer, and access the services on the client's network (i.e. my home network). To do so, set `CLIENT_PASSTHROUGH_ENABLED` to `true`.

Once enabled, nginx will forward traffic to the `CLIENT_PASSTHROUGH_PORT` (default 51821) to the client that has connected.


### Client

WIP

## TODO

Here are some goals I'd like to accomplish:

- [ ] Use certbot to generate SSL certificates for the server (I will need a plugin for wildcard domains)
- [ ] Add Nginx Proxy Manager and/or authelia to the client
- [ ] Make it easier to add port forwards to non-HTTP services
- [ ] Use a keystore instead of a .env file?
