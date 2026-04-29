# Programming Learning Workspace

> プログラミング・ソフトウェア工学を **概念ベース** で学ぶワークスペース。サービス名で覚えるのではなく、概念 → 最小実装 → 複数サービス比較の 3 層を必ず通る。

## 設計の核

- **ジャンル別**: 学ぶべき領域を「概念抽象度」で 8 つに分割。サービス名（React / Postgres）でなく問題領域（ui-rendering / persistence）で切る
- **3 層構成**: 各ジャンル内で `00-concept/` → `01-implementation/` → `02-comparison/` の順に進む
- **想起 → 答えの分離**: クイズは `*.md` と `*.answer.md` を別ファイルにして、答えを見る前に必ず想起させる
- **学術的支え**: 教材設計は学習科学 12 原則に従う（[`.claude/docs/vision/learning-principles.md`](./.claude/docs/vision/learning-principles.md)）

## ディレクトリ構成

```
~/dev/learning/
├── .claude/                            # Claude 用 SSOT（CLAUDE.md / MEMORY.md / HISTORY.md / docs/）
├── README.md                           # 本ファイル
│
├── data-modeling/                      # データの構造と関係（ER / 正規化 / モデリング哲学）
├── persistence/                        # 永続化（SQL / NoSQL / トランザクション / ACID）
├── ui-rendering/                       # UI 描画（仮想 DOM / コンポーネント / スタイル / a11y）
├── state-and-time/                     # 状態管理 + 並行性（Redux / 楽観的 UI / CRDT）
├── network-and-async/                  # 通信 + 非同期（HTTP / WebSocket / async-await）
├── auth-trust/                         # 認証・認可・セキュリティ（OAuth / JWT / RLS / OWASP）
├── testing-and-quality/                # テスト戦略・型安全性（Vitest / Playwright / TS）
├── infra-and-deploy/                   # インフラ・配布（Container / Edge / CI/CD / モバイル）
│
└── applications/                       # 応用層: 学んだ概念を実プロジェクトに統合
    ├── README.md
    ├── life-editor-web-first/          # 教材
    └── _spikes/                        # 検証用コード
        └── web-first-spike-1/
```

## 各ジャンルの中身（共通）

```
<genre>/
├── README.md                          # ロードマップ / 推奨順 / Dreyfus 段階 / 比較対象
├── 00-concept/                        # 概念層（理論・歴史・なぜ生まれたか）
├── 01-implementation/                 # 最小実装層（Worked Example）
├── 02-comparison/                     # 差別化比較層（複数サービスの並列比較）
├── quiz/                              # 想起練習（問題 + .answer.* で別ファイル）
└── _log/                              # 学習ログ
```

## 推奨学習順

| 順  | ジャンル               | 何を扱うか                                            |
| --- | ---------------------- | ----------------------------------------------------- |
| 1   | `data-modeling/`       | スキーマ・正規化・関係性                              |
| 2   | `persistence/`         | SQL・NoSQL・トランザクション・ACID/BASE               |
| 3   | `ui-rendering/`        | 仮想 DOM・コンポーネント・スタイル・a11y              |
| 4   | `state-and-time/`      | 状態管理・並行性・楽観的 UI・race condition           |
| 5   | `network-and-async/`   | HTTP / WebSocket / REST / GraphQL / RPC / async-await |
| 6   | `auth-trust/`          | OAuth / JWT / セッション / RBAC / OWASP               |
| 7   | `testing-and-quality/` | unit / integration / E2E / TDD / 静的解析             |
| 8   | `infra-and-deploy/`    | コンテナ / Edge / CDN / CI/CD                         |

順序は固定ではなく、応用プロジェクト（`applications/`）で必要になった順に拾い読みしても良い。ただし各ジャンル内では **必ず 3 層の順を守る**（飛躍防止）。

## クイック・スタート

1. `.claude/CLAUDE.md` を読み、Claude が学習セッションをどう運用するかを把握する
2. `.claude/docs/vision/learning-principles.md` で学習設計の根拠（学習科学 12 原則）を確認
3. 興味のあるジャンルの `README.md` を開き、ロードマップを見る
4. Claude に「`/code-teacher <genre>` でセッション開始」と頼む
5. セッション終了時に `_log/` と `.claude/HISTORY.md` を更新

## 関連スキル

- `code-teacher`: 本ワークスペース上で学習セッションを進めるグローバルスキル
- `task-tracker`: `.claude/MEMORY.md` / `HISTORY.md` の更新
- `session-loader`: セッション開始時のコンテキスト読込

## 参考

- 学習設計の根拠: `.claude/docs/vision/learning-principles.md`
- ワークスペース全体の哲学: `.claude/docs/vision/core.md`
- 適用先プロジェクト: `applications/life-editor-web-first/`
