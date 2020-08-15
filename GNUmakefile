#!gmake -f
#
# The makefile is based on GNU make (sometimes known as gmake), and is fairly
# sophisticated in its use of the GNU make extensions. Comments that start
# with #: indicates their use as part of the help target.
#
#: GNUmakefile is part of the SystemC-Complete toolset based on Docker. This particular
#: makefile is designed to build the SystemC-Complete Docker image.
#:
#:<USAGE
#: make image
#:
#:<COPYRIGHT & LICENSE
#: Copyright 2020 by David C Black.
#: This file is open-source and licensed under Apache 2.0.

# Determine the full pathname of this file
MAKEFILE_RULES := $(realpath $(lastword ${MAKEFILE_LIST}))
# Extract a list of phony targets by examining the contents of this makefile.
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

help: # Provides a bit more information
	@echo "HELP";\
         perl -lne 'if(m{^#:}){s{^#:<}{};s{^#:}{};s{^ }{  };print;}END{print q{};}' ${MAKEFILE_RULES}; \
	 ${MAKE} -s targets

targets: # Lists targets and brief description
	@echo "TARGETS";\
         for target in ${PHONIES}; do\
           perl -ne 'BEGIN{$$t=shift;printf qq{  %-12.12s},$$t.q{ }.(q{-} x 15)} chomp;s/^$$t:.*[#]//&&print;END{print"\n"}' $$target ${MAKEFILE_RULES};\
         done

# The end
