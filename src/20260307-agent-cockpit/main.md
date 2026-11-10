---
presentationID: 1g5FoN1bGv1hV5voAhTu2LzoIhvDVRRFgC59eXu68PTA
title: 20260307-agent-cockpitについて.deck
---

---

# agent-cockpitについて

-   conao3 / Toyokumo, Inc.
-   2026/03/06
-   vim-jp @ 大阪ヒルトンホテル

---

# 最近のAIの話題について

-   OpenClaw
    -   Peter Steinberger氏が開発。Clawdbot → Moltbot → OpenClawと改名
    -   72時間で60,000+ GitHub stars、現在247,000+ stars (2026/03/02時点)
    -   <https://zenn.dev/komlock_lab/articles/openai-symphony>
    -   2026/02/14にSteinberger氏がOpenAI入社を発表。
    -   &ndash;dangerously-skip-permissions/&ndash;yoloをホームディレクトリで起動する
        -   ユーザーの確認なしにファイル操作・コマンド実行を許可
        -   ホームディレクトリ全体がエージェントの作業対象になる
    -   Slack/Discord/Telegramなどコミュニケーション層が用意されている
        -   エージェントが人間と同じチャネルで会話に参加できる
        -   人間→エージェント、エージェント→人間の双方向コミュニケーション
    -   AGENTS.md -> MEMORY.md -> SOUL.mdの記憶の階層
        -   AGENTS.md: プロジェクト全体のルール・制約（世界のルール）
        -   MEMORY.md: 蒸留された長期記憶・学習した知識
        -   SOUL.md: エージェントの人格・価値観・振る舞いの核心
        -   セッションをまたいで「自分が何者か」を維持する仕組み
    -   heartbeat (1時間単位cron) の仕組みによる能動的なLLM エージェントとのコミュニケーション/記憶の更新
        -   指示を待つだけでなく、定期的に自ら起動して状況を確認
        -   記憶の整理・蒸留を自律的に行う
        -   未読メッセージのチェックやタスクの進捗確認
            -   Googleへのフルアクセス許可によるメールチェックなど
    -   サブエージェントへの作業のdelegationの仕組み
        -   メインエージェントがタスクを分解してサブエージェントに委譲
        -   並列に複数のエージェントが作業を進める
    -   Skillsプラグインシステム: 100+のコミュニティプラグイン
        -   Gmail, GitHub, Notion, Obsidian, Spotify, Home Assistantなど
-   Claude desktop app (Cowork): cron
    -   Anthropic公式のデスクトップアプリにcron機能が追加
    -   定期的にエージェントを起動してタスクを実行
    -   ユーザー定義のスケジュールでプロンプトを自動実行
    -   Pro, Max, Team, Enterpriseプランで利用可能
    -   PCがスリープ中はスキップ、復帰後に自動実行
    -   macOS/Windowsのみ（Linux非対応）
-   Claude Code: /loop, CronCreate
    -   Claude Code CLIにスケジュール実行機能が組み込まれている
    -   標準的な5フィールドcron式をサポート（分 時 日 月 曜日）
    -   セッション内で最大50個のタスクを同時保持可能
    -   作成から3日後に自動期限切れ（暴走防止）
    -   CLAUDE\_CODE\_DISABLE\_CRON=1で無効化可能
-   ChatGPT: scheduled tasks
    -   OpenAI公式のChatGPTにスケジュールタスク機能（2025/01ベータ公開）
    -   「毎朝ニュースをまとめて」などの定期実行をチャットから設定
    -   結果はプッシュ通知またはメールで通知
    -   単発/毎日/毎週/毎月/毎年/カスタムの繰り返し設定
    -   15分単位で時間指定可能、1時間あたり最大4回の制限
    -   Plus, Pro, Teamプランで利用可能
-   OpenAI symphony (2026/03/04公開)
    -   <https://github.com/openai/symphony>
    -   https:- cronで監視することにより、順次ワークツリーでタスクを消化していく
    -   Elixir/BEAM上に構築。耐障害性と並行性を重視
    -   エージェントはCI通過・PRレビュー対応・ウォークスルー動画生成まで自律実行
    -   WORKFLOージェントランタイムはOpenAI Codexのみ対応

---

# セキュリティについて

-   全権限許可を運用する流れに。
    -   OpenClawの&ndash;yolo、Claude Codeの&ndash;dangerously-skip-permissionsなど
    -   エージェントの有用性を最大化するには権限制限が邪魔になる現実
-   LLMが自由に動いて、事故が起こらないような環境を整えていく必要がある。
-   プライベートの記憶を持つエージェントと、記事探索のようなプロンプトインジェクションの荒波に飲まれるエージェントを分ける。
-   最近、.envをローカルに置くのをやめて環境変数に設定しようという言説があるが、全く対策になっていないので注意。
    -   LLMエージェントはenvコマンドで環境変数を読める
    -   .envファイルもcatで読める。どちらも同じこと
-   Deno Sandbox (2026/02/03公開) のアプローチが参考になる
    -   軽量Linux microVMで非信頼コードを隔離（1秒以内に起動）
    -   シークレットインジェクション: APIキーはサンドボックス内のコードに直接渡さない
        -   承認済みホストへのリクエスト時にのみプロキシがキーを注入
        -   悪意あるコードがキーを別ドメインに送信しようとしても注入されない。
    -   ネットワーク出口制御: 許可リストにないホストへの通信をVMレベルでブロック
    -   が、まだ普及には時間がかかりそう
-   OpenClawはぜひ遊んでみた方が良い。VMに入れて、与えるトークンを完全に制御して遊ぶと良さそう。

---

# 最近作っているソフトウェア

-   <https://github.com/conao3/rust-cagent>
    -   OpenClawクローン
    -   が、OpenClawの劣化コピーになるしかないのでOpenClawを使う方が良い。
-   <https://github.com/conao3/rust-agent-cockpit>
    -   AIチームを動かす仕組みとGUI。
    -   類似プロジェクト: OpenClaw, shogun
        -   shogun: 武士の階層構造に着想を得たマルチエージェントシステム
        -   <https://github.com/yohey-w/multi-agent-shogun>
        -   <https://zenn.dev/shio_shoppaize/articles/5fee11d03a11a1>
        -   Shogun → Karo → Ashigaruの指揮系統で最大10エージェントを並列制御
        -   Claude Code, OpenAI Codex, GitHub Copilot, Kimi Codeに対応
        -   tmux上でエージェントごとにペインを表示、YAMLファイルベースの通信
        -   定額CLIサブスクで8エージェント並列でもコスト一定
    -   デモ
        -   SaaSにする予定
-   ClaudeCode/CodexのMEMORYのバックアップ
    -   LLMエージェントとの対話、指示をセッション限りにせず長い間付き合っていくものになる。
    -   MEMORY.md, SOUL.mdなどの記憶ファイルは資産。消失すると関係性が失われる
    -   gitで管理し、定期的にバックアップする仕組みが必要
    -   LESSONS.md (ユーザーからの指示を全て記録していく) やMEMORY.md (プロジェクトに関する知識などの蓄積) をLLMが自動的に更新していくのは当たり前になりそう
