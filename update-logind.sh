#! /usr/bin/env bash
#
# Update /etc/systemd/logind.conf

wget "https://raw.githubusercontent.com/saildata/saildata-linux-scripts/c189dbbb65afc7eb2b7aa1aaf6bd44c33d9614ff/config/logind.conf"

sudo mv /etc/systemd/logind.conf /etc/systemd/logind.conf.original
sudo mv ~/logind.conf /etc/systemd/logind.conf

sudo chown root:root /etc/systemd/logind.conf

sudo reboot
