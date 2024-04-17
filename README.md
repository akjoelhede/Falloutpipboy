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

Thanks to gitHub user iFloris, there are now instructions to run this on MacOS! Read on below.

# Download and run Fallout3Terminal in Linux

To run this script clone this repository, make "terminalscript" an executable , and run `cool-retro-term` as follows:

```bash
git clone https://github.com/akjoelhede/Falloutpipboy.git
chmod +x $HOME/Fallout3Terminal/terminalscript
cool-retro-term --fullscreen --noclose -e bash $HOME/Fallout3Terminal/terminalscript
```

You can also enter that command in your startup manager, as well as make launcher with it!

# Download and Run Fallout3Terminal on MacOS

 ( Instructions provided by user iFloris! )

* Have homebrew installed
   * Run the following:
```
brew install sox pv
brew install --cask cool-retro-term
git clone https://github.com/akjoelhede/Falloutpipboy.git
/Applications/cool-retro-term.app/Contents/MacOS/cool-retro-term --fullscreen --noclose -e bash $HOME/Fallout3Terminal/terminalscript
```
