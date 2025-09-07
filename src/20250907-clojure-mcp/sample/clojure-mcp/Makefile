.PHONY: repl
repl:
	clojure -M:dev:repl

.PHONY: test
test:
	clojure -M:dev:test

.PHONY: lint
lint:
	clj-kondo --lint src test dev

.PHONY: update
update:
	clojure -Sdeps '{:deps {com.github.liquidz/antq {:mvn/version "RELEASE"}}}' -M -m antq.core --upgrade --force
