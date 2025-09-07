---
presentationID: 1JWgLdXnexIhB6nQtdlwnlwmmy_6HsrbYOL5-UnfO9CE
title: 20250907-clojure-mcp.deck
---

<!-- {"layout": "title-and-body"} -->

# MCPとclojure-mcpについて

- conao3 / Toyokumo, Inc.
- 2025/07/10
- AIコーディング共有会 @ Toyokumo

---

<!-- {"layout": "title-and-body"} -->

# conao3 - Naoya Yamashita

## Clojureが好き

- GitHub: conao3
- X(Twitter): conao_3

- 発表資料
  - [GitHub: conao3/deck-src/src/20250907-clojure-mcp](https://github.com/conao3/deck-src/tree/master/src/20250907-clojure-mcp)
  - [Google Slide](https://docs.google.com/presentation/d/1JWgLdXnexIhB6nQtdlwnlwmmy_6HsrbYOL5-UnfO9CE/edit?usp=sharing)

---

<!-- {"layout": "title-and-body"} -->

# アジェンダ

## MCPはLLMと外部ツールを連携するための標準プロトコル。clojure-mcpはこのプロトコルを利用するソフトウェアで、特にREPLをLLMが利用できるようになるため、いわゆるREPL駆動開発のメリットをLLMが享受できるようになり、LLMとの協業に寄与する。

- MCPとは
- MCPの利用方法
- clojure-mcpの紹介
- clojure-mcp利用上の注意点

---

<!-- {"layout": "title-and-body"} -->

# MCPが解決したい課題

## LLM(AIアプリケーション)と外部ツールの通信をプロトコル化すること

現状のAIは3層構造
- LLM (gpt-5, mini, nano / claude-opus, sonnet, haiku)
- AIアプリケーション (システムプロンプト, ユーザーインターフェース)
- 外部ツール (Figma, GitHub, GMail, Clojure,,,)

MCPは「AIアプリケーション」と「外部ツール」間の通信の標準化を目指している。

Claude開発企業のAnthropicにより、2024/11に発表。急速にAI分野で広がった。

類似の例としては「エディタ」と「開発ツール」間のLSP。

---

<!-- {"layout": "title-and-body"} -->

# MCPの機能

## MCPは外部ツールの機能をPrompts, Resouses, Toolsとして提供する

- Prompts
  - ユーザー主導; 再利用可能な(動的な)プロンプトを提供する
- Tools
  - モデル主導; ユーザーの要求に適しているツールを発見し、利用する (副作用を含みうる)
- Resouces
  - アプリケーション主導; URIで一意に特定できる情報を、モデルに提供する (読み取り専用)

---

<!-- {"layout": "title-and-body"} -->

# MCPの利用方法

## MCPサーバーとの通信経路はstdio、SSE(Server-Sent Events)、HTTPが利用できる。HTTPでMCPサーバーが提供されているととても簡単

サンプルとして [AWS Knowledge MCP Server](https://github.com/awslabs/mcp/tree/main/src/aws-knowledge-mcp-server) を利用してみる

- claude-code
  - claude mcp add --transport http aws-knowledge-mcp-server --scope user https://knowledge-mcp.global.api.aws
    - scopeは以下の3つの選択肢がある
      - user (ユーザー設定かつグローバル)
      - local (ユーザー設定かつプロジェクトごと)
      - project (プロジェクトに.mcp.jsonを作る)
- Web版 Claude
  - 設定 -> コネクタ -> カスタムコネクタを追加
- ChatGPT
  - コネクタでできる([らしい](https://help.openai.com/en/articles/11487775-connectors-in-chatgpt)。無料プランのため検証できず。)

---

<!-- {"layout": "title-and-body"} -->

# MCPの利用方法 - claude-code

## 現在のコードベースの情報も加味して返答してくれる

---

<!-- {"layout": "title-and-body"} -->

# MCPの利用方法 - Web版 Claude

## 設定 -> コネクタ -> カスタムコネクタを追加

---

<!-- {"layout": "title-and-body"} -->

# clojure-mcp

## REPLにアクセスできるようにし、REPL駆動開発の力をLLMに授けることができる

1. プロジェクトのREPLを起動する。ポート番号を指定するとなおよい。
   - `clj -M:dev:repl --port 16234` など

2. グローバルのdeps.ednにclojure-mcpの設定を入れる
   ```
   {:aliases
    {;; clj -X:mcp :port 39541
     :mcp
     {:deps {org.slf4j/slf4j-nop {:mvn/version "2.0.16"} ;; Required for stdio server
             com.bhauman/clojure-mcp {:git/url "https://github.com/bhauman/clojure-mcp.git"
                                      :git/tag "v0.1.7-alpha"
                                      :git/sha "992fe5d"}}
      :exec-fn clojure-mcp.main/start-mcp-server}}}
   ```

3. clojure-mcpの起動確認
   - `clojure -X:mcp :port 16234`
   - `clojure -X:mcp :port 16234 :project-dir .` : gitのルートに `deps.edn` がない場合
   - JSON-RPCのメッセージが出ていればOK。終了させる。

4. claude-codeに設定する
   - `claude mcp add clojure-mcp -s project -- clojure -X:mcp :port 16234 :project-dir .`
   
---

<!-- {"layout": "title-and-body"} -->

# clojure-mcp - 使ってみる

## REPLに接続しているため、LLMがプロジェクトのコードを自由に動かせるようになっている

- 関数の定義と実行
  - (ns conao3.mcp-sample)
  - Clojureのバージョンを返却する関数を定義し、実行してください
    - (defn clojure-version-number [] (clojure-version))
    - "1.12.0"

- 現在のnsに基づいた情報の返却
  - 現在のnsに定義されているvarの一覧を返却してください
    - conao3.mcp-sample 名前空間には clojure-version-number と hello の2つのvarが定義されています。

- テストの実行
  - 現在のnsに対するテストを実行してください
    - Testing conao3.mcp-sample-test
    - … +3 lines (ctrl+r to expand)
    - ● テストが正常に実行されました。1つのテストがパスしています。

---

<!-- {"layout": "title-and-body"} -->

# clojure-mcp - 注意点

## 便利な一方、注意点もある

- 任意コード実行の危険性
  - 完全に任意コード実行の環境であるため、LLMへの指示は曖昧性なく行い、AIが何をしようとしているのか把握すること。
  - まぁclaude-codeの素の状態でそもそも任意コード実行の環境であるというのはある
- REPLから実行できる全てのことができるという認識を持つ
  - 例えばREPLにはDBが繋がっているので、REPL経由でテーブルのdropなどの操作がLLMが簡単に実行できるようになっている。
  - つまり、やるにしても完全にローカルのREPLのみで利用する。
- とはいえLLMが直接REPLと対話できるというのは得難いメリットでもある

---

<!-- {"layout": "title-and-body"} -->

# まとめ

- MCPとは
  - LLM(AIアプリケーション)と外部ツールの通信のプロトコル
  - 外部ツールの機能をPrompts, Resouses, Toolsとして提供する
- MCPの利用方法
  - 通信経路はstdio、SSE(Server-Sent Events)、HTTPが利用できる
  - HTTPでMCPサーバーが提供されているととても簡単
- clojure-mcpの紹介
  - REPLにアクセスできるようにし、REPL駆動開発の力をLLMに授けることができる
  - REPLに接続しているため、LLMがプロジェクトのコードを自由に動かせるようになっている
- clojure-mcp利用上の注意点
  - 任意コード実行の環境であることを理解する
  - そのREPLにどんなことができるのか想定する
    - 必要以上に多くのことができるREPLに繋がない
  - とはいえLLMが直接REPLと対話できるというのは得難いメリット
