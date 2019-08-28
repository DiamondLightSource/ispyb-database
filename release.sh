#!/bin/bash

# Script to make a release from code currently in the repo if none exists for
# the current schema version.

# Some code borrowed from Stefan Buck's gist file at:
# https://gist.github.com/stefanbuck/ce788fee19ab6eb0b4447a85fc99f447

# Author: Karl Levik

set -e

function version { echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }'; }

# Define variables.
github_api_token=`cat .github-api-token`
owner=DiamondLightSource
repo=ispyb-database
db="ispyb_build"
schema_version=`mysql --defaults-file=.my.cnf -D $db --skip-column-names --silent --raw -e "SELECT value FROM AdminVar WHERE name = 'schemaVersion';"`
tag=v${schema_version}
archive=./dist/ispyb-database-${schema_version}.tar.gz
filename=${archive}
GH_API="https://api.github.com"
GH_REPO="${GH_API}/repos/${owner}/${repo}"
GH_RELEASES="${GH_REPO}/releases"
GH_TAGS="${GH_REPO}/releases/tags/${tag}"
AUTH="Authorization: token ${github_api_token}"

# Get most recent tag from repo, convert to release number
released_version=`git describe --tags`
released_version=${released_version%%-*}
released_version=`echo ${released_version} | sed 's/^v//'`

# Make sure schema_version is higher than repo_version
if [ $(version ${schema_version}) -le $(version ${released_version}) ]; then
  echo "ERROR: Schema version ${schema_version} <= most recently released version ${released_version}"
  exit 1
fi

echo "Creating archive file"
mkdir -p dist
tar cvfz ${archive} build.sh grants/ispyb_*.sql schema/*.sql schema/updates/*.sql

echo "Creating tag v${schema_version}"
git tag -a v${schema_version} -m v${schema_version}
git push origin v${schema_version}

echo "Creating release against the tag"

# Validate token
curl -o /dev/null -sH "$AUTH" $GH_REPO || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

# Create release
curl -d '{"tag_name":"'$tag'", "target_commitish":"master", "name":"'$tag'", "body":"Files required for installing or upgrading to this version", "draft":false, "prerelease":false}' -H "$AUTH" -H "Content-Type: application/json" $GH_RELEASES

echo "Retrieve asset tag id"

# Read asset tag
response=$(curl -sH "$AUTH" $GH_TAGS)

# Get ID of the asset
eval $(echo "$response" | grep -m 1 "id.:" | grep -w id | tr : = | tr -cd '[[:alnum:]]=')
[ "$id" ] || { echo "Error: Failed to get release id for tag: $tag"; echo "$response" | awk 'length($0)<100' >&2; exit 1; }

echo "Uploading asset... "

# Construct url
GH_ASSET="https://uploads.github.com/repos/$owner/$repo/releases/$id/assets?name=$(basename $filename)"

curl --data-binary @"$filename" -H "$AUTH" -H "Content-Type: application/octet-stream" $GH_ASSET
