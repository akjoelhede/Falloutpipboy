# Fallout3Terminal

This project is based off https://github.com/fohtla/Fallout3Terminal?tab=readme-ov-file and was the first inspiration. This version is altered to be used in the dnd universe with a retro futuristic feeling.

# REQUIREMENTS

You must have the following:

* Linux based or MacOS operating system
* The following packages installed:
    * pv
    * cool-retro-term
    * sox

This has not been tested on Windows or *BSD operating systems.

# Download and run Fallout3Terminal in Linux

To run this script clone this repository, make "terminalscript" an executable , and run `cool-retro-term` as follows:

```bash
git clone https://github.com/akjoelhede/Falloutpipboy.git
chmod +x $HOME/Fallout3Terminal/terminalscript
cool-retro-term --fullscreen --noclose -e bash $HOME/Documents/Falloutpipboy/terminalscript
```

You can also enter that command in your startup manager, as well as make launcher with it!
