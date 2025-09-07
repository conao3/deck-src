---
presentationID: 1JWgLdXnexIhB6nQtdlwnlwmmy_6HsrbYOL5-UnfO9CE
title: 20250907-clojure-mcp.deck
---

<!-- {"layout": "title-and-body"} -->

# MCPとclojure-mcpについて

- conao3 / Toyokumo, Inc.
- 2025/07/09
- AIコーディング共有会

---

<!-- {"layout": "title-and-body"} -->

# conao3 - Naoya Yamashita

Clojureが好き

- GitHub: conao3
- X(Twitter): conao_3

---

<!-- {"layout": "title-and-body"} -->

# アジェンダ

## MCPはLLMと外部ツールを連携するための標準プロトコル。clojure-mcpはこのプロトコルを利用するソフトウェアで、特にREPLをLLMが利用できるようになるため、いわゆるREPL駆動開発のメリットをLLMが享受できるようになり、LLMとの協業に寄与する。

- MCPとは
- claude-codeからの利用方法
- clojure-mcpの紹介
- 今後の発展 - ACP

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

