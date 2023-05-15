#!/usr/bin/env bash

server_details="/tmp/server_details_index.yaml"
eval server_details_path=$server_details

declare -A serversArray

lines=$(grep ":" $server_details_path)
currentServer=''

# rewrite the below code to ignore the srv*
# and instead look for the server value inside domain:
# maulund: { production: { server: srv100.wexohosting.com } }
while IFS= read -r line; do
  result=$(echo "$line" | awk -F ':' '{print $1 $2}' | sed 's/ { /-/g' | sed 's/production/prod/g')
  if [[ $result == srv* ]]; then
    currentServer=$result
  else
   serversArray["$result"]="$currentServer"
  fi
done <<< $lines


# add all the found projects to a newline seperated string for fzf
for key in "${!serversArray[@]}"; do
  fzfList+="\n$key"
done

#remove leading newline
fzfList="${fzfList#\\n}"

selectedProject=$(echo -e "$fzfList" | fzf)

if [ -n "$selectedProject" ]; then
  selectedServer="${serversArray[$selectedProject]}"
  if [ -n "$selectedServer" ]; then
    ssh "$selectedServer"
  else
    echo "No server found for the selected project."
    exit
  fi
else
  echo "No projected selected. Exiting"
  exit
fi


