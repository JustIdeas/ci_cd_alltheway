.PHONY: image publish run run-docker test

# if you want to use your own registry, change "REGISTRY" value
#REGISTRY       = your.url.registry
#must be lowercase
REGISTRY_USER   = justideas
NAME            = players-app
IMAGE           = $(REGISTRY_USER)/$(NAME):$(VERSION)

image: guard-VERSION ## Build image
	docker build -t $(IMAGE) .

publish: guard-VERSION ## Publish image
	docker push $(IMAGE)

run: ## Run locally
	go run .

run-docker: guard-VERSION ## Run docker container
	docker run --rm -d --name $(NAME) -d -p 5000:5000 $(REGISTRY_USER)/$(NAME):$(VERSION)

test:
	go test -coverprofile=coverage.out ./...

guard-%:
	@ if [ "${${*}}" = ""  ]; then \
		echo "Variable '$*' not set"; \
		exit 1; \
	fi
