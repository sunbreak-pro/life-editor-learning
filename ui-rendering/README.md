# UI Rendering — UI 描画レイヤ

> 「画面に出すべきものを、宣言的に組み立て、効率よく更新する」を扱うジャンル。仮想 DOM / コンポーネント / スタイル / アクセシビリティ。

## このジャンルが扱う問題

- なぜ「仮想 DOM」が生まれたのか — jQuery 時代と何が違うのか
- コンポーネント志向（Web Components / React / Vue）が解こうとした問題は何か
- リコンシリエーションは何をしていて、なぜそれが必要なのか
- CSS / Tailwind / CSS-in-JS / Styled — それぞれが解決した別問題は何か
- アクセシビリティ（WAI-ARIA）は「後付け」ではなく構造そのものに関わる
- Server-Side Rendering / Hydration / Streaming SSR / Islands は何の妥協で生まれたか

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # ブラウザ DOM の本質 / 命令的 vs 宣言的 UI / 仮想 DOM の誕生
  mental-model.md                    # コンポーネントツリー / リコンシリエーション図 / ライフサイクル
  key-terms.md                       # 仮想 DOM / Reconciliation / Hooks / Suspense / Hydration / a11y

01-implementation/
  walkthrough.md                     # React で TODO リスト / カウンタ / フォームを作る
  code/                              # 最小 React コンポーネント
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # React / Vue / Svelte / Solid / Web Components / vanilla
  why-each-exists.md                 # React の仮想 DOM / Vue の SFC / Svelte のコンパイル / Solid の Signals
  decision-matrix.md                 # アプリ規模 vs フレームワーク選択

quiz/
_log/
```

## 推奨学習順

1. `00-concept/overview.md` を読む前に、「ブラウザは画面をどう描画していると思うか」を自問
2. `00-concept/mental-model.md` で仮想 DOM とリコンシリエーションを図解で理解
3. `01-implementation/walkthrough.md` で React の最小コードを **見る前に** 「カウンタを vanilla JS で書くなら」を考える（比較対象を作る）
4. 実装ハンズオン → クイズ
5. `02-comparison/` で他フレームワーク（Vue / Svelte / Solid）が同じ問題をどう解いているか

## 関連ジャンル

- `../state-and-time/`: コンポーネントの状態は描画レイヤと密結合
- `../testing-and-quality/`: コンポーネントテストはこのジャンル特有
- `../network-and-async/`: データフェッチング戦略（TanStack Query / SWR）は描画と非同期の境界

## 主な比較対象サービス

| カテゴリ           | 代表                                              | 設計上の重点                                  |
| ------------------ | ------------------------------------------------- | --------------------------------------------- |
| 仮想 DOM 系        | React                                             | コンポーネント関数 + フック + 仮想 DOM diff   |
| SFC + リアクティブ | Vue 3                                             | Single File Component + Reactivity API        |
| コンパイル時最適化 | Svelte 5                                          | "no virtual DOM"、コンパイル時に DOM 操作生成 |
| Signals            | Solid / Preact Signals                            | 細粒度のリアクティビティ                      |
| ネイティブ         | Web Components / Lit                              | ブラウザ標準 / Shadow DOM                     |
| メタフレームワーク | Next.js / Nuxt / SvelteKit                        | SSR / SSG / Streaming / Islands               |
| スタイル           | Tailwind / CSS Modules / Styled / vanilla-extract | Utility-first vs Scoped vs Runtime CSS-in-JS  |

## Dreyfus 到達基準

| Lv. | できること                                                                |
| --- | ------------------------------------------------------------------------- |
| 1   | HTML / CSS の役割を説明し、ボタンを置いて押せるページを作れる             |
| 2   | React のコンポーネントとプロパティを使ってカウンタやフォームを作れる      |
| 3   | useEffect / useMemo を適切に使い、リフトアップやコンポジションができる    |
| 4   | リコンシリエーションを意識した最適化、a11y の構造的設計、SSR / CSR の選択 |
| 5   | フレームワーク選定 / アーキテクチャ移行 / カスタムレンダラ実装ができる    |
