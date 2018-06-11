#!/bin/bash

set -opipefail
set -eE

if [ "${TRAVIS_BRANCH}" == "mad-publish-artifacts" ] ; then
    TMPDR="$(mktemp -d)"
    
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name  "Travis CI"
    
    git clone -b artifacts https://${GH_TOKEN}@github.com/BI-Beacon/build-artifacts.git "${TMPDR}"
    
    git rm -r ${TMPDR}/docs/*
    
    cp -a docs/_build/* ${TMPDR}/docs/
    cd "${TMPDR}"
    git commit -a -m 'Automated build'
    git push
fi
