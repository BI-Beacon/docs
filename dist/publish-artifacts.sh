#!/bin/bash

if [ "${TRAVIS_BRANCH}" == "master" ] ; then
    TMPDR="$(mktemp -d)"
    
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name  "Travis CI"
    
    git clone -b artifacts https://${GH_TOKEN}@github.com/BI-Beacon/build-artifacts.git "${TMPDR}"

    (cd ${TMPDR} && git rm -r docs/* ; mkdir docs )

    cp -a docs/_build/* ${TMPDR}/docs/
    cd "${TMPDR}"
    git add -A 
    git commit -a -m 'Automated build'
    git push
fi
