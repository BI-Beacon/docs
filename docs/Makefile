# Minimal makefile for Sphinx documentation
#

# Default build target is making single page html
all:	code-examples singlehtml
	echo "## all"

code-examples:
	echo "## code-examples"
	cd .. ; ./dist/generate-code-examples.sh

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXPROJ    = BI-Beacon
SOURCEDIR     = .
BUILDDIR      = _build
ACTIVATE      = ../.venv/bin/activate

# Put it first so that "make" without argument is like "make help".
help:
	echo "## help"
	( . $(ACTIVATE) && $(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O) )

clean:
	echo "## clean"
	rm -rf _build *~ \#*\# 2>/dev/null

.PHONY: help Makefile clean setup

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
.DEFAULT: Makefile
	echo "## DEFAULT"
	( . $(ACTIVATE) && $(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O) )
