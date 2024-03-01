#!/bin/bash

# check if env directory exists
if [ -d ".venv" ]; then
    # if it does, ask, if it really should be deleted
    read -n1 -p "This action will remove the environment. Are you sure? [y,n] " REMOVE_FLAG

    # if it should be deleted, do that, otherwise abort the process
    case $REMOVE_FLAG in
        y|Y) printf "\nRemoving old environment.\n"
             rm -r .venv ;;
        *) printf "\nAborting.\n"
             return 1 ;;
    esac
fi

python3.11 -m venv .venv --prompt qdive

# Activate the virtual environment
# If windows use
if [ "$(expr substr $(uname -s) 1 5)" == "MINGW" ]; then
    source .venv/Scripts/activate
    python.exe -m pip install --upgrade pip
# If linux use
else
    source .venv/bin/activate
    pip install --upgrade pip
fi

pip install --upgrade pip
pip install -r requirements.txt