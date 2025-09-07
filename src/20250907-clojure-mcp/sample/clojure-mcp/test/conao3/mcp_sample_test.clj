(ns conao3.mcp-sample-test
    (:require
     [clojure.test :as t]
     [conao3.mcp-sample :as c.mcp-sample]))

(t/deftest hello-test
           (t/testing "hello function"
                      (t/is (= "Hello, MCP Test!" (c.mcp-sample/hello)))))
