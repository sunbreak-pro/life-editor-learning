# HISTORY.md - 学習ログ

> 学習セッション・ワークスペース変更を降順で記録。最新が先頭。各セッションは `_log/YYYY-MM-DD-<topic>.md`（ジャンル配下）にも詳細を残す。

---

- 2026-05-05: [途中] JS 構文流暢性トラック — `00-foundations/javascript/` ジャンル新設（README に 8 つの柱マップ・Java/TS 比較スタンス・Dreyfus 到達基準・アプリ駆動運用方針）。study-board `docs/code-explanation/01-vite-scaffold-tour.md`（main.jsx 統合解読、ESM import 3 形式 + DOM API + メソッドチェーン + JSX + trailing comma + StrictMode、Java/TS 比較と Self-Explanation Prompt 併設）完成。auto-memory に「学習教材は統合文書を好む」「学習者は研修中で Java 先行学習予定」を保存。次は App.jsx tour または Active Recall。

---

### 2026-05-05 — SQL 構文流暢性トラック設計 + data-modeling Phase 3 前提概念整理

#### 概要

data-modeling Phase 3 着手前の前提概念を学習者と対話で確認し、SQL に関する 3 つの曖昧領域（UNIQUE と collation / UPDATE vs ALTER の DDL/DML 分離 / NOT NULL カラム追加時の矛盾）を解消した。同時に学習者から「概念だけでなく SQL の書き方や工夫の仕方をもっと学びたい」「サブクエリ・JOIN・基礎 CRUD が曖昧」「COUNT(\*) と COUNT(カラム名) を表示形式の違いと誤解している」という要望を受け、ジャンル横断の前提層として SQL 構文流暢性トラック（`00-foundations/sql-syntax/`）を新設する設計書を作成した。

#### 変更点

- **対話で解消した概念 3 件**:
  - UNIQUE と collation（SQLite デフォルト BINARY では 'Taro' と 'taro' は別物として共存可能、`COLLATE NOCASE` で同一視）
  - UPDATE と ALTER TABLE の意図的分離（DML vs DDL）。SQLite の ALTER TABLE は 4 操作のみ（RENAME TABLE / ADD COLUMN / RENAME COLUMN / DROP COLUMN）、型・PK・UNIQUE 変更は「テーブル作り直し」が必要
  - NOT NULL カラムを既存データに ADD COLUMN すると失敗する理由（既存行が NULL になる矛盾）。回避策は `DEFAULT` 併記。学習者は (C) 「失敗する」を正答
- **誤解の発見**: 学習者は `COUNT(*)` と `COUNT(カラム名)` の差を「表示形式の違い（NULL は空白 / INTEGER は 0）」と誤認識。実際は「何を数えるか」の違い（`*` は全行 / `col` は NULL でない行）
- **設計書作成**: `.claude/2026-05-05-sql-fluency-track.md`（Status: ACTIVE）
  - 配置: ジャンル横断の `00-foundations/sql-syntax/` を新設（data-modeling と persistence の両方から再利用可能）
  - 構成: 5 トピック（01-crud / 02-aggregate / 03-join / 04-subquery / 05-utility）、各トピック intro.md + examples.sql + exercises.sql + .answer.sql の 4 ファイル
  - 学習科学原則の対応表を組み込み（想起練習 / 分散復習 / Worked Example / Self-Explanation / Generation Effect）
  - 02-aggregate を「COUNT 誤解解消の最重要課題」として位置づけ
- **進行方針の変更**: data-modeling Phase 3〜6 の SQL 実行は ⏸️ 維持。SQL 構文流暢性トラックの 01-crud と 03-join を完了してから Phase 3 に再着手する順序に切り替え

---

### 2026-05-05 — SQLite 学習サンドボックス整備

#### 概要

`data-modeling` ジャンルの walkthrough.sql を実機で動かすための専用ワークスペースとして `sqlite/` を新設。教材ファイルとは分離し、ユーザーが自分で書く SQL と SQLite が生成する DB ファイルを git 管理ポリシー込みで扱える構成にした。`data-modeling` 学習自体は引き続き ⏸️。

#### 変更点

- **ディレクトリ追加**: トップレベルに `sqlite/` を新設し、`playground/`（自分で書く `.sql`、track 対象）と `db/`（生成 DB、ignore 対象）に分離
- **README**: 起動コマンド・表示モード設定（`.headers on` / `.mode column`）・`.read` vs バッチ実行・命名規則・注意点を 1 枚にまとめた
- **.gitignore 拡張**: `*.db` / `*.db-journal` / `*.db-shm` / `*.db-wal` / `*.sqlite` / `*.sqlite3` を除外パターンに追加（`.sql` は track 対象に維持）
- **配置判断**: `data-modeling/` 配下に閉じ込めず top-level に置くことで、persistence / auth-trust など複数ジャンルから再利用できる構成にした

---

- 2026-04-30: [途中] data-modeling ジャンル学習 — `00-concept/overview.md` + `01-implementation/walkthrough.md` + `code/walkthrough.sql` 完成。重複再現 → 外部キー → `IN (SELECT)` → OR/JOIN/EXISTS → NULL 三値論理まで通過。詳細は `data-modeling/_log/2026-04-30-walkthrough.md`。次回は §9 復習問題のフィードバック → `quiz/01-recall-basic.md` 作成 → `key-terms.md`。

### 2026-04-29 — Workspace 初期化

#### 概要

`~/dev/learning/` を「ジャンル別・概念ベース」の学習ワークスペースとして再構築した。これまで life-editor 連動の単一プロジェクト学習しか無かったところに、概念抽象度で切ったジャンル別ディレクトリを導入した。

#### 手法

- 学習科学リサーチ（Roediger / Bjork / Sweller / Marton / Hermans / van Merriënboer）から 12 原則を抽出
- archive/project-setter の `research/` テンプレートを学習用にカスタマイズして適用
- ジャンルは「概念抽象度」で切る（学習者がメンタルモデルを共有できる単位）

#### 結果

- `.claude/CLAUDE.md` / `MEMORY.md` / `HISTORY.md` 作成
- `docs/vision/core.md` / `learning-principles.md` / `README.md` 作成（学習科学 12 原則を vision に固定）
- `docs/known-issues/INDEX.md` / `_TEMPLATE.md` 作成
- 8 ジャンル骨組み: `data-modeling/` / `persistence/` / `state-and-time/` / `network-and-async/` / `ui-rendering/` / `auth-trust/` / `testing-and-quality/` / `infra-and-deploy/`
- 既存の `life-editor-web-first/` と `web-first-spike-1/` を `applications/` 配下に移動
- `code-teacher` スキルの SKILL.md を 3 層構成（概念 → 実装 → 比較）対応に更新

#### 考察・次のアクション

- 最初の本格学習トピックは `data-modeling/` から始める（最も依存度が低く、他ジャンルの土台になる）
- `00-concept/` を書く前に、AskUserQuestion で「リレーショナルモデルって何のためにあると思う？」のような既存知識引き出しから始める
- Anki などの分散復習ツールとの連携は、quiz/INDEX.md がある程度溜まってから検討
