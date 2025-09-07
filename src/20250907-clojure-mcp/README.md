# MCPとclojure-mcpについて

- conao3 / Toyokumo, Inc.
- 2025/07/10
- AIコーディング共有会 @ Toyokumo

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
