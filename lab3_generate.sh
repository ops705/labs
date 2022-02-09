#!/bin/bash

# Make certain user isn't logged in as root
if [ $USER = "root" ]
then
  echo "Note: Do not run this program logged in as root. Log in to your local user and run again."
  exit 1
fi

echo "Running Lab 3 - Investigation 2 script..."

mkdir ~/tmp
echo "$(date) 536914d707b723dd3c13b320e823b7b5" > ~/tmp/file13
echo "$(date) 88e4d6e3f8009bdd4c956227e679c48a" > ~/tmp/file14
echo "$(date) 7d798c43d8c19e188b51da8ec165eda2" > ~/tmp/file15
echo "$(date) 84b5ba8a1f21dd29040c27295e9a38d4" > ~/tmp/file16
echo "$(date) a9629852cbaafa55fbaadafb2cd84581" > ~/tmp/file17

echo "Run complete. Please continue to Step 4."
