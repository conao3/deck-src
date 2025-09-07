.PHONY: install build synth deploy destroy

install:
	cd cdk && pnpm install

build:
	cd cdk && pnpm run build

synth:
	cd cdk && pnpm exec cdk synth

deploy:
	cd cdk && pnpm exec cdk deploy

destroy:
	cd cdk && pnpm exec cdk destroy
