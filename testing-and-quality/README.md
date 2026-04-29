# Testing and Quality — テスト戦略と静的解析

> 「壊れない / 壊れたら気づく / 壊さずに変えられる」を扱うジャンル。テストピラミッド / TDD / 型安全性 / 静的解析 / プロパティテスト。

## このジャンルが扱う問題

- なぜテストを書くのか — リグレッション防止だけでなく **設計のフィードバック**
- テストピラミッド（Unit / Integration / E2E）の比率は何で決まるのか
- TDD は本当に効くのか — 研究的にはどう評価されているか
- モックは「便利な道具」と「テストを腐らせる毒」の両面性
- 型システムはテストの代替か補完か
- プロパティベーステスト / ファジングは「例ベース」と何が違うのか

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # テストの目的 / リグレッション vs 設計フィードバック / ピラミッドの哲学
  mental-model.md                    # テストの依存関係図 / モックの境界 / 型 vs テスト
  key-terms.md                       # Unit / Integration / E2E / TDD / Mock / Fixture / Coverage / Mutation

01-implementation/
  walkthrough.md                     # Vitest で純粋関数 / コンポーネント / Playwright で E2E
  code/
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # Vitest / Jest / Playwright / Cypress / Storybook / TypeScript / ESLint
  why-each-exists.md                 # 各ツールの誕生背景
  decision-matrix.md

quiz/
_log/
```

## 推奨学習順

1. `00-concept/` で「テストは何のためにあるか」を **設計フィードバック** の側面から理解
2. `01-implementation/` で純粋関数テスト → コンポーネントテスト → E2E と段階を踏む
3. `02-comparison/` で Vitest と Jest、Playwright と Cypress を並べる
4. プロパティテスト / Mutation Testing は Lv.4 として後回し

## 関連ジャンル

- 全ジャンルに横断的に関わる
- 特に `../ui-rendering/`: コンポーネントテストの設計思想
- 特に `../persistence/`: 統合テストにおける DB 扱い（実 DB vs インメモリ vs モック）

## 主な比較対象サービス

| カテゴリ                  | 代表                                    | 設計上の重点                 |
| ------------------------- | --------------------------------------- | ---------------------------- |
| ユニット / コンポーネント | Vitest / Jest                           | Vite ネイティブ / 古参標準   |
| E2E                       | Playwright / Cypress                    | マルチブラウザ / DX          |
| コンポーネント環境        | Storybook                               | 隔離環境 + Visual Regression |
| 型システム                | TypeScript / Flow                       | 静的検査 / 型推論            |
| 静的解析                  | ESLint / Biome / oxlint                 | 規約強制 / 速度              |
| プロパティテスト          | fast-check / Hypothesis (Python)        | 不変条件の探索               |
| Visual Regression         | Chromatic / Percy / Playwright Snapshot | スクリーンショット差分       |
| Mutation Testing          | Stryker                                 | テストの質を測る             |

## Dreyfus 到達基準

| Lv. | できること                                                              |
| --- | ----------------------------------------------------------------------- |
| 1   | assert / expect を使ったユニットテストの読み書きができる                |
| 2   | Vitest で関数とコンポーネントの基本テストを書ける                       |
| 3   | テストピラミッドを理解し、モック境界を引ける、CI に組み込める           |
| 4   | TDD でリファクタリングを駆動、E2E の安定性問題を扱える、型で防御できる  |
| 5   | テスト戦略を組織で導入、Mutation / Property / Visual を組み合わせられる |
