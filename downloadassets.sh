#!/bin/bash
set -e


if [[ -z "$INPUT_GITHUB_TOKEN" ]]; then
  echo "Missing GITHUB TOKEN in the action"
  exit 1
fi


if [[ -z "$GITHUB_REPOSITORY" ]]; then
  echo "Missing GITHUB_REPOSITORY env variable"
  exit 1
fi

OWNER_REPOSITORY=$GITHUB_REPOSITORY
if ! [[ -z ${INPUT_REPOSITORY} ]]; then
  OWNER_REPOSITORY=$INPUT_REPOSITORY;
fi


                        
AUTH="Authorization: token ${INPUT_GITHUB_TOKEN}"
response=$(curl -sH "$AUTH" https://api.github.com/repos/${OWNER_REPOSITORY}/releases/${INPUT_RELEASE})
id=`echo "$response" | jq '.assets[0] .id' |  tr -d '"'`
name=`echo "$response" | jq '.assets[0] .name' |  tr -d '"'`

if [ -z "$id" ]; then
  echo "::set-output name=result::ERROR: version not found $INPUT_RELEASE"
  exit 1;
fi;


GH_ASSET="https://api.github.com/repos/${OWNER_REPOSITORY}/releases/assets/$id"
# download the artifact     
curl -v -L -o "$name" -H "$AUTH" -H 'Accept: application/octet-stream' "$GH_ASSET"
echo "::set-output name=artifact_name::$name"
echo "::set-output name=result::success"