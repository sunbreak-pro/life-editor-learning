# HISTORY.md - 学習ログ

> 学習セッション・ワークスペース変更を降順で記録。最新が先頭。各セッションは `_log/YYYY-MM-DD-<topic>.md`（ジャンル配下）にも詳細を残す。

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
