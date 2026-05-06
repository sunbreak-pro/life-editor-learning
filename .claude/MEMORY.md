# MEMORY.md - タスクトラッカー

## 進行中

### 🔧 SQL 構文流暢性トラック（着手日: 2026-05-05）

**対象**: `~/dev/learning/00-foundations/sql-syntax/`
**計画書**: `.claude/2026-05-05-sql-fluency-track.md`

- 前回: —
- 現在: 設計書作成完了（5 トピック構成: 01-crud / 02-aggregate / 03-join / 04-subquery / 05-utility、各 intro.md + examples.sql + exercises.sql + .answer.sql の 4 ファイル構成）。学習者の COUNT(\*) vs COUNT(col) 誤解を 02-aggregate の最重要課題に位置づけ
- 次: `00-foundations/sql-syntax/README.md` 作成 → トピック 01 CRUD 着手（intro.md → examples.sql → exercises.sql + .answer.sql → quiz）

### ⏸️ data-modeling ジャンル学習（着手日: 2026-04-30）

**対象**: `~/dev/learning/data-modeling/`

- 前回: Phase 3 前提概念の対話確認完了（UNIQUE と collation / UPDATE vs ALTER / NOT NULL カラム追加の矛盾）。学習者は (C) 「ALTER 失敗」を正答
- 現在: Phase 3〜6 の SQL 実行は SQL 構文流暢性トラック（01-crud + 03-join）通過後に再開する方針。walkthrough.md / code/walkthrough.sql は完成済み
- 次: SQL 構文流暢性トラックで CRUD + JOIN を流暢に書けるようになってから Phase 3 着手 → `quiz/01-recall-basic.md` → `00-concept/key-terms.md` → `02-comparison/`

### ⏸️ JS 構文流暢性トラック（着手日: 2026-05-05）

**対象**: `~/dev/learning/00-foundations/javascript/` および `applications/study-board/docs/code-explanation/`

- 前回: —
- 現在: ジャンル骨組み + README（8 つの柱マップ / Java・TS 比較スタンス / Dreyfus 到達基準 / アプリ駆動・都度深掘り運用方針）作成完了。study-board の `main.jsx` 統合解読文書（`code-explanation/01-vite-scaffold-tour.md`）完成（4 ブロック構造 / ESM import 3 形式 / DOM API / メソッドチェーン / JSX / trailing comma / StrictMode、各節に Java/TS 比較と Self-Explanation Prompt 併設）
- 次: `App.jsx` tour（`02-app-jsx-tour.md`、useState / 分割代入 / アロー関数 / JSX 内式埋め込み / export default を統合解読）着手 / または学習者が §8 Self-Explanation Prompts を解いてフィードバック → 詰まったトピックを `00-foundations/javascript/00-concept/` に深掘り個別ファイル化（`01-bindings.md` / `03-modules.md` / `04-functions.md` / `06-objects.md` 候補）

## 直近の完了

- **2026-05-05** SQL 構文流暢性トラック設計書作成 + data-modeling Phase 3 前提概念の対話確認（UNIQUE/collation, UPDATE vs ALTER, NOT NULL 追加時の矛盾）。学習者の COUNT(\*) vs COUNT(col) 誤解を発見し、設計書で誤解解消を最優先課題に位置づけ ✅
- **2026-05-05** `sqlite/` 学習サンドボックス整備（`playground/` + `db/` 構成、`.gitignore` に SQLite 系拡張子 6 種追加、README で起動・命名規則を整理）✅
- **2026-05-02** `applications/study-board/` 着手（Trello 風 Kanban で JS/React 基礎を体得する学習プロジェクト、Vite + React 素 JS、option (ii) ヒント方式、`.claude/` ツリー構築済、Phase 1 MVP 着手前）。`applications/README.md` の規約に「コード + 教材同居型」を追加

## 予定

- `persistence/` 概念学習（ACID / トランザクション / 分離レベル / SQL の宣言性）
- `ui-rendering/` 概念学習（仮想 DOM が解こうとした問題 / Reconciliation / コンポーネント志向の起源）
- `state-and-time/` 概念学習（楽観的 UI / race condition / Realtime Sync / CRDT）
- `network-and-async/` 概念学習（async-await / HTTP 意味論 / WebSocket vs SSE vs Polling）
- `auth-trust/` 概念学習（OAuth / JWT / RBAC / RLS / OWASP）
- `testing-and-quality/` 概念学習（Vitest / Playwright / TDD / 静的解析）
- `infra-and-deploy/` 概念学習（Container / Edge / CI/CD / Capacitor）
- `applications/life-editor-web-first/` 再開（上記 7 ジャンル通過後）
