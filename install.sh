## INSTALLER FOR Shed's useless utils
## THIS SCRIPT DOES NOT HAVE TO BE RUN AS ROOT!
## NOTE THIS ONLY INSTALLS THE PROGRAMS TO THE USER!

echo "This script will install Shed's useless utils in ~/LocalEnv"
echo "If you have the folder ~/LocalEnv its best if you move the contents to another folder as it may overwrite some files if it exists such as init"
echo "And will delete the folder ~/LocalEnv/bin ."
echo -n "Do you want to proceed with this action? [y/N] "
read confirmation
if [ ${confirmation,,} != "y" ]; then
  exit 1
fi
echo "Please wait, preparing to install..."
FILE="$HOME/.bashrc"
STRING="source \$HOME/LocalEnv/init"
grep -q -F "$STRING" "$FILE" && initInBashrc=1 || initInBashrc=0

if ! grep -qF "$LINE" "$FILE"; then
  echo "# THIS HAS TO BE IN THE END OF BASHRC FOR SHED'S USELESS UTILS TO WORK" >> "$FILE"
  echo "$LINE" >> "$FILE"
else
  echo "Init already exists. Not editing bashrc"
fi
if [ ! -d $HOME/LocalEnv ]; then
  mkdir $HOME/LocalEnv
fi
if [ -f $HOME/LocalEnv/init ]; then
  rm $HOME/LocalEnv/init
fi
if [ -d $HOME/LocalEnv/bin ]; then
  rm -rf $HOME/LocalEnv/bin
fi
mkdir $HOME/LocalEnv/bin
initfile="#!/bin/bash
export PATH="${PATH}:$HOME/LocalEnv/bin"
greeter"
echo "$initfile" >> $HOME/LocalEnv/init
wgetfolder="$HOME/LocalEnv/bin"
oldPWD=$PWD
cd $wgetfolder
echo "Downloading files please wait..."
curl -o $wgetfolder/motd "https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/v1.0.0/bin/motd"
curl -o $wgetfolder/greeter "https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/v1.0.0/bin/greeter"
curl -o $wgetfolder/gen-motd "https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/v1.0.0/bin/gen-motd"
curl -o $wgetfolder/hello "https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/v1.0.0/bin/hello"
echo "Changing permission of files, please wait..."
chmod +x $wgetfolder/motd
chmod +x $wgetfolder/greeter
chmod +x $wgetfolder/gen-motd
chmod +x $wgetfolder/hello
chmod +x $HOME/LocalEnv/init
echo "Installation complete!"
cd $oldPWD
