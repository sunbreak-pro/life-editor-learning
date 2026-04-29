# Persistence — 永続化レイヤ

> 「データを安全に保存し、矛盾なく取り出す」を扱うジャンル。SQL / NoSQL / トランザクション / ACID / BASE / インデックス。

## このジャンルが扱う問題

- なぜ「永続化」だけで一つのジャンルなのか？— ファイルに書くだけでは何が足りないのか
- ACID（原子性・一貫性・分離性・耐久性）がそれぞれ「壊れる」とどんな現象が起きるか
- トランザクションの分離レベルと、現実に起きる Phantom / Lost Update / Dirty Read
- インデックスはなぜ速くなるのか / 何を犠牲にしているのか
- BASE / 結果整合性は ACID の劣化版なのか、別の解なのか
- ORM は何を解決して何を悪化させるのか（N+1 / 抽象漏れ）

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # 永続化とは / ファイル直書きとの違い / なぜ DB が要るか
  mental-model.md                    # トランザクション / ロック / ACID の図解
  key-terms.md                       # ACID / BASE / 分離レベル / インデックス / WAL / レプリケーション

01-implementation/
  walkthrough.md                     # SQLite で予算管理 DB を作り、トランザクションを観測する
  code/                              # SQL + 言語クライアント例
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # PostgreSQL / SQLite / MySQL / MongoDB / DynamoDB / Supabase / Firebase
  why-each-exists.md                 # 各 DB の誕生背景・設計上の妥協
  decision-matrix.md                 # ワークロード vs DB 選択

quiz/
_log/
```

## 推奨学習順

1. **前提**: `../data-modeling/00-concept/` を通っていることが望ましい（モデルなしの永続化は動機が見えない）
2. `00-concept/` で ACID と分離レベルのメンタルモデルを作る（Bret Victor の状態可視化原則）
3. `01-implementation/` で SQLite 上で実際にトランザクション衝突を観測する（"見えない状態" を見える化）
4. `02-comparison/` で **同じ問題を異なる DB がどう解いているか** を並べる
5. `quiz/` で復習

## 関連ジャンル

- `../data-modeling/`: モデリングの直後に来るレイヤ
- `../state-and-time/`: 楽観的 UI / Realtime Sync は永続化レイヤと密結合
- `../network-and-async/`: コネクションプール / レイテンシは永続化のパフォーマンスを左右
- `../auth-trust/`: RLS / 行レベル認可は永続化レイヤで強制する

## 主な比較対象サービス

| カテゴリ         | 代表                       | 設計上の重点                              |
| ---------------- | -------------------------- | ----------------------------------------- |
| 単一サーバー RDB | PostgreSQL / MySQL         | フル ACID + 拡張機能 + 強力なインデックス |
| 組み込み RDB     | SQLite                     | プロセス内 / WAL モードで並行読み         |
| 分散 KV          | DynamoDB / Cassandra       | 水平スケール + パーティショニング         |
| ドキュメント     | MongoDB                    | スキーマレス + 集約パイプライン           |
| BaaS（DB + API） | Supabase / Firebase        | DB + Auth + Realtime のバンドル           |
| New SQL          | CockroachDB / Spanner      | ACID を保ったまま水平スケール             |
| Edge KV          | Cloudflare D1 / Workers KV | エッジロケーション分散                    |

## Dreyfus 到達基準

| Lv. | できること                                                                                  |
| --- | ------------------------------------------------------------------------------------------- |
| 1   | ファイル直書きと DB の違いを口頭で説明できる                                                |
| 2   | INSERT / SELECT / UPDATE / DELETE と簡単な JOIN を書ける                                    |
| 3   | トランザクションを使い分け、典型的な分離レベル問題（Lost Update 等）を説明できる            |
| 4   | インデックス設計と EXPLAIN を読み、N+1 を発見し、Read レプリカ / シャーディングを論じられる |
| 5   | ワークロード分析から RDB / NoSQL / NewSQL の選定ができる、CAP/PACELC を実装上で扱える       |
