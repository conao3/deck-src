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
	pnpm exec cdk synth

.PHONY: deploy
deploy:
	pnpm exec cdk deploy

.PHONY: destroy
destroy:
	pnpm exec cdk destroy
