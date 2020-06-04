#!gmake -f

MAKEFILE_RULES := $(realpath $(lastword $(MAKEFILE_LIST)))
PHONIES := $(shell perl -lane 'print $$1 if m{^([a-zA-Z][-a-zA-Z0-9_]*):[^=]*$$};' ${MAKEFILE_RULES})
.PHONY: ${PHONIES}

IMAGE := systemcc

dflt: targets # Default target

image: ${IMAGE} # Builds the docker image

${IMAGE}:
	docker build -t ${IMAGE} .

clean: # Removes orphaned images
	@IMAGES=`docker images | perl -lane 'next unless m/<none>/; print splice @F,2,1'`;\
        test -n "$$IMAGES" && docker rmi $$IMAGES || echo 'Nothing to remove';

uninstall: # Removes target image
	docker rmi ${IMAGE}

RC= --rcfile /apps/setup.profile
test: # Runs bash in image for testing
	docker run -ti ${IMAGE} bash $(RC)

run: # Intended usage
	docker run $(shell pwd):/home/work -d ${IMAGE} bash $(RC) /apps/scripts/mkcourse ${ARGS}

help: targets # Same as targets
targets: # Lists target documentation
	@echo "Targets:"; for target in ${PHONIES}; do perl -ne 'BEGIN{$$t=shift;printf qq{  %-12.12s},$$t.q{ }.(q{-} x 15)} chomp;s/^$$t:.*[#]//&&print;END{print"\n"}' $$target $(MAKEFILE_RULES); done

# The end
