#!/bin/bash

set -eE
set -o pipefail
set -x 

if [ "${TRAVIS_BRANCH}" == "master" ] ; then
    echo "On \`master' branch - pushing to artifacts repository."
    TMPDR="$(mktemp -d)"
    
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name  "Travis CI"
    
    git clone -b artifacts "https://${GH_TOKEN}@github.com/BI-Beacon/build-artifacts.git" "${TMPDR}"

    (cd "${TMPDR}" && (git rm -r docs/* || true))
    if [ ! -d "${TMPDR}/docs" ] ; then
        mkdir "${TMPDR}/docs"
    fi

    ls -la "${TMPDR}"

    cd docs/

    rm -rf .venv
    
    echo "Listing eligble files in current directory: $(pwd)"
    find . \( -name '*.rst' -o -name '*.pickle' -o -name '*.doctree' -o -name '*.venv' -o -name '*.html' -o -name '*.inv' -o -name '*.buildinfo' -o -name '*.js' -o -name '*.png' -o -name '*.jpg' -o -name '*.gif' -o -name '*.css' -o -name '*.js' \)
    find . \( -name '*.rst' -o -name '*.pickle' -o -name '*.doctree' -o -name '*.venv' -o -name '*.html' -o -name '*.inv' -o -name '*.buildinfo' -o -name '*.js' -o -name '*.png' -o -name '*.jpg' -o -name '*.gif' -o -name '*.css' -o -name '*.js' \) -print0 \
      | tar --null -T /dev/stdin -cvvvf - | ( cd "${TMPDR}/docs" && tar xvvvf - )

    cd "${TMPDR}"

    echo "Listing contents of commitable directory: ${TMPDR}"
    find .
    
    git add -A 
    git commit -a -m 'Automated build'
    git push
else
    echo "Not on \`master' branch - not publishing."
fi

