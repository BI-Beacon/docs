TOPTARGETS := tests all clean setup 
SUBDIRS := docs

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

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
	rm -rf .venv

.PHONY: $(TOPTARGETS) $(SUBDIRS)
