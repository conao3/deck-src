.PHONY: install
install:
	pnpm install

.PHONY: build
build:
	pnpm exec tsc

.PHONY: watch
watch:
	pnpm exec tsc -w

.PHONY: test
test:
	pnpm exec jest

.PHONY: synth
synth:
	cdk synth

.PHONY: deploy
deploy:
	cdk deploy

.PHONY: destroy
destroy:
	cdk destroy
