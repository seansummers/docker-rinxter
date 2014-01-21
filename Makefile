# FIXME: edit the Dockerfile when install.sh changes, or Trusted Build doesn't work (long story)

ID	:= image.id
D	:= docker

all:	testinteractive

testfull:	$(ID)
	$(D) run -P -t -i -rm $(shell cat $<)

testinteractive:	$(ID)
	$(D) run -P -t -i -rm --entrypoint=/bin/bash $(shell cat $<) -i

$(ID):	Dockerfile install.sh 
	$(D) build -q . | awk '/built/ {print $$3}' >$@

cleanid:
	-rm -f $(ID)
cleandocker:
	$(eval CID := $(findstring $(shell cat $(ID)), $(shell $(D) images -q)))
	$(if $(CID), $(D) rmi $(CID))
clean:	cleandocker cleanid
.PHONY:	clean cleanid cleandocker

