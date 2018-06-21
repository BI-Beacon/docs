#!/bin/bash

if [ "${TRAVIS_BRANCH}" == "master" ] ; then
    echo "On \`master' branch - pushing to artifacts repository."
    TMPDR="$(mktemp -d)"
    
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name  "Travis CI"
    
    git clone -b artifacts "https://${GH_TOKEN}@github.com/BI-Beacon/build-artifacts.git" "${TMPDR}"

    (cd "${TMPDR}" && git rm -r docs/* ; mkdir docs )

    find . -name '*.rst' -o -path './docs/_build/*' -o -path './docs/_static/*' -print0 \
      | tar --null -T /dev/stdin | ( "cd ${TMPDIR}/docs" && tar xvf - )

    cd "${TMPDR}" || exit 1
    git add -A 
    git commit -a -m 'Automated build'
    git push
else
    echo "Not on \`master' branch - not publishing."
fi

