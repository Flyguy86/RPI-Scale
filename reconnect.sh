#!/bin/bash
if ! ping -c 3 www.google.com;
then
ifdown wlan0; ifup wlan0
fi

