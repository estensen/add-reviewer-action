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

pull_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
AUTH_HEADER="Authorization: Bearer ${INPUT_GITHUB_TOKEN}"
API_HEADER="Content-Type: application/json"
URL="https://api.github.com/repos/${GITHUB_ACTOR}/${GITHUB_REPOSITORY}/pulls/${pull_number}/requested_reviewers"

echo "Adding ${INPUT_USERNAME} as reviewer to PR number ${pull_number}"

curl --request POST \
  --url "$URL" \
  --header "$AUTH_HEADER" \
  --header "$API_HEADER" \
  --data "{\"reviewers\":[\"$INPUT_USERNAME\"]}"
