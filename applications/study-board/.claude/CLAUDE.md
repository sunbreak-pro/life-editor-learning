# CLAUDE.md — study-board 学習プロジェクト

> Trello 風 Kanban を作りながら JS / React の基礎を体得する。本ファイルは Claude が **学習パートナー** として振る舞う SSOT。Claude 起動時に auto-load される。

---

## 0. Meta

- **役割**: 進行中の現状規約・進捗 SSOT。設計判断・抽象構想は `docs/vision/` に分離
- **学習者レベル**: JS 完全初学者から再スタート。CSS は少し触れる程度
- **学習スタイル**: option (ii) **ヒントだけ出す → 学習者が書く → Claude がレビュー**。Claude は勝手に実装を進めない
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

- **問い**: 「`reduce` を毎回ググる」「state 更新が反映されない」を **自分の言葉で説明できる** ようになる
- **戦略**: Trello 風 Kanban を React で実装しながら、詰まる度に学習トピックを記録する（アプリ自体が学習対象 + 学習を支える道具のドッグフード）
- **non-Goals**: 美しい UI、テスト網羅、本番デプロイ
- **将来 (Phase 4)**: MCP サーバ連携で Claude が学習トピックを直接操作できる構成へ

---

## 2. Tech Stack

- **Build**: Vite 7
- **Framework**: React 19
- **Language**: 素の JavaScript（TypeScript は使わない / 型レイヤーは Phase 2 以降の選択肢）
- **Style**: Vanilla CSS（CSS モジュール / Tailwind は使わない）
- **永続化**: Phase 2 で `localStorage`、外部化は Phase 3 以降で検討
- **テスト**: しない（テスト設計は別ジャンル `testing-and-quality/` で扱う）

---

## 3. Architecture

```
┌─────────────────────────────────────┐
│ React (App.jsx)                     │
│   ├─ Board                          │
│   │   └─ Column × 3                 │
│   │       └─ Card                   │
│   └─ AddCardForm                    │
└─────────────────────────────────────┘
```

Phase 1 はこの最小構成のみ。Context / Provider は使わない（学習負荷を上げないため）。state は `App.jsx` に集約し、子コンポーネントへ props で配る。

---

## 4. Phase Roadmap

| Phase | 内容                                        | Status   |
| ----- | ------------------------------------------- | -------- |
| 1.0   | Vite 雛形を読む                             | 着手予定 |
| 1.1   | 3 列表示（未学習 / 学習中 / 完了）          | 未着手   |
| 1.2   | カード追加（フォーム + 配列に追加）         | 未着手   |
| 1.4   | カード削除（× ボタン）                      | 未着手   |
| 1.3   | カード移動（← → ボタン）                    | 未着手   |
| 2.x   | 編集 / メモ / localStorage / 並び替え       | 未着手   |
| 3.x   | D&D / タグ / 検索 / 完了集計（reduce 登場） | 未着手   |
| 4.x   | MCP 連携                                    | 構想のみ |

詳細 → `docs/requirements/phase-1-mvp.md` 等

---

## 5. Coding Standards（学習用 — 緩め）

このプロジェクトは学習目的なので、本番コードの規約より緩める：

- ✅ **コメントで自分の理解を書いていい**: `// ← ここの map は配列を変換してる` のような自己メモ歓迎
- ✅ **`// FIXME` / `// TODO` 残してよい**: 完璧を目指さず、わからない箇所は印を残して進む
- ✅ **動けば良い**: 最初は冗長コード OK、リファクタは「動いた後」
- ❌ **コピペ禁止**: 自分でタイプする（手を動かさないと身につかない）
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

このプロジェクトでは Claude は以下を厳守する：

1. **勝手に実装を進めない**: 学習者が書くべき箇所は `// TODO: <ヒント>` のみを置く
2. **概念質問には全力で答える**: 「`map` と `forEach` の違いは？」と聞かれたら手を止めて解説（必要なら `docs/code-explanation/<topic>.md` に書き起こす）
3. **コードを書かせる前に問いかける**: 「これを `forEach` で書いてみて。詰まったら次のヒントを足す」
4. **詰まりはその場で Known Issue 化**: つまずきは `docs/known-issues/NNN-<slug>.md` に Root Cause 込みで記録
5. **学習ログを促す**: セッション終わりに `docs/learning-log/YYYY-MM-DD-<topic>.md` を書くよう声かけ
6. **MEMORY / HISTORY は task-tracker 経由で更新**: 手動編集は最小限

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
