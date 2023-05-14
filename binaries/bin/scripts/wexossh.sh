#!/usr/bin/env bash

#server_details="~/bin/scripts/server_details_index.yaml"
server_details="/tmp/server_details_index.yaml"
eval server_details_path=$server_details

servers=($(yq 'keys' $server_details_path | sed 's/- //g'))
declare -A myArray

for server in "${servers[@]}"; do
  projects=($(yq ".[\"$server\"] | to_entries | .[].key" "$server_details_path"))
  for project in "${projects[@]}"; do
    env=$(yq ".[\"$server\"].$project | to_entries | .[].key" "$server_details_path" | sed 's/production/prod/g')
    test="$project-$env"
    strippedServer=$(echo "$server" | sed 's/\..*//')
    myArray["$test"]="$strippedServer"
  done
done

fzfList=""
for key in "${!myArray[@]}"; do
  value="${myArray[$key]}"
  #echo "Key: $key, Value: $value"
  fzfList+="\n$key"
done
#remove leading newline
fzfList="${fzfList#\\n}"

selectedProject=$(echo -e "$fzfList" | fzf)
selectedServer="${myArray[$selectedProject]}"

if [ -n "$selectedServer" ]; then
  ssh "$selectedServer"
else
  echo "No server found for the selected project."
fi
