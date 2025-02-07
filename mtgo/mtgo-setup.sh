#!/bin/bash

#------------------------------------------------------------------------
###script to setup a wine prefix then install and run mtgo###
#------------------------------------------------------------------------

#disable all wine debug logs to prevent console spam
export WINEDEBUG=-all
#------------------------------------------------------------------------

###leftovers from debugging###
# enable strict error handling for logging
#set -e

# log file setup
#LOGFILE="mtgo-setup.log"
#exec > >(tee -a "$LOGFILE") 2> >(grep -v fixme | tee -a "$LOGFILE" >&2)
#------------------------------------------------------------------------

#path to MTGO executable
MTGO_EXEC=~/.wine/drive_c/mtgo/mtgo.exe

#function to check if MTGO process is running
is_mtgo_running() {
    ps aux | grep 'MTGO.exe' | grep -v grep > /dev/null
}

#first check if wine prefix is already configured with mtgo installed
if [ -f "$MTGO_EXEC" ]; then

    #make sure mtgo is not already running before launching 	
    if is_mtgo_running; then
        echo "MTGO is already running! Exiting..."
        exit 1
    fi

    echo "MTGO executable found! skipping setup and launching the game"

    #launch mtgo
    cd ~/.wine/drive_c/mtgo
    WINEDEBUG=-all wine mtgo.exe
    echo "### game launched"
    exit 0
fi
#------------------------------------------------------------------------

#if prefix not configured continue with setup
echo "MTGO executable not found. running full wine setup and configuration"

#clean wine prefix
rm -rf ~/.wine
echo "cleaned wine prefix"

#create wine prefix
WINEPREFIX=~/.wine winecfg
echo "made fresh wine prefix using wow64"

#ensure wine registry files created
wineboot --init
echo "wine booted"

#move to wine directory
cd ~/.wine
echo "moved to wine directory"

#download and enable winetricks
curl -O https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
echo "winetricks installed"

#install winetricks dependencies 
winetricks arial32 times32 trebuc32 verdan32
winetricks pptfonts
winetricks corefonts 
winetricks calibri tahoma 
winetricks dotnet48
winetricks win7 sound=pulse
winetricks renderer=gdi
echo "winetricks dependencies installed"

#clean winetricks cache
rm -rf ~/.cache/winetricks
echo "cleaned wine cache"

#download mtgo setup file to wine c drive
mkdir -p ~/.wine/drive_c/mtgo
curl -o ~/.wine/drive_c/mtgo/mtgo.exe "https://mtgo.patch.daybreakgames.com/patch/mtg/live/client/setup.exe?v=15"
echo "downloaded mtgo setup file"

#work around sound crash bug with overrides
winetricks gdiplus=builtin winegstreamer=builtin wmp=builtin
winetricks sound=disabled
wineboot -k
sleep 3
echo "disabled sound with overrides"
#------------------------------------------------------------------------

#move to game file and run mtgo.exe
echo "### setup complete, launching mtgo!"
cd ~/.wine/drive_c/mtgo
WINEDEBUG=-all wine mtgo.exe

