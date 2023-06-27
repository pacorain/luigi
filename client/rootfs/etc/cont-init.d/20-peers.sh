#!/command/with-contenv /bin/bash

# Get client public keys from 1Password
#
# This is a really simple solution for now (just storing part of the config file on 1Password),
# but it opens the door for other complex setups.

# This does nothing except copy the file right now
op inject -i /etc/wireguard/wg1.conf.tpl -o /etc/wireguard/wg1.conf -f 

op read op://6akxllxi2gxokxmsfxy5yrouiq/3ocjh6cfeiqim5w53o4apcyczi/notesPlain >> /etc/wireguard/wg1.conf 