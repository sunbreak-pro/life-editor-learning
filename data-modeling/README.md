# Data Modeling — データの構造と関係

> 「世界の何を、どんな形のデータで表現するか」を扱うジャンル。スキーマ設計・正規化・関係性・モデリング哲学。

## このジャンルが扱う問題

- なぜデータを「表」で表現するのか？それで世界が表現できるのは偶然ではない（リレーショナル代数）
- 「同じ情報を 2 箇所に書かない」（正規化）はなぜ重要か / どこで破ると良いのか
- 表 / ドキュメント / グラフ / イベントログ — どれをいつ選ぶか
- 1 対 N / N 対 N / 階層構造 を表でどう表現するか
- スキーマレスは「楽」なのか「先送り」なのか

## ジャンル内ロードマップ

```
00-concept/                          # 概念層
  overview.md                        # データモデルとは / 歴史 / リレーショナル革命
  mental-model.md                    # ER 図 / 関係代数の図解
  key-terms.md                       # エンティティ / 属性 / カーディナリティ / 主キー / 外部キー / 正規形

01-implementation/                   # 最小実装層
  walkthrough.md                     # 例: ブログ DB を ER 図 → DDL に落とすまで
  code/                              # SQL DDL / マイグレーション例
  self-explanation-prompts.md        # "なぜここを N 対 N にしたか" 系の自問

02-comparison/                       # 差別化比較層
  services-overview.md               # RDB / Document / KV / Graph / Time-series / Event Log
  why-each-exists.md                 # SQL の正規化 / Mongo のスキーマレス / Datomic のイベント / Neo4j の関係優位
  decision-matrix.md                 # ユースケース vs モデル選択

quiz/                                # 想起練習
  INDEX.md                           # 復習スケジュール
  01-recall-basic.md                 # 用語の自分の言葉での説明
  02-er-design.md                    # ER 図設計問題
  03-normalize.md                    # 非正規化テーブルを 3NF にする問題

_log/                                # 学習ログ
```

## 推奨学習順（同ジャンル内）

1. `00-concept/overview.md` を読み、「**なぜ表で世界を表現できるのか**」を自分の言葉で説明できるようにする
2. `00-concept/key-terms.md` で用語を 7±2 個ずつチャンク化（一気に全部覚えない）
3. `01-implementation/walkthrough.md` の Worked Example を **読む前に** 「自分なら何をエンティティにするか」を考える（Active Recall）
4. `01-implementation/code/` で実際に DDL を書く（Generation Effect）
5. `02-comparison/` で複数モデルを並べる。**比較が概念理解を強化** する（Variation Theory）
6. `quiz/01-recall-basic.md` から順番に。答えは別ファイル。

## 関連ジャンル

- `../persistence/`: モデル化したデータを「どう保存するか」の永続化レイヤ。データモデリングは前提
- `../state-and-time/`: 時系列データ / イベントソーシングはモデリングと永続化の境界にある
- `../auth-trust/`: RLS（Row Level Security）はスキーマと不可分

## 主な比較対象サービス（02-comparison/）

| カテゴリ     | 代表サービス                | 設計思想                               |
| ------------ | --------------------------- | -------------------------------------- |
| 関係モデル   | PostgreSQL / MySQL / SQLite | 表の集合 + 整合性 + 宣言的クエリ       |
| ドキュメント | MongoDB / Firestore         | スキーマレス、ネスト構造をそのまま保存 |
| キーバリュー | Redis / DynamoDB            | アクセスパターン主導の設計             |
| グラフ       | Neo4j / Amazon Neptune      | 関係が一級市民、深い JOIN 不要         |
| 時系列       | InfluxDB / TimescaleDB      | 時刻インデックスに最適化               |
| イベントログ | Datomic / Kafka + ksqlDB    | 不変イベント列から状態を導出           |

## Dreyfus 到達基準

| Lv. | できること                                                                   |
| --- | ---------------------------------------------------------------------------- |
| 1   | 主キー / 外部キー / テーブルが何かを口頭で説明できる                         |
| 2   | ブログ的な単純構造（投稿・コメント・ユーザー）を ER 図に落とせる             |
| 3   | N 対 N を中間テーブルで表現できる / 第 3 正規形まで自力で進められる          |
| 4   | 非正規化のトレードオフを論じられる / イベントソーシング vs CRUD を選択できる |
| 5   | ドメイン特性に応じて RDB / Document / Graph を使い分けるアーキテクトができる |
