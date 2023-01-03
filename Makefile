ifeq ($(project),)
$(error project is not set)
endif

terraform-validate:
	cd $(project); \
	terraform init; \
	terraform validate

terraform-plan:
	cd $(project); \
   	terraform init; \
	terraform plan -out $(project).tfout \
		-input=false;

terraform-apply:
	cd $(project); \
   	terraform init; \
	terraform plan -out $(project).tfout \
		-input=false; \
	terraform apply $(project).tfout;

terraform-destroy: 
	cd $(project); \
	terraform destroy \
		-input=false \
		-auto-approve;