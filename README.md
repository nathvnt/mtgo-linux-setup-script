## Bash script for installing Magic The Gathering Online (MTGO) using Linux <hr/>

This script works to configure a Wine prefix and then install and run the game MTGO using wine-wow64.<br/><br/>
(**WARNING**) Running this will resest any existing wine prefix that is not backed up.


### System Requirements <hr/>

This was tested and developed while using Arch Linux / X11. It should work just fine on other Linux distributions with minimal adjustments.<br/>

System should have wine-wow64 installed along with Wine specific dependencies prior to running setup script.<br/>

Information about Wine dependencies related to Arch Linux can be found here: [Arch Wiki](https://wiki.archlinux.org/title/Wine) <br/>

Otherwise, 4cpu cores and stable internet connection should suffice in regards to hardware requirements. 

### Desktop Entry File <hr/>

The mtgo-desktop.txt file is a template for creating a Desktop Entry File that allows the script to appear as a normal application with an icon in the task manager GUI.<br/><br/>
This file needs to be modified with correct paths to mtgo setup script and mtgo icon then saved to ~/.local/share/applications .<br/>





