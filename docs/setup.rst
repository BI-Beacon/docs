.. documents how to configura a beacon

Setup BI-Beacon via Wifi
========================

You can setup a BI-Beacon using a mobile or desktop device that connects to the Beacons own setup web page.

1. Plugin your BI-Beacon (it turns blue)
2. Disable mobile network (if on mobile device)
3. Wait up to 30 seconds until BI-Beacon starts shifting in slowly between blue and green (it means setup mode is active)
4. Connect to WiFi “BI-Beacon-A1B2C3” (A1B2C3 is unique for your lamp)
5. Browse to BI-Beacon’s Setup Page: http://192.168.4.1
6. Enter details

   a. WiFi name: the WiFi lamp should connect to (SSID)
   b. WiFi password: password of WiFi to connect to (empty if no password)
   c. Systemid: the string identifier controlling the beacon state (see :ref:`ref_api`)

7. Wait for green

   a. It will first turn blue which means it is connecting to router
   b. Then it will turn purple which means it is connecting to state server
   c. Then it will turn green when connected


Setup BI-Beacon via USB
=======================

You can also setup a BI-Beacon using a USB data cable, however requires that you are
on a Linux machine with a user in the dialout group.

Clone the cli repo (see :ref:`ref_repositories`).

Then, in a terminal of your choice,

   $ python config_via_usb.py <ssid> <password> <systemid>

