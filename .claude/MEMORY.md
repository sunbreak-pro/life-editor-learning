# MEMORY.md - タスクトラッカー

## 進行中

### ⏸️ data-modeling ジャンル学習（着手日: 2026-04-30）

**対象**: `~/dev/learning/data-modeling/`

- 前回: `00-concept/overview.md` 作成（リレーショナルモデル誕生 / 動機 3 つ = データ独立性 + 整合性 + 宣言的クエリ / 用語 5 個導入）
- 現在: `01-implementation/walkthrough.md` + `code/walkthrough.sql` 完成（Phase 1-6: 重複再現 → 外部キー → `IN (SELECT)` → IN 以外 OR/JOIN/EXISTS → NULL 三値論理）。ユーザーが SQL 実行 + §9 復習問題に取り組む段階で一旦区切り
- 次: 引っかかり解消の対話 → `quiz/01-recall-basic.md` + `.answer.md` → `00-concept/key-terms.md`（残り用語: 正規形 / カーディナリティ / インデックス）→ `02-comparison/` で MongoDB / Neo4j と並列比較

## 直近の完了

- **2026-05-02** `applications/study-board/` 着手（Trello 風 Kanban で JS/React 基礎を体得する学習プロジェクト、Vite + React 素 JS、option (ii) ヒント方式、`.claude/` ツリー構築済、Phase 1 MVP 着手前）。`applications/README.md` の規約に「コード + 教材同居型」を追加
- ~/dev/learning/ ワークスペース整備（`.claude/` 初期化、8 ジャンル骨組み、`applications/` 配下へ既存資産移動、code-teacher SKILL.md 更新）✅（2026-04-29）

## 予定

- `persistence/` 概念学習（ACID / トランザクション / 分離レベル / SQL の宣言性）
- `ui-rendering/` 概念学習（仮想 DOM が解こうとした問題 / Reconciliation / コンポーネント志向の起源）
- `state-and-time/` 概念学習（楽観的 UI / race condition / Realtime Sync / CRDT）
- `network-and-async/` 概念学習（async-await / HTTP 意味論 / WebSocket vs SSE vs Polling）
- `auth-trust/` 概念学習（OAuth / JWT / RBAC / RLS / OWASP）
- `testing-and-quality/` 概念学習（Vitest / Playwright / TDD / 静的解析）
- `infra-and-deploy/` 概念学習（Container / Edge / CI/CD / Capacitor）
- `applications/life-editor-web-first/` 再開（上記 7 ジャンル通過後）
