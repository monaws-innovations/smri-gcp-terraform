ifeq ($(project),)
$(error project is not set)
endif

terraform-validate:
	cd $(project)/iam; \
	terraform init; \
	terraform validate

terraform-plan:
	cd $(project)/iam; \
   	terraform init; \
	terraform plan -out $(project).tfout \
		-input=false;

terraform-apply:
	cd $(project)/iam; \
   	terraform init; \
	terraform plan -out $(project).tfout \
		-input=false; \
	terraform apply $(project).tfout;

terraform-destroy: 
	cd $(project)/iam; \
	terraform destroy \
		-input=false \
		-auto-approve;