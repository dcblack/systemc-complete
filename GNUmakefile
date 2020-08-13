#!gmake -f

MAKEFILE_RULES := $(realpath $(lastword ${MAKEFILE_LIST}))
PHONIES := $(shell perl -lane 'print $$1 if m{^([a-zA-Z][-a-zA-Z0-9_]*):[^=]*$$};' ${MAKEFILE_RULES})
.PHONY: ${PHONIES}

BUILDARGS :=
ifdef NOSYSTEMC
BUILDARGS += --build-arg NOSYSTEMC=${NOSYSTEMC}
endif

IMAGE := systemcc

dflt: targets # Default target

preparation: # Setups that couldn't be done inside Dockerfile (yet)
	cd apps && ( ( cd sc-templates && git pull )\
        || git clone git@github.com:dcblack/sc-templates.git )

image: ${IMAGE} # Builds the docker image

${IMAGE}: preparation
	docker build ${BUILDARGS} -t ${IMAGE} .

DANGLING:=$(shell docker images -a -q -f "dangling=true")
clean: # Removes orphaned images
	@test -n "${DANGLING}" && docker rmi ${DANGLING} || echo 'Nothing to remove';

uninstall: # Removes target image
	docker rmi ${IMAGE}

RC= --rcfile /apps/setup.profile
test: # Runs bash in image for testing
	docker run -ti ${IMAGE} bash ${RC}

run: # Intended usage
	docker run $(shell pwd):/home/work -d ${IMAGE} bash ${RC} /apps/scripts/mkcourse ${ARGS}

help: targets # Same as targets
targets: # Lists target documentation
	@echo "Targets:"; for target in ${PHONIES}; do perl -ne 'BEGIN{$$t=shift;printf qq{  %-12.12s},$$t.q{ }.(q{-} x 15)} chomp;s/^$$t:.*[#]//&&print;END{print"\n"}' $$target ${MAKEFILE_RULES}; done

# The end
