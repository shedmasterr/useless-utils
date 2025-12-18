## INSTALLER FOR Shed's useless utils
## THIS SCRIPT DOES NOT HAVE TO BE RUN AS ROOT!
## NOTE THIS ONLY INSTALLS THE PROGRAMS TO THE USER!

$BRANCH="v1.0.1"
$DLPREFIX="https://raw.githubusercontent.com/shedmasterr/useless-utils/refs/heads/${BRANCH}"
$PREFIX="\$HOME/LocalEnv"
dl(){
curl -o ${PREFIX}/${1} "${DLPREFIX}/${1}"
chmod +x ${PREFIX}/${1}
}

echo "This script will install Shed's useless utils in ~/LocalEnv"
echo "If you have the folder ~/LocalEnv its best if you move the contents to another folder as it may overwrite some files if it exists such as init"
echo "And will delete the folder ~/LocalEnv/bin ."
echo -n "Do you want to proceed with this action? [y/N] "
read confirmation
if [ ${confirmation,,} != "y" ]; then
  exit 1
fi
echo "Please wait, preparing to install..."
LINE="source \$HOME/LocalEnv/init"
FILE="$HOME/.bashrc"

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
echo "Downloading files please wait..."
dl "bin/motd"
dl "bin/greeter"
dl "bin/gen-motd"
dl "bin/hello"
echo "Installation complete!"
cd $oldPWD
