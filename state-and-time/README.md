# State and Time — 状態管理と並行性

> 「変化するデータを、どこに置き、いつ・誰が・どう更新するか」を扱うジャンル。状態管理ライブラリ / 楽観的 UI / race condition / 時刻と整合性。

## このジャンルが扱う問題

- なぜ「グローバル変数で全部やる」では破綻するのか — 状態の局所性
- React の useState / useReducer で済むのに、Redux / Zustand が要る場面はいつか
- 楽観的 UI（Optimistic Update）が「気持ちいい」だけでなく構造的に必要な理由
- 並行更新（race condition）は実装ミスではなく **モデリングの問題**
- 時刻同期 / Last-Write-Wins / CRDT / OT — Realtime Sync はなぜ難しいか
- イベントソーシングと CQRS — 状態を「現在値」ではなく「履歴」で持つ意味

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # 状態とは / 局所状態と共有状態 / 並行性の本質
  mental-model.md                    # 状態遷移図 / Race Condition の図解 / イベントログ vs スナップショット
  key-terms.md                       # State / Reducer / Action / Optimistic UI / LWW / CRDT / Eventual Consistency

01-implementation/
  walkthrough.md                     # 楽観的 UI 付き TODO アプリ + race condition を意図的に起こして観測
  code/
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # Redux / Zustand / Jotai / Context / Signals / MobX / XState
  why-each-exists.md                 # Redux の Action / Zustand の minimal / Jotai の atomic / XState の有限状態
  decision-matrix.md

quiz/
_log/
```

## 推奨学習順

1. **前提**: `../ui-rendering/` の useState / useEffect が触れること
2. `00-concept/overview.md` で「グローバル変数で済むなら何故ダメか」を考える
3. `01-implementation/walkthrough.md` で **意図的に race condition を起こす**（見えない状態を見える化）
4. `02-comparison/` で Redux / Zustand / Jotai を **同じ TODO アプリ** で書き分ける（Variation Theory）
5. CRDT / Realtime Sync は Lv.4 として後回し

## 関連ジャンル

- `../ui-rendering/`: 状態は描画と一体
- `../persistence/`: 永続化された状態はサーバー側に住む
- `../network-and-async/`: 楽観的 UI は通信遅延をどう隠すかの問題

## 主な比較対象サービス

| カテゴリ           | 代表                             | 設計上の重点                        |
| ------------------ | -------------------------------- | ----------------------------------- |
| Flux / Action 駆動 | Redux / Redux Toolkit            | 単一 store / 純粋関数による更新     |
| Minimal store      | Zustand                          | 最小ボイラープレート / Hook 統合    |
| Atomic             | Jotai / Recoil                   | atom 単位 / 細粒度の購読            |
| Reactivity         | MobX / Solid Signals             | proxy / signals による自動追跡      |
| State machine      | XState                           | 有限状態 + ガード + 並行リージョン  |
| Server state       | TanStack Query / SWR / RTK Query | キャッシュ + 再フェッチ + 楽観的 UI |
| Realtime / CRDT    | Yjs / Automerge / Liveblocks     | 共同編集 / オフライン耐性           |

## Dreyfus 到達基準

| Lv. | できること                                                                      |
| --- | ------------------------------------------------------------------------------- |
| 1   | ローカル変数とコンポーネント状態の違いを説明できる                              |
| 2   | useState / useReducer で TODO アプリの状態を管理できる                          |
| 3   | リフトアップ / コンテキストの選び方を判断、楽観的 UI を実装できる               |
| 4   | race condition を再現させ修正できる、状態管理ライブラリを問題に応じて選択できる |
| 5   | CRDT / OT / イベントソーシングを使い分け、Realtime Sync をゼロから設計できる    |
