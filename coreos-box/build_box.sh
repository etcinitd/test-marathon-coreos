#!/bin/bash

set -e

rm -rf builds/ || true
packer build coreos.json && vagrant box add --force test/coreos ./builds/virtualbox/coreos-alpha.box
