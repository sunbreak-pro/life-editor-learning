# sqlite/ — SQLite 学習サンドボックス

> 自分の手で SQL を書いて試すための場所。教材（`data-modeling/01-implementation/code/walkthrough.sql` 等）とは分離する。

---

## ディレクトリ構造

```
sqlite/
├── README.md          # 本ファイル
├── playground/        # 自分で書く .sql ファイル（git で track する）
└── db/                # .db ファイル置き場（git ignore される）
```

- `playground/` — 自由に試した SQL をファイル化して残す。**履歴が学習資産になる**
- `db/` — SQLite が生成する DB ファイル。`.gitignore` で `*.db` 系を全除外済み

---

## 起動コマンド（学習ディレクトリのルートから）

```bash
sqlite3 sqlite/db/learning.db
```

DB ファイルは存在しなければ自動作成。`.quit` するまで対話モードに入る。

### 推奨: 起動時に表示モードを整える

```
sqlite> .headers on
sqlite> .mode column
```

毎回打つのが面倒なら `~/.sqliterc` に書いておくと自動適用される（任意）。

---

## ファイルから SQL を実行する 2 通り

### A. 対話モード内から `.read`

```
sqlite> .read sqlite/playground/01-data-modeling-recall.sql
```

→ 結果は対話モードに流れる。続きの `SELECT` も自由に打てる。**学習にはこちら推奨**。

### B. 一括バッチ実行

```bash
sqlite3 sqlite/db/learning.db < sqlite/playground/01-data-modeling-recall.sql
```

→ 全部流れて即終了。確認用・回帰テスト用。

---

## 命名規則（推奨）

| パターン             | 用途                          | 例                            |
| -------------------- | ----------------------------- | ----------------------------- |
| `<番号>-<topic>.sql` | ジャンル / 単元単位の積み上げ | `01-data-modeling-recall.sql` |
| `scratch-<日付>.sql` | 使い捨ての実験                | `scratch-2026-05-05.sql`      |

**回答ファイル**は `code-teacher` 規約と揃えて `<元名>.answer.sql` で（quiz/ 配下と同じ規則）。

---

## .gitignore の方針

- `*.db` / `*.db-journal` / `*.db-shm` / `*.db-wal` / `*.sqlite` / `*.sqlite3` は除外
- 理由: バイナリで diff が読めない / 実行時の状態に依存する / サイズが膨らみやすい
- `.sql` は **track する**（学習履歴 = 自分の理解の進捗を残す）

---

## 学習中の注意

- DB ファイルが壊れた・状態が分からなくなったら、**気軽に `db/learning.db` を消してやり直す**（教材スクリプトは何度流しても OK な設計になっている）
- 再起動するたびに `PRAGMA foreign_keys = ON;` は **接続ごとにリセット** されるので必要なら毎回打つ
- 複数行 SQL は **`;` で締めるまで実行されない**。プロンプトが `...>` のままなら `;` を入れる
