# Luigi: Reverse Tunnel Server via Wireguard

Luigi is a reverse proxy and Wireguard server that allows me to expose services on my local network to the internet. 

I use it because I have multiple connections to the internet. It also keeps me from exposing my whole home network to the internet.

## How it works

Luigi has two components: the server and the client.

Luigi server runs in the cloud. It listens for connections from the client, and then forwards incoming connections for certain services to the client using nginx.

Right now, the server assumes the client is on a 10.5.0.0 network, and redirects traffic to specific IP addresses on that network. This is probably not the right way to do it, but it at least works for my setup.

Luigi client runs on my home network. It connects to the server, and tries to maintain that connection if hte network changes. It also runs a Wireguard server that allows me to connect to my home network from anywhere. It also has [Nginx Proxy Manager](https://nginxproxymanager.com/) running, which allows me to easily set up new sites for services running on my home network.

## Deploying

Luigi is deployed using Docker.

For my own purposes, it is pushed to a private Docker registry on DigitalOcean. You will need to use Docker Compose to build the images if you want to run these commands.

### Generating keys

You will first need to generate a private key for both the server and the client. This is done via Wireguard.

To generate a private and public key pair, either install Wireguard or spin up a Docker container:

```bash
docker run -it --rm registry.digitalocean.com/pacorain-homeinfra/luigi-client:latest /bin/bash
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

The Docker image alone is enough to run the server, but you will need to provide a few environment variables. Copy the .env.tmpl file to .env, and update the file. You will need to provide the server's private key, and the client's public key. You can also enable client passthrough, which will allow you to connect to the client's Wireguard server from the server.

Then, start the service with either docker-compose or docker run.

To deploy with Docker:

```bash
docker run -d \
    --name luigi-server \
    --restart unless-stopped \
    --env-file .env \
    --cap-add NET_ADMIN \
    --cap-add SYS_MODULE \
    --privileged \
    -p 51820:51820/udp \
    -p 51821:51821/udp \
    -p 80:80 \
    -p 443:443 \
    registry.digitalocean.com/pacorain-homeinfra/luigi-server:latest
```

To deploy with Docker Compose, copy [server/docker-compose.yml]() to the server, and run `docker-compose up -d`.

### Client

Because the client has multiple services, it is recommended to use Docker Compose. Copy [client/docker-compose.yml]() to the client, as well as .env.tmpl to .env. Update the .env file with the client's private key, the server's public key, and the server's IP address.

Then, run `docker-compose up -d` to start the client.

## TODO

Here are some goals I'd like to accomplish:

- [ ] Use certbot to generate SSL certificates for the server (I will need a plugin for wildcard domains)
- [ ] Add Nginx Proxy Manager and/or authelia to the client
- [ ] Make it easier to add port forwards to non-HTTP services
- [ ] Use a keystore instead of a .env file?
- [ ] Improve networking -- I have lots of IP addresses hard-coded and I'm not sure if it's the best way to do it
