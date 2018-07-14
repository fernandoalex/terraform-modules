BUILDER := $(shell ls -1 tests/ | fzf)

build:
	rm -rf .terraform/
	terraform init tests/$(BUILDER)
	terraform apply tests/$(BUILDER)

destroy:
	terraform destroy tests/$(BUILDER)