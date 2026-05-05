---
Status: ACTIVE
Created: 2026-05-05
Related Task: data-modeling Phase 3 着手前の前提整備
Project: ~/dev/learning
---

# Plan: SQL 構文流暢性トラック（CRUD / 集約 / JOIN / サブクエリ集中演習）

## 1. Context

### 動機（なぜこのトラックを作るのか）

学習者は data-modeling Phase 1〜2.1 を完了した段階で、以下の状態にある:

- 概念（リレーショナルモデル / 正規化 / UNIQUE / ALTER の制限）は **理解できている**
- しかし **SQL を「書く」「読む」手が止まる**: サブクエリ・JOIN・基礎 CRUD の構文が曖昧
- 具体的な誤解の例:
  - `COUNT(*)` だと NULL 行は空白で表示され、`COUNT(カラム名)` で INTEGER カラムなら 0 と出る、と認識している
  - **正しくは**: 両者は「カウント結果（整数値）」を返すスカラーで、表示形式の違いではなく **「何を数えるか」が違う**
    - `COUNT(*)` = NULL を含む全行数
    - `COUNT(col)` = `col` が NULL でない行数

→ 概念理解だけ進めても、実装で詰まる時間が積み重なる。**「概念 → 最小実装 → 比較」の 01-implementation 層が薄い** ことが原因。

### 戦略

**ジャンル横断の前提層** (`00-foundations/sql-syntax/`) として SQL 構文の流暢性トラックを切り出す。data-modeling / persistence のどちらからも参照できる位置に置く。

各トピックは以下の **3 セット構成** で固定:

1. `intro.md` — そのトピックの **メンタルモデル**（動作の絵）+ 最小例
2. `examples.sql` — コメント付きで動かせる例（写経 → 改変で学ぶ）
3. `exercises.sql` + `exercises.answer.sql` — 想起練習用の演習ペア

### 制約

- データ範囲は **data-modeling の `walkthrough.sql` と同じスキーマ** を流用（tasks / users / projects / labels）。新規スキーマ学習コストをゼロにする
- 実行環境は **SQLite のみ**（`sqlite/playground/` で実行）。PostgreSQL / MySQL の方言比較は 02-comparison 段階で別途
- 1 トピック = 1 セッション（30〜60 分）で消化できる粒度に収める
- CLAUDE.md §6（飛躍防止）を遵守: 1 セッションで導入する新規用語は **7±2 個まで**

### Non-goals（このトラックでは扱わない）

- ウィンドウ関数（`ROW_NUMBER` / `RANK` / `OVER`）→ 上級
- CTE（`WITH 句`）→ 上級
- 性能チューニング / EXPLAIN / インデックス設計 → 後続の `data-modeling/00-concept/key-terms.md` および `persistence/`
- ストアドプロシージャ / トリガー → 上級
- SQL 標準と各 DB ベンダーの方言比較 → `02-comparison/` で扱う

---

## 2. トピック設計（5 本立て）

| #   | トピック              | 主な内容                                                                                                 | 所要  |
| --- | --------------------- | -------------------------------------------------------------------------------------------------------- | ----- |
| 01  | **CRUD 基礎パターン** | SELECT / INSERT / UPDATE / DELETE の最小形、WHERE / ORDER BY / LIMIT、複数行 INSERT、安全な DELETE 慣行  | 60 分 |
| 02  | **集約と GROUP BY**   | COUNT/SUM/AVG/MIN/MAX、`COUNT(*)` vs `COUNT(col)` の差、NULL の扱い、GROUP BY の動作モデル、HAVING/WHERE | 60 分 |
| 03  | **JOIN の動作モデル** | INNER / LEFT / 自己結合 / CROSS、何が増減するかの予測、ベン図メンタルモデル、ON と WHERE の違い          | 60 分 |
| 04  | **サブクエリ**        | スカラー / IN / EXISTS / 相関サブクエリ、JOIN との使い分け基準                                           | 60 分 |
| 05  | **工夫と慣用句**      | DISTINCT / UNION / CASE WHEN / COALESCE / NULLIF、NULL 三値論理の再確認                                  | 45 分 |

各トピック内の **想起練習スケジュール**: 完了直後 → 翌日 → 3 日後 → 1 週後 → 1 ヶ月後（CLAUDE.md §4 原則 2）。`quiz/INDEX.md` で管理。

### トピックごとの「最低限これだけは答えられる」ゴール

- **01 CRUD**: tasks テーブルで「全件取得」「ID 指定 1 件取得」「全 INSERT パターン」「条件付き UPDATE」「条件付き DELETE」を **見ずに書ける**
- **02 集約**: `COUNT(*)` と `COUNT(name)` の差を 3 ケースで説明できる、GROUP BY の結果行数を予測できる、`HAVING` を使う場面を 1 つ説明できる
- **03 JOIN**: `INNER JOIN` と `LEFT JOIN` の結果行数の差を予測できる、自己結合で「上司と部下を並べる」を書ける、`ON` と `WHERE` の評価順を説明できる
- **04 サブクエリ**: `IN (SELECT ...)` と `EXISTS (SELECT ...)` の差を例で示せる、相関サブクエリと非相関サブクエリの区別がつく
- **05 工夫**: `CASE WHEN` でランク分け、`COALESCE` で NULL を 0 に置換、`UNION` と `UNION ALL` の差を即答できる

---

## 3. ディレクトリ構造

```
00-foundations/                       # 既存ディレクトリ（必要時作成方針通り）
└── sql-syntax/                       # 新規トラック
    ├── README.md                     # トラック全体の地図 + 推奨順 + 進捗表
    ├── 01-crud/
    │   ├── intro.md                  # メンタルモデル + 最小例
    │   ├── examples.sql              # 動かせる例（コメント多め）
    │   ├── exercises.sql             # 演習問題（質問のみ）
    │   └── exercises.answer.sql      # 回答（ペア命名規約）
    ├── 02-aggregate/                 # 同上 4 ファイル
    ├── 03-join/                      # 同上 4 ファイル
    ├── 04-subquery/                  # 同上 4 ファイル
    ├── 05-utility/                   # 同上 4 ファイル
    ├── quiz/
    │   ├── INDEX.md                  # 全演習の復習スケジュール
    │   ├── 01-crud-recall.md
    │   ├── 01-crud-recall.answer.md
    │   └── ...（各トピックに 1〜2 問）
    └── _log/
        └── YYYY-MM-DD-<topic>.md     # セッションログ
```

### 命名規則（CLAUDE.md §2 準拠）

- 概念ファイル: 番号付き Markdown
- SQL ファイル: `*.sql`
- 回答ペア: `<問題名>.answer.<ext>`

---

## 4. Steps（実行順）

### Phase A: トラックの土台作り（次セッション冒頭）

- [ ] 1. `00-foundations/sql-syntax/README.md` 作成 — トラック地図 + 進捗チェックボックス
- [ ] 2. `00-foundations/sql-syntax/quiz/INDEX.md` 作成 — 復習スケジュールの空テンプレ

### Phase B: トピック 01 CRUD（1 セッション）

- [ ] 3. `01-crud/intro.md` — SELECT/INSERT/UPDATE/DELETE の対称性メンタルモデル
- [ ] 4. `01-crud/examples.sql` — `walkthrough.sql` のスキーマ流用、各命令 3〜5 例ずつ
- [ ] 5. `01-crud/exercises.sql` + `.answer.sql` — 演習 5 問
- [ ] 6. `quiz/01-crud-recall.md` + `.answer.md` — 想起問題 2 問

### Phase C: トピック 02 集約（1 セッション、誤解解消が最優先）

- [ ] 7. `02-aggregate/intro.md` — `COUNT(*)` vs `COUNT(col)` の動作を **絵 + 表** で示す（最重要）
- [ ] 8. `02-aggregate/examples.sql` — NULL 入りデータで集約挙動を実演
- [ ] 9. `02-aggregate/exercises.sql` + `.answer.sql` — 演習 5 問（うち 2 問は NULL 挙動）
- [ ] 10. `quiz/02-aggregate-recall.md` + `.answer.md`

### Phase D: トピック 03 JOIN（1 セッション）

- [ ] 11. `03-join/intro.md` — INNER / LEFT のベン図 + 行数予測モデル
- [ ] 12. `03-join/examples.sql` — tasks × users の各 JOIN パターン
- [ ] 13. `03-join/exercises.sql` + `.answer.sql` — 演習 5 問（うち 1 問は自己結合）
- [ ] 14. `quiz/03-join-recall.md` + `.answer.md`

### Phase E: トピック 04 サブクエリ（1 セッション）

- [ ] 15. `04-subquery/intro.md` — スカラー / IN / EXISTS / 相関の 4 分類フローチャート
- [ ] 16. `04-subquery/examples.sql` — JOIN との等価書き換え例を含める
- [ ] 17. `04-subquery/exercises.sql` + `.answer.sql` — 演習 5 問
- [ ] 18. `quiz/04-subquery-recall.md` + `.answer.md`

### Phase F: トピック 05 工夫と慣用句（1 セッション）

- [ ] 19. `05-utility/intro.md` — DISTINCT / UNION / CASE / COALESCE / NULLIF の使いどころ早見表
- [ ] 20. `05-utility/examples.sql` — 各慣用句の典型パターン
- [ ] 21. `05-utility/exercises.sql` + `.answer.sql` — 演習 5 問
- [ ] 22. `quiz/05-utility-recall.md` + `.answer.md`

### Phase G: 統合確認

- [ ] 23. `quiz/INDEX.md` の復習スケジュールを実行（少なくとも翌日復習を 1 周）
- [ ] 24. data-modeling Phase 3 を **見ずに** 自力で書けるか試す（外部キー設計 + INSERT/SELECT/JOIN）

---

## 5. Files

| File                                                               | Operation | Notes                                                               |
| ------------------------------------------------------------------ | --------- | ------------------------------------------------------------------- |
| `.claude/2026-05-05-sql-fluency-track.md`                          | Create    | 本設計書（このファイル）                                            |
| `00-foundations/`                                                  | Create    | 新規ディレクトリ（CLAUDE.md §2「必要時作成」方針通り初回生成）      |
| `00-foundations/sql-syntax/README.md`                              | Create    | トラック地図 + 進捗チェックボックス                                 |
| `00-foundations/sql-syntax/01-crud/intro.md`                       | Create    | メンタルモデル + 最小例                                             |
| `00-foundations/sql-syntax/01-crud/examples.sql`                   | Create    | 動かせる例                                                          |
| `00-foundations/sql-syntax/01-crud/exercises.sql`                  | Create    | 演習問題                                                            |
| `00-foundations/sql-syntax/01-crud/exercises.answer.sql`           | Create    | 回答ペア                                                            |
| `00-foundations/sql-syntax/02-aggregate/*` (4 files)               | Create    | 同パターン（COUNT 挙動誤解解消が主眼）                              |
| `00-foundations/sql-syntax/03-join/*` (4 files)                    | Create    | 同パターン                                                          |
| `00-foundations/sql-syntax/04-subquery/*` (4 files)                | Create    | 同パターン                                                          |
| `00-foundations/sql-syntax/05-utility/*` (4 files)                 | Create    | 同パターン                                                          |
| `00-foundations/sql-syntax/quiz/INDEX.md`                          | Create    | 復習スケジュール                                                    |
| `00-foundations/sql-syntax/quiz/0X-*.md` + `.answer.md` (10 files) | Create    | 各トピック 1〜2 問                                                  |
| `00-foundations/sql-syntax/_log/`                                  | Create    | セッションログ置き場（空でよい）                                    |
| `data-modeling/README.md`                                          | Update    | 「SQL 構文は別途 `00-foundations/sql-syntax/` を参照」を明記        |
| `.claude/MEMORY.md`                                                | Update    | 進行中タスクを「sql-syntax トラック」優先に切り替え（task-tracker） |
| `.claude/HISTORY.md`                                               | Update    | 設計書作成のセッションサマリを追記（task-tracker）                  |

---

## 6. Verification

トラック完成時に以下が **観測可能なシグナル** として満たされていること:

- [ ] V1. **誤解解消**: `COUNT(*)` と `COUNT(name)`（name に NULL を含むデータで）を実行し、結果数値の差を口頭で説明できる
- [ ] V2. **CRUD 流暢性**: tasks テーブルで「特定 user_id のタスクを全件削除」を **何も見ずに** 5 秒以内に書ける
- [ ] V3. **JOIN 行数予測**: `users` (3 件) と `tasks` (5 件、うち 1 件は user_id NULL) で `INNER JOIN` / `LEFT JOIN` 各々の結果行数を **実行前に** 予測できる
- [ ] V4. **サブクエリ判断**: 「タスクを 1 件以上持つユーザー」を `IN` / `EXISTS` / `JOIN+DISTINCT` の 3 通りで書ける
- [ ] V5. **慣用句使い分け**: `COALESCE(value, 0)` と `CASE WHEN value IS NULL THEN 0 ELSE value END` が等価であることを示せる
- [ ] V6. **想起定着**: `quiz/INDEX.md` のスケジュールが翌日 → 3 日 → 1 週まで 1 周している（学習科学原則 2）
- [ ] V7. **実戦応用**: data-modeling Phase 3〜6 の `walkthrough.sql` を読み返して詰まらない

---

## 7. 学習原則との対応（CLAUDE.md §4 参照）

| 原則                             | 本トラックでの実装                                                    |
| -------------------------------- | --------------------------------------------------------------------- |
| 1. 想起を先に、答えは後に        | `exercises.sql` を解いてから `.answer.sql` を見る運用                 |
| 2. 分散復習                      | `quiz/INDEX.md` で 1日→3日→1週→1ヶ月のスケジュール                    |
| 5. ワーキングサンプル先行        | `examples.sql` を写経してから `exercises.sql` に進む                  |
| 6. Self-Explanation              | 各 `intro.md` 末尾に「なぜ？」「他とどう違う？」の自問を必ず 2 問置く |
| 7. 概念 → 最小実装 → 比較の 3 層 | このトラックは **01-implementation 層を厚くする補助** として位置づけ  |
| 11. コードを書かせる             | `exercises.sql` を **手で打つ**（コピペ禁止）                         |
| 12. 意図的フィードバック練習     | 演習後に「予測 → 実行 → 差分の説明」を必ず行う                        |

---

## 8. 開始時の合意事項（次セッション冒頭で再確認）

1. data-modeling Phase 3 着手は **トピック 01 CRUD + 03 JOIN を完了してから** が望ましい（外部キー設計には最低限 SELECT + JOIN が必要）
2. ただし「学びながら都度参照」も可。詰まったら sql-syntax 該当トピックに戻る
3. 設計書の Steps はあくまで指針。トピック順は学習者の「今日詰まった部分」を優先して入れ替えて良い
4. `examples.sql` / `exercises.sql` は **`sqlite/playground/` で実行** する（教材ディレクトリでは実行しない）
