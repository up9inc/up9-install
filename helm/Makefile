# for version bump, thanks to alan

VERSION := $(shell git describe --tags --abbrev=0 | sed -Ee 's/^v|-.*//')
.PHONY: version
version:
    @echo v$(VERSION)

SEMVER_TYPES := major minor patch
BUMP_TARGETS := $(addprefix bump-,$(SEMVER_TYPES))
.PHONY: $(BUMP_TARGETS)
$(BUMP_TARGETS):
    $(eval bump_type := $(strip $(word 2,$(subst -, ,$@))))
    $(eval f := $(words $(shell a="$(SEMVER_TYPES)";echo $${a/$(bump_type)*/$(bump_type)} )))
    @echo -n v
    @echo $(VERSION) | awk -F. -v OFS=. -v f=$(f) '{ $$f++ } 1'

