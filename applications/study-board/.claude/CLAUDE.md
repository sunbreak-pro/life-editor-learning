# CLAUDE.md — study-board 学習プロジェクト

> Trello 風 Kanban を作りながら JS / React の基礎を体得する。本ファイルは Claude が **学習パートナー** として振る舞う SSOT。Claude 起動時に auto-load される。

---

## 0. Meta

- **役割**: 進行中の現状規約・進捗 SSOT。設計判断・抽象構想は `docs/vision/` に分離
- **学習者レベル**: JS 完全初学者から再スタート。CSS は少し触れる程度
- **学習スタイル**: option (i) **Claude が書く → 学習者が読む / 質問する / 必要なら微修正**（2026-05-06 に option (ii) から変更）。コードには WHY コメントを十分に入れる。新規概念は実装前に簡単な解説。
- **更新規則**: 実装変更を伴う変更はコードと同一コミットで本ファイルを更新

### 関連ドキュメント

| パス                                    | 用途                                     |
| --------------------------------------- | ---------------------------------------- |
| `MEMORY.md`                             | 進行中の Phase / トピック                |
| `HISTORY.md`                            | セッション単位の学習ログ（降順）         |
| `docs/vision/core.md`                   | なぜ作るか / 設計判断 / MCP 統合（将来） |
| `docs/requirements/learning-roadmap.md` | 20 トピック学習ロードマップ              |
| `docs/requirements/phase-1-mvp.md`      | Phase 1 機能仕様                         |
| `docs/known-issues/INDEX.md`            | つまずきパターン索引                     |
| `docs/learning-log/`                    | セッション毎に自分の言葉で書く学習記録   |
| `docs/code-explanation/`                | Claude が概念解説を書き起こす置き場      |

---

## 1. Vision（要約）

詳細 → `docs/vision/core.md`

- **問い**: 「`reduce` を毎回ググる」「state 更新が反映されない」を **自分の言葉で説明できる** ようになる + 自分の勉強進捗を「次に何をやるか」レベルで一目で見える化する
- **対象ドメイン**: プログラミング学習 + その他の勉強（資格 / 本 / 語学 等）— カードに `category` を持たせ両立
- **戦略**: 学習者本人の勉強ダッシュボードをドッグフード開発しながら、詰まる度に学習トピックを記録する（アプリ自体が学習対象 + 学習を支える道具）
- **主要ビュー**（段階導入）:
  - Phase 1: **Kanban**（未学習 / 学習中 / 完了）+ カテゴリフィルタ + 完了率バー
  - Phase 2: **Roadmap / Tree view**（親子関係で階層表示）
  - Phase 3: **高度ダッシュボード** / メモ / 検索
- **non-Goals**: 美しい UI、テスト網羅、本番デプロイ
- **将来 (Phase 4)**: MCP サーバ連携で Claude が学習トピックを直接操作できる構成へ

---

## 2. Tech Stack

- **Build**: Vite 7
- **Framework**: React 19
- **Language**: 素の JavaScript（TypeScript は使わない / 型レイヤーは別ジャンル `testing-and-quality/` で扱う）
- **Style**: Vanilla CSS（CSS モジュール / Tailwind は使わない）
- **永続化**: **Phase 1 から `localStorage`**（state と永続化の概念を早期に同時習得）。外部化は Phase 3 以降で検討
- **状態管理**: `App.jsx` 集約 → Phase 2 で Context API 検討（prop drilling が辛くなったら）
- **ルーティング**: 入れない（ビュー切替は state ベース。React Router は Phase 3 以降で検討）
- **テスト**: しない（テスト設計は別ジャンル `testing-and-quality/` で扱う）

---

## 3. Architecture

### Phase 1（Kanban view）

```
┌─────────────────────────────────────────────┐
│ App.jsx (state 集約: cards / categories)    │
│   ├─ Header                                 │
│   │   ├─ AddCardForm                        │
│   │   ├─ CategoryFilter                     │
│   │   └─ ProgressBar (完了率)               │
│   └─ Board                                  │
│       └─ Column × 3                         │
│           └─ Card (← → 移動 / × 削除)       │
└─────────────────────────────────────────────┘
```

state は `App.jsx` に集約し、子コンポーネントへ props で配る。Context / Provider は使わない（学習負荷を上げないため。Phase 2 で再検討）。

### データモデル（Phase 1）

```js
// localStorage に保存される 1 件
Card {
  id: string,                          // 'card-' + Date.now()
  title: string,
  status: 'todo' | 'doing' | 'done',
  category: string,                    // 'programming' | 'general' | 任意
  createdAt: string,                   // ISO 8601
  notes?: string                       // Phase 2 で活用
}
```

Phase 2 で `parentId?: string` を追加してツリー化（ロードマップビュー）。

---

## 4. Phase Roadmap

| Phase | 内容                                             | Status   |
| ----- | ------------------------------------------------ | -------- |
| 1.0   | Vite 雛形を読む（`.render` 解説含む）            | 進行中   |
| 1.1   | 3 列表示（未学習 / 学習中 / 完了）               | 未着手   |
| 1.2   | カード追加（タイトル + カテゴリ選択）            | 未着手   |
| 1.3   | カード削除（× ボタン）                           | 未着手   |
| 1.4   | カード移動（← → ボタン）                         | 未着手   |
| 1.5   | localStorage 永続化（`useEffect` + custom hook） | 未着手   |
| 1.6   | カテゴリフィルタ                                 | 未着手   |
| 1.7   | 完了率を上部に表示（`reduce` 初登場）            | 未着手   |
| 2.x   | Roadmap / Tree view（parentId / View 切替）      | 未着手   |
| 3.x   | 高度ダッシュボード / メモ / 検索 / D&D           | 未着手   |
| 4.x   | MCP 連携                                         | 構想のみ |

詳細 → `docs/requirements/phase-1-mvp.md` 等

---

## 5. Coding Standards（学習用 — 緩め）

このプロジェクトは学習目的なので、本番コードの規約より緩める：

- ✅ **Claude のコードには WHY コメント必須**: 「なぜ `useState` を使うか」「なぜ `e.preventDefault()` か」を 1 行で書く（option (i) の前提）
- ✅ **学習者は読むコードに自分の理解を追記してよい**: `// ← 自分の理解: ここで配列を変換してる` のような追記歓迎
- ✅ **`// FIXME` / `// TODO` 残してよい**: 完璧を目指さず、わからない箇所は印を残して進む
- ✅ **動けば良い**: 最初は冗長コード OK、リファクタは「動いた後」
- ❌ **学習者が「とりあえず動いた」で終わらせない**: 各 Phase 完了時に learning-log を書く（書けないなら理解していない）
- ❌ **意味不明なまま進めない**: 1 行でもわからない箇所があれば即質問

### 命名規則

| 種別             | 規則                 | 例                |
| ---------------- | -------------------- | ----------------- |
| コンポーネント   | PascalCase           | `Card.jsx`        |
| 変数・関数       | camelCase            | `addCard`         |
| 定数             | SCREAMING_SNAKE_CASE | `INITIAL_COLUMNS` |
| イベントハンドラ | `handle` 接頭辞      | `handleAddClick`  |

---

## 6. Claude 振る舞い規約（最重要）

このプロジェクトでは Claude は以下を厳守する（**option (i)** スタイル）:

1. **Claude が完成コードを書く**: 学習者が読んで理解することが目的。`// TODO: <ヒント>` を置いて待つ運用は **行わない**（2026-05-06 に option (ii) から変更）
2. **コードには WHY コメントを十分に入れる**: 「なぜ `useState` か」「なぜ spread 演算子か」が読者に伝わるように
3. **新規概念は実装前に簡単な解説を添える**: useState 初登場 / useEffect 初登場 / `reduce` 初登場 のように、「初出」のタイミングで 5〜10 行の前置き解説 → 必要に応じて `docs/code-explanation/<topic>.md` に詳細
4. **学習者の「ここどういう意味？」に手を止めて答える**: その場で会話 + 重要なら `docs/code-explanation/` に書き起こす
5. **学習者が微修正を試みた箇所は肯定的にレビュー**: 動いていれば OK、改善余地があれば「こう書くともっと読みやすい」を提示
6. **詰まりはその場で Known Issue 化**: つまずきは `docs/known-issues/NNN-<slug>.md` に Root Cause 込みで記録
7. **学習ログを促す**: セッション終わりに `docs/learning-log/YYYY-MM-DD-<topic>.md` を書くよう声かけ
8. **MEMORY / HISTORY は task-tracker 経由で更新**: 手動編集は最小限

---

## 7. Document System

### Vision → 実装プラン → 統合 フロー

1. **Vision**（抽象 / 設計原則）: `docs/vision/`
2. **実装プラン / Phase 仕様**: `docs/requirements/`
3. **完了 Phase**: `archive/` 移動、判断理由は `docs/vision/` に残す
4. **MEMORY.md / HISTORY.md** はセッション単位で同期

### Known Issue ライフサイクル

つまずいた瞬間に `docs/known-issues/NNN-<slug>.md` を Status=Active で作成 → 解決時に Status=Fixed + Resolved 日付 + Lessons Learned 追記。類似バグに遭遇したらまず INDEX を grep。

### Learning Log ライフサイクル

セッション終了時 / 大きな概念を理解した時に `docs/learning-log/YYYY-MM-DD-<topic>.md` を書く。**コピペ禁止 / 自分の言葉**。書けないなら理解してない（完了マークを付けない）。
