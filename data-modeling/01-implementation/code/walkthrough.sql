-- ============================================================
-- data-modeling walkthrough — 重複・外部キー・サブクエリ・NULL
-- ============================================================
-- 使い方:
--   sqlite3 /tmp/learning.db < walkthrough.sql
-- またはインタラクティブに:
--   sqlite3 /tmp/learning.db
--   sqlite> .read /Users/newlife/dev/learning/data-modeling/01-implementation/code/walkthrough.sql
--
-- 各 Phase ごとに区切ってあるので、コピペで 1 つずつ流すのも可。
-- ============================================================

-- 既存テーブルを綺麗にする（このスクリプトを何度も流せるように）
DROP TABLE IF EXISTS tasks_v2;
DROP TABLE IF EXISTS tasks_v1;
DROP TABLE IF EXISTS users;

PRAGMA foreign_keys = ON;  -- SQLite はデフォルト OFF。明示的に有効化が必須


-- ============================================================
-- Phase 1: 重複ありの愚直設計
-- ============================================================

CREATE TABLE tasks_v1 (
  id            INTEGER PRIMARY KEY,
  title         TEXT NOT NULL,
  assignee_name TEXT  -- ← 担当者名を直接持つ。これが今回の罠
);

INSERT INTO tasks_v1 (id, title, assignee_name) VALUES
  (1, 'Phase 0 整理',     'Taro'),
  (2, 'Phase 1 設計',     'Taro'),
  (3, 'Phase 1 実装',     'Hanako'),
  (4, 'Phase 2 移行',     'taro'),    -- typo（小文字）
  (5, 'Phase 2 リリース', 'Tarou');   -- 改名後の名前を勝手に書いた


-- ============================================================
-- Phase 2: 重複の症状を SQL で観察
-- ============================================================

-- 2.1 表記揺れの可視化（人間にとっては全部 Taro のつもりだが…）
SELECT DISTINCT assignee_name FROM tasks_v1 ORDER BY assignee_name;

-- 2.2 検索漏れ: 'Taro' だけしか引けない
SELECT * FROM tasks_v1 WHERE assignee_name = 'Taro';

-- 2.3 改名を反映するのに O(N) かかり、typo は拾えない
UPDATE tasks_v1 SET assignee_name = 'Tarou' WHERE assignee_name = 'Taro';
SELECT * FROM tasks_v1;
-- ↑ id=4 の 'taro' は変わらない（別文字列扱い）。半分壊れた状態


-- ============================================================
-- Phase 3: users テーブル + 外部キー で直す
-- ============================================================

CREATE TABLE users (
  id    INTEGER PRIMARY KEY,
  name  TEXT NOT NULL UNIQUE  -- 同名重複を DB レベルで禁止
);

CREATE TABLE tasks_v2 (
  id           INTEGER PRIMARY KEY,
  title        TEXT NOT NULL,
  assignee_id  INTEGER REFERENCES users(id)  -- 外部キー
);

INSERT INTO users (id, name) VALUES
  (1, 'Taro'),
  (2, 'Hanako');

INSERT INTO tasks_v2 (id, title, assignee_id) VALUES
  (1, 'Phase 0 整理',     1),
  (2, 'Phase 1 設計',     1),
  (3, 'Phase 1 実装',     2),
  (4, 'Phase 2 移行',     1),
  (5, 'Phase 2 リリース', 1);


-- 改名は 1 行更新で済む（参照側 tasks_v2 は触らない）
UPDATE users SET name = 'Tarou' WHERE id = 1;

-- 結果確認: タスク + 担当者名（JOIN は Phase 5 で詳説）
SELECT t.id, t.title, u.name AS assignee
  FROM tasks_v2 t LEFT JOIN users u ON u.id = t.assignee_id
  ORDER BY t.id;


-- 参照整合性のデモ: 存在しない user_id を入れようとするとエラー
-- INSERT INTO tasks_v2 (id, title, assignee_id) VALUES (99, 'Bad', 999);
-- → Error: FOREIGN KEY constraint failed


-- ============================================================
-- Phase 4: WHERE col IN (SELECT ...) — 集合所属テスト
-- ============================================================

-- 4.1 内側のサブクエリだけ実行（集合を確認）
SELECT id FROM users WHERE name LIKE 'T%';
-- → {1}

-- 4.2 IN で外側に組み合わせる
SELECT * FROM tasks_v2
  WHERE assignee_id IN (SELECT id FROM users WHERE name LIKE 'T%');

-- 4.3 IN は値リストでも書ける
SELECT * FROM tasks_v2 WHERE assignee_id IN (1, 2);


-- ============================================================
-- Phase 5: IN 以外の「複数の値にマッチ」— OR / JOIN / EXISTS
-- ============================================================

-- 5.1 OR チェーン（IN と等価。冗長）
SELECT * FROM tasks_v2
  WHERE assignee_id = 1 OR assignee_id = 2;

-- 5.2 JOIN — 関連テーブルの列も同時に取れる
SELECT t.id, t.title, u.name AS assignee
  FROM tasks_v2 t
  INNER JOIN users u ON u.id = t.assignee_id
  WHERE u.name LIKE 'T%';

-- 5.3 EXISTS — 「条件を満たす行が 1 つでも存在するか」
SELECT * FROM tasks_v2 t
  WHERE EXISTS (
    SELECT 1 FROM users u
      WHERE u.id = t.assignee_id AND u.name LIKE 'T%'
  );


-- ============================================================
-- Phase 6: NULL の挙動 — 三値論理
-- ============================================================

-- 6.1 担当者未定タスクを追加（assignee_id を省略 → NULL）
INSERT INTO tasks_v2 (id, title) VALUES (6, 'Phase 3 計画(担当未定)');

-- 6.2 = NULL は何も返さない（TRUE/FALSE/UNKNOWN の三値論理）
SELECT * FROM tasks_v2 WHERE assignee_id = NULL;
-- → 0 行

-- 6.3 IS NULL を使う
SELECT * FROM tasks_v2 WHERE assignee_id IS NULL;
-- → id=6 だけ返る

-- 6.4 IS NOT NULL
SELECT * FROM tasks_v2 WHERE assignee_id IS NOT NULL;

-- 6.5 集計関数と NULL
SELECT
  COUNT(*)            AS total_rows,        -- 全行（NULL 含む）= 6
  COUNT(assignee_id)  AS assigned_count,    -- NULL を除く = 5
  COUNT(DISTINCT assignee_id) AS distinct_assignees
FROM tasks_v2;

-- 6.6 NULL を 0 や別値として扱う
SELECT id, title, COALESCE(assignee_id, -1) AS assignee_or_unassigned
  FROM tasks_v2 ORDER BY id;


-- ============================================================
-- 終了。クリーンアップしたいなら以下を流す:
-- ============================================================
-- DROP TABLE tasks_v2;
-- DROP TABLE tasks_v1;
-- DROP TABLE users;
