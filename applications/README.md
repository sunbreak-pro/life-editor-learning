# Applications — 応用層

ジャンル別の概念学習で身につけた知識を **実プロジェクトに統合** する場所。各 application は複数のジャンルを横断する。

## このディレクトリの役割

ジャンル別ディレクトリ（`../data-modeling/`, `../persistence/` 等）が「概念単位の学習」なら、ここは「**それらを組み合わせて動く全体を作る**」場所。van Merriënboer の 4C/ID 原則に従い、**部分スキルの積み上げではなく、最初から全体タスクで転移を促す**。

## 構成

```
applications/
├── README.md                        # 本ファイル
├── <app-name>/                      # 教材（マークダウン）
│   ├── README.md                    # アプリ概要 / 関連ジャンル一覧 / Phase 構成
│   ├── prerequisites.md             # 必要な前提ジャンルへのリンク
│   ├── day-XX-YY-<topic>/           # Phase / Day 単位の教材
│   └── _learning-log/               # 日次ログ
└── _spikes/                         # 検証用コード（教材とは分離）
    └── <spike-name>/
```

## 命名ルール

- `<app-name>/`: 教材だけ。Markdown 中心。git 管理。
- `_spikes/<spike-name>/`: 動くプロジェクトコード（`package.json` あり）。`node_modules/` は ignore。

## ジャンルとの結びつけ

各 application の `README.md` 冒頭に **関連ジャンル一覧** を必ず置く:

```markdown
## 関連ジャンル

| ジャンル             | この application で扱う部分                       |
| -------------------- | ------------------------------------------------- |
| `ui-rendering/`      | React コンポーネントツリー、Tailwind スタイリング |
| `persistence/`       | Supabase（PostgreSQL ベース）の SDK 利用          |
| `auth-trust/`        | Supabase Auth の Email / Magic Link               |
| `network-and-async/` | Supabase Realtime（WebSocket + CDC）              |
```

未学習のジャンルがある場合、`prerequisites.md` で「最低限の Lv.2 概念だけ抜粋」を作って飛躍を防ぐ。

## 現在の applications

| 名前                     | 状態   | 関連ジャンル                                                            |
| ------------------------ | ------ | ----------------------------------------------------------------------- |
| `life-editor-web-first/` | 進行中 | `ui-rendering/` / `persistence/` / `auth-trust/` / `network-and-async/` |

## Spikes

| 名前                         | 紐付くアプリ             | 用途                                        |
| ---------------------------- | ------------------------ | ------------------------------------------- |
| `_spikes/web-first-spike-1/` | `life-editor-web-first/` | Vite + React + TS + Tailwind 素プロジェクト |
