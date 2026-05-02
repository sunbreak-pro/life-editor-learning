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

3 種類のレイアウトを許容する。プロジェクトの性質で選ぶ：

- **教材分離型** `<app-name>/`: 教材だけ（Markdown 中心）。動くコードは `_spikes/<name>/` に分離する。`life-editor-web-first/` がこの型。
- **動くコード単独型** `_spikes/<spike-name>/`: 教材を伴わない検証用コード（`package.json` あり）。`node_modules/` は ignore。
- **コード + 教材同居型** `<app-name>/`: アプリ自体が学習対象 + 学習を支える道具を兼ねるドッグフード型。コード（`package.json`）と教材（`.claude/docs/`）を同じディレクトリに置く。`study-board/` がこの型。

### 同居型を選ぶ判断基準

- コードと学習ノートを分離するメリットが薄い（ドッグフード型）
- 単一プロジェクトに閉じた小規模学習で、`_spikes/` を別途用意する認知負荷の方が大きい
- 上記に当てはまらないなら **教材分離型**（既存 `life-editor-web-first/` と同様）を選ぶ

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

| 名前                     | 型                  | 状態   | 関連ジャンル                                                            |
| ------------------------ | ------------------- | ------ | ----------------------------------------------------------------------- |
| `life-editor-web-first/` | 教材分離型          | 進行中 | `ui-rendering/` / `persistence/` / `auth-trust/` / `network-and-async/` |
| `study-board/`           | コード + 教材同居型 | 着手中 | `ui-rendering/` / 言語土台（独立ジャンル化していないため事実上の入口）  |

## Spikes

| 名前                         | 紐付くアプリ             | 用途                                        |
| ---------------------------- | ------------------------ | ------------------------------------------- |
| `_spikes/web-first-spike-1/` | `life-editor-web-first/` | Vite + React + TS + Tailwind 素プロジェクト |
