#!/bin/sh

set -e

[ -z "${INPUT_GITHUB_TOKEN}" ] && {
    echo "Set the GITHUB_TOKEN environment variable."
    exit 1;
};

[ -z "${INPUT_USERNAME}" ] && {
    echo "Set the USERNAME environment variable."
    exit 1;
};

[ -z "${GITHUB_EVENT_PATH}" ] && {
    echo "Set the GITHUB_EVENT_PATH environment variable."
    exit 1;
};

AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"
API_HEADER="Content-Type: application/json"
pull_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")

echo "Adding ${INPUT_USERNAME} as reviewer"
curl --request POST \
  --url "https://api.github.com/repos/$GITHUB_ACTOR/$GITHUB_REPOSITORY/pulls/$pull_number/requested_reviewers" \
  -H "{AUTH_HEADER}" \
  -H "{API_HEADER}" \
  -X POST \
  -d "{\"reviewers\":[\"INPUT_USERNAME\"]}"
