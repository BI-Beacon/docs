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

    echo "Listing current directory: $(pwd)"
    find . -type f
    find . -name '*.rst' -o -path './docs/_build/*' -o -path './docs/_static/*'
    
    find . -name '*.rst' -o -path './docs/_build/*' -o -path './docs/_static/*' -print0 \
      | tar --null -T /dev/stdin -cvf - | ( cd "${TMPDR}/docs" && tar xvf - )

    cd "${TMPDR}"
    git add -A 
    git commit -a -m 'Automated build'
    git push
else
    echo "Not on \`master' branch - not publishing."
fi

