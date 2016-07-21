#!/bin/bash
#
# My thanks to Creationix. This script is almost a verbatim copy of
# the install script for NVM (https://github.com/creationix/nvm).

CDENV_DIR="$HOME/.cdenv"
GITHUB_REPO_URL="https://github.com/croach/cdenv.git"
NENV_RAW_FILE_URL="https://raw.githubusercontent.com/croach/cdenv/master/cdenv.sh"

if ! hash git 2>/dev/null; then
  if [ -d "$CDENV_DIR" ]; then
    echo "=> cdenv is already installed in $CDENV_DIR, trying to update"
    echo -ne "\r=> "
    cd $CDENV_DIR && rm cdenv.sh && curl -O $NENV_RAW_FILE_URL
  else
    # Cloning to $CDENV_DIR
    mkdir "$CDENV_DIR" && cd "$CDENV_DIR" && curl -O $NENV_RAW_FILE_URL
  fi
else
  if [ -d "$CDENV_DIR" ]; then
    echo "=> cdenv is already installed in $CDENV_DIR, trying to update"
    echo -ne "\r=> "
    cd $CDENV_DIR && git pull
  else
    # Cloning to $CDENV_DIR
    git clone $GITHUB_REPO_URL $CDENV_DIR
  fi
fi

# Get the name of the user's current shell
shell="$(basename $SHELL)"

# Detect profile file for the user's shell
if [ -f "$HOME/.${shell}rc" ]; then
  PROFILE="$HOME/.${shell}rc"
elif [ -f "$HOME/.${shell}_profile" ]; then
  PROFILE = "$HOME/.${shell}_profile"
elif [ -f "$HOME/.profile" ]; then
  PROFILE="$HOME/.profile"
fi

SOURCE_STR=$(cat <<EOF
if [[ -f "$HOME/.cdenv/cdenv.sh" ]]; then
  source "$HOME/.cdenv/cdenv.sh"

  # Uncomment the following line if you want virtual environments
  # activated/deactivted as you cd into/out of them.
  # alias cd="_cdenv_cd"

  # Uncomment the following line if you want to try to check for a
  # virtual environment in the current directory (and activate it)
  # whenever a new shell session is created.
  # cdenv activate
fi
EOF
)

if [ -z "$PROFILE" ] || [ ! -f "$PROFILE" ] ; then
  if [ -z $PROFILE ]; then
    echo "=> Profile not found. Tried $HOME/.bash_profile and $HOME/.profile"
  else
    echo "=> Profile $PROFILE not found"
  fi
  echo "=> Run this script again after running the following:"
  echo
  echo "\ttouch $HOME/.profile"
  echo
  echo "-- OR --"
  echo
  echo "=> Append the following line to the correct file yourself"
  echo
  echo "$SOURCE_STR"
  echo
  echo "=> Close and reopen your terminal afterwards to start using cdenv"
  exit
fi

if ! grep -qc 'cdenv.sh' $PROFILE; then
  echo "=> Appending source string to $PROFILE"
  echo "" >> "$PROFILE"
  echo "$SOURCE_STR" >> "$PROFILE"
else
  echo "=> Source string already in $PROFILE"
fi

echo "=> Close and reopen your terminal to start using cdenv"
echo

