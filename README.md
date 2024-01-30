ToonSoftwareCollective HomeAssistant

This application is built to integrate some Home Assistant functionalities in Toon thermostat (available in The Netherlands). 
A rooted Toon is required to be able to use this application;

An easy rooting method, by software with a USB stick:
https://github.com/ToonSoftwareCollective/Root-A-Toon-USB-Stick

An alternative rooting method, by hardware with a Raspberry Pi or USB Blaster:
https://github.com/martenjacobs/ToonRooter


This application enable some basic key features on the Toon thermostat.  
These integrations can be used;

    8 sensors
    4 scenes
    5 switches/input_booleans/lights
    1 input_number (max 6 options)
    1 custom alarm

The HomeAssistant tile will show the first 3 configured sensors. 

If you don't enter an alarm object in the tile, this space will be left empty.


How to install:

Install the homeassistant app through the TSC appstore.


How to use:

You need to manually generate a long-lived access token from your HomeAssistant setup and add this token to the "homeassistant.token.txt" file on your Toon. 
This file is located at /mnt/data/tsc/homeassistant.token.txt. 
To generate a token navigate to your user profile in the HomeAssistant gui and scroll down to the bottom where you see "Long-Lived Access Tokens" (and press generate). 
The password textbox in the Toon HomeAssistant app can be left empty.

If you still use a password to authenticate with Home Assistant choose 'Legacy pass' on the configuration page of the Toon app and enter your password in the textbox.

If you use SSL and Home Assistant version 0.73.0 or higher make sure to set 'ssl_profile: intermediate' in your Home Assistants configuration.yaml 
(in the http section; https://www.home-assistant.io/components/http/). This is not needed when using the Long-Lived Access token authentication.


Restart the GUI of the Toon using TSC Settings, or run this command by SSH to restart Toons user interface
      killall qt-gui
    
Add the app called "homeassistant" to a new tile

When starting the app for the first time the screen will be pretty much empty, click on "Instellingen" to configure the app
    
On the configuration page enter the Home Assistant connection info and entity_id's you want to be shown (press the left/right arrows to scroll through sensors/scenes/switches)
Press "Opslaan" to save your configuration. If all is well the information will be retrieved from your Home Assistant system

Friendly names configured in your Home Assistant config are used to show the objects on the Toon. So make sure all items you want Toon to show have a friendly name.

All objects are refreshed every minute (because of the sensor info located on the tile)
Upon opening the app, pressing the "Opslaan" button on the configuration screen and by pressing the Home Assistant image on the app home screen (top right).
