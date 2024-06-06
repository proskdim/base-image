COMMON_DIR := /opt/basics/common

check: description-lint code-lint schema-validate test

description-lint:
	yamllint modules -c $(COMMON_DIR)/yamllint.yml

test:
	@(for i in $$(find modules/** -type f -name Makefile); do make test -C $$(dirname $$i) || exit 1; done)

# TODO: add markdown linter and spellckeck (languagetool)
schema-validate:
	@$(COMMON_DIR)/validate-spec.sh
	@$(COMMON_DIR)/validate-language.sh
	@$(COMMON_DIR)/validate-modules.sh
	@$(COMMON_DIR)/validate-lessons.sh

.PHONY: all test
