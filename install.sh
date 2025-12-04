## INSTALLER FOR Shed's useless utils
## THIS SCRIPT DOES NOT HAVE TO BE RUN AS ROOT!

echo "This script will install Shed's useless utils in ~/LocalEnv"
echo "If you have the folder ~/LocalEnv its best if you move the contents to another folder as it may overwrite some files if it exists such as init"
echo "And will delete the folder ~/LocalEnv/bin ."
echo "Do you want to proceed with this action? [y/N] "
read confirmation
if [ ${confirmation,,} != "y"]; then
  exit 1
fi
echo "Please wait, preparing to install..."
grep -q -F "$STRING" "$FILE" && initInBashrc=1 || initInBashrc=0

if [ $initInBashrc -eq 0 ]; then
  echo "# THIS HAS TO BE IN THE END OF BASHRC FOR SHED'S USELESS UTILS TO WORK" >> $HOME/.bashrc
  echo "source $HOME/LocalEnv/init"
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
$initfile="#!/bin/bash
export PATH="${PATH}:$HOME/LocalEnv/bin"
greeter"
echo $initfile >> $HOME/LocalEnv/init
$wgetfolder="$HOME/LocalEnv/bin"
echo "Downloading files please wait..."
wget --directory-prefix=$wgetfolder https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/main/bin/motd
wget --directory-prefix=$wgetfolder https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/main/bin/greeter
wget --directory-prefix=$wgetfolder https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/main/bin/gen-motd
wget --directory-prefix=$wgetfolder https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/main/bin/hello
echo "Changing permission of files, please wait..."
chmod +x $wgetfolder/motd
chmod +x $wgetfolder/greeter
chmod +x $wgetfolder/gen-motd
chmod +x $wgetfolder/hello
echo "Installation complete!"
