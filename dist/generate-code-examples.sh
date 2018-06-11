#!/bin/bash

TMPD="$(mktemp -d)"
WD="$(pwd)"

cat > "${WD}/docs/code_examples.rst" <<EOF
Code examples
==================

EOF

git clone -q --depth 1 https://github.com/BI-Beacon/client-examples "${TMPD}"

cd "${TMPD}"
mkdir "apa bepa"

find . -mindepth 1 -type d -not -path '*/.*' | sort | while read LANG ; do
    if [ -f "${LANG}/README.md" ] ; then
        echo "Include ${LANG}."
        (
            LNG="$(sed -n 's%^# \(.*\)%\1%p' "${LANG}/README.md")"
            echo -e "${LNG}\n${LNG//?/-}\n\n.. code-block:: ${LNG,,?}\n"
            find "${LANG}" -type f -not -name 'README.md' -print0 | \
                xargs -r0n 1 sed 's#^#   #'
            echo -e "\n\n"
        ) >> "${WD}/docs/code_examples.rst"
    fi
done

rm -rf "${TMPD}"

