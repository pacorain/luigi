#!/bin/sh

test -d /private || mkdir /private
touch /private/wg0.key
chmod 600 /private/wg0.key