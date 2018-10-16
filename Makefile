TOPTARGETS := tests all clean setup 
SUBDIRS := docs

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

tests:
	echo "# tests"
	shellcheck dist/*.sh

clean:
	echo "# clean"
	rm -f *~

.PHONY: $(TOPTARGETS) $(SUBDIRS)
