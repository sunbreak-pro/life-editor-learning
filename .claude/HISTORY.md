# HISTORY.md - 学習ログ

> 学習セッション・ワークスペース変更を降順で記録。最新が先頭。各セッションは `_log/YYYY-MM-DD-<topic>.md`（ジャンル配下）にも詳細を残す。

---

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
