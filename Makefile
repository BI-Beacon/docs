TOPTARGETS := tests all clean setup 
SUBDIRS := docs

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

html:
	( . .venv/bin/activate && sphinx-build -b html docs/ _build/ )

watch:
	( . .venv/bin/activate && sphinx-autobuild -b html docs/ _build/ )

tests:
	echo "# tests"
	shellcheck dist/*.sh

install:
	echo "## start"
	python3 -m venv .venv
	( . .venv/bin/activate && pip install -r requirements.txt )
	sudo apt install graphviz
	echo "## end"

clean:
	echo "# clean"
	rm -f *~
	rm -rf .venv/
	rm -rf _build/

.PHONY: $(TOPTARGETS) $(SUBDIRS)
