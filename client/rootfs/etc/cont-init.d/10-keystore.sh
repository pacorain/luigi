#!/bin/bash

test -d /private || mkdir /private
touch /private/wg1.key
chmod 600 /private/wg1.key