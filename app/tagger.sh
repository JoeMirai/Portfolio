#!/bin/bash

# git tagging

git fetch --tags

LATEST_COMMIT_MESSAGE=$(git log -1 --pretty=%B)
MAJOR=$(git tag | sort -V | tail -n 1 | cut -d '.' -f1)
MINOR=$(git tag | sort -V | tail -n 1 | cut -d '.' -f2)
PATCH=$(git tag | sort -V | tail -n 1 | cut -d '.' -f3)

if echo $LATEST_COMMIT_MESSAGE | grep -q "MAJOR"; then
    MAJOR=$((MAJOR+1))
    MINOR=0
    PATCH=0
elif echo $LATEST_COMMIT_MESSAGE | grep -q "MINOR"; then
    MINOR=$((MINOR+1))
    PATCH=0
else
    PATCH=$((PATCH+1))
fi

NEW_TAG="$MAJOR.$MINOR.$PATCH"
echo $NEW_TAG
git tag "$NEW_TAG"
echo $NEW_TAG >> $UPDATED_TAG
git push origin $NEW_TAG