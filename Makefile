TOPTARGETS := tests all clean setup 
SUBDIRS := docs

$(TOPTARGETS): $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

tests:
	shellcheck dist/*.sh

clean:
	rm -f *~

.PHONY: $(TOPTARGETS) $(SUBDIRS)
