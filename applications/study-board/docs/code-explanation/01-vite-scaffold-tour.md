# 01 — Vite 雛形見取り図 (`main.jsx`) 統合解読

> 目的: study-board の起動口である `src/main.jsx` (10 行) を **すべての構文要素が文脈で繋がる** ように読み解く。各構文の深掘りに加え、Java（学習者が研修で先行学習中）/ TypeScript との差別化も並走する。

---

## 0. 全体マップ — 「main.jsx の 10 行は実は 4 ブロック」

```jsx
// main.jsx (study-board/src/main.jsx:1-11)
import { StrictMode } from "react"; // ┐
import { createRoot } from "react-dom/client"; // │  ブロック A
import "./index.css"; // │  ── 道具を取り込む
import App from "./App.jsx"; // ┘

createRoot(document.getElementById("root")).render(
  //          └────── B: 場所を探す ─────┘
  //└────────── C: ルートを作る ──────────┘
  //                                       └─── D: 中身を描画 ────┐
  <StrictMode>
    {" "}
    // │
    <App /> // │
  </StrictMode>, // │
); // ┘
```

**4 ブロックの目的**:

| ブロック | 役割                                        | 主に関わる層         |
| -------- | ------------------------------------------- | -------------------- |
| A        | 別ファイルから道具を取り込む                | JS 言語仕様（ESM）   |
| B        | HTML 上の「描画する場所」を取得する         | ブラウザ DOM API     |
| C        | その場所に React の支配下となるルートを作る | React-DOM ライブラリ |
| D        | ルートに JSX で記述した UI を流し込む       | React + JSX 構文     |

> **重要**: 最後の 5 行 (`createRoot(...).render(<StrictMode>...</StrictMode>,)`) は **1 つの式が縦に伸びているだけ**。横に潰すとこうなる:
>
> ```js
> createRoot(document.getElementById("root")).render(
>   <StrictMode>
>     <App />
>   </StrictMode>,
> );
> ```

---

## 1. ブロック A: ESM import 群 — 3 つの顔

`main.jsx` の 1〜4 行目には **3 つの異なる形** の `import` が並んでいる。同じキーワードでも意味が違う。

```jsx
import { StrictMode } from "react"; // ① 名前付き import (named)
import { createRoot } from "react-dom/client"; // ① 名前付き import (named)
import "./index.css"; // ② 副作用 import (side-effect)
import App from "./App.jsx"; // ③ デフォルト import (default)
```

### ① 名前付き import — `import { X } from 'pkg'`

「pkg というモジュールが `export` している **名前 X** という値を取り込む」

- 元のモジュール側で `export const StrictMode = ...` のように **名前付きで公開** されている前提
- 取り込む側でも **同じ名前** を `{}` の中に書く (改名する場合は `as` を使う: `{ StrictMode as SM }`)
- 1 つのモジュールから複数取れる: `import { useState, useEffect } from 'react'`

### ② 副作用 import — `import './file.css'`

「このファイルを読み込め。**取り込む値はない**。実行されることに意味がある」

- CSS の場合: Vite (バンドラ) が CSS を集めて `<style>` タグや CSS ファイルとしてページに注入する
- JS でも `import './polyfill.js'` のように「**読み込まれた事実**」が大事な場合に使う

### ③ デフォルト import — `import X from 'pkg'`

「pkg が **デフォルトとして 1 つだけ** 公開している値を、好きな名前 X で受け取る」

- 元のモジュール側で `export default ...` で公開されている前提
- 取り込む側で名前を **自由に** 付けられる (元の名前と一致しなくて良い)
- `App.jsx` の最終行 `export default App` がこれと対応

### Java との差別化

| 観点                       | Java                                             | JavaScript (ESM)                                      |
| -------------------------- | ------------------------------------------------ | ----------------------------------------------------- |
| import の対象              | **クラス / インタフェース / static メンバー**    | **値ならなんでも** (関数・オブジェクト・プリミティブ) |
| ファイルとパッケージの関係 | パッケージ階層 = ディレクトリ階層が **強制**     | ファイルパスを直接指定。階層は自由                    |
| デフォルト輸出の概念       | **無い** (常に名前付き)                          | `export default` がある (1 ファイル 1 個まで)         |
| 副作用 import              | **無い** (`import` は宣言のみ、コードは走らない) | `import './foo.js'` で評価される (副作用あり)         |
| 取り込み時の改名           | 不可 (FQN で書くしかない)                        | `{ X as Y }` で自由                                   |

> **本質差**: Java の `import` は「**コンパイル時の名前解決**」。JS の `import` は「**実行時 (= モジュール評価時) の値の受け渡し**」。同じキーワードでも別物。

### TypeScript 補足

TS でも構文は同じだが、型の import を区別する `import type { X } from 'pkg'` がある。実行時には消える型だけ取り込みたい時に使う。実コードへは何も影響しない。

### Self-Explanation Prompt

- `import './index.css'` を `import css from './index.css'` に書き換えたら何が起きる？ (ヒント: CSS は default export を持っているか?)
- `react` から `StrictMode` と `useState` を **1 行で** 取り込むには？

---

## 2. ブロック B: DOM API — `document.getElementById('root')`

```jsx
document.getElementById("root");
```

これは **JS 言語の機能ではなく、ブラウザが提供する API**。

- `document` = 現在開いているページ全体を表すオブジェクト (ブラウザがグローバル変数として用意)
- `.getElementById('root')` = ID が `'root'` の HTML 要素を返すメソッド
- 戻り値: HTML 要素オブジェクト (例: `<div id="root">`)。見つからなければ `null`

`index.html` を見るとこの行が見つかるはず:

```html
<div id="root"></div>
```

これが React アプリ全体の **物理的なマウントポイント**。React はこの空 `<div>` の中にすべてを書き込む。

### Java との差別化

Java には標準で「DOM」は無い (Web ブラウザという実行環境を持たないため)。Android なら `findViewById(R.id.root)` が概念的に近い。

「JS そのもの」と「ブラウザが JS に提供する API」を **混同しない** ことが重要。`Array` や `Promise` は JS 言語仕様、`document` や `fetch` はブラウザ提供。

### Self-Explanation Prompt

- なぜ `getElementById('root')` の **戻り値** を `createRoot` に渡すのか? (ヒント: createRoot は「何を支配するか」を知る必要がある)
- ブラウザではなく Node.js で `document.getElementById` を呼ぶとどうなる?

---

## 3. ブロック C: `createRoot` — 「関数がオブジェクトを返す」感覚

```jsx
createRoot(document.getElementById("root"));
```

これは **関数呼び出し**。`new` は不要。返ってきた値は **Root オブジェクト** で、`.render()` などのメソッドを持つ。

### 「式が値を返す」感覚 — JS の柱の 1 つ

JS では **ほぼ全ての式が値を返す**:

```js
const a = 1 + 2; // 1 + 2 は 3 を返す → a に代入
const b = doSomething(); // 関数呼び出しも値を返す
const c = a > 0 ? "yes" : "no"; // 三項演算子も値を返す
const { x, y } = obj; // 分割代入も値を扱う
```

この「式が値を返す」性質が高密度に組み合わさった結果が:

```js
createRoot(document.getElementById('root')).render(...)
```

の **メソッドチェーン**。

### メソッドチェーンの読み方

`.` は「**直前の値に対するメソッドアクセス**」。左から順に評価される:

```
createRoot(document.getElementById('root')).render(...)
└─① getElementById が要素を返す
   └─② createRoot がその要素を受け取り Root オブジェクトを返す
      └─③ Root オブジェクトの .render を呼ぶ
```

### Java との差別化

メソッドチェーン自体は Java にもある (`new StringBuilder().append("a").append("b").toString()`)。

| 観点           | Java                  | JavaScript                                                                   |
| -------------- | --------------------- | ---------------------------------------------------------------------------- |
| インスタンス化 | `new ClassName(...)`  | 普通の関数呼び出し (ファクトリ関数文化)                                      |
| 戻り値の型     | 静的に決まる          | 実行時に決まる (`createRoot` の返り値が何かは TS なら型注釈で確認)           |
| チェーンの粒度 | Stream API 等で慣習化 | **ライブラリ全般で日常的**。`array.map().filter().reduce()` のように毎日見る |

### TypeScript 補足

TS なら IDE 上で `createRoot(...)` の戻り値の **型** が見える (`Root` 型)。JS のままだと「`.render` 以外に何が呼べるのか」を都度ドキュメントで調べる必要がある。**動的型の代償**。

### Self-Explanation Prompt

- `createRoot(...)` の戻り値を一度変数に入れてから `.render(...)` を呼ぶ書き方は? それと現在の書き方の違いは?
- もし `createRoot` が `void` (何も返さない) だったら、続けて `.render` は書けるか?

---

## 4. ブロック D: `.render(...)` の引数は JSX 要素

```jsx
.render(
  <StrictMode>
    <App />
  </StrictMode>,
)
```

`.render` は引数を **1 つ** 取り、それが「描画したい UI ツリー」。ここでは:

```jsx
<StrictMode>
  <App />
</StrictMode>
```

これが **JSX 要素**。

### JSX の正体: 関数呼び出しの糖衣

JSX は **HTML ではない**。Vite (の中の Babel) が以下のような **JS の関数呼び出し** に変換する:

```js
// 上の JSX は、ビルド時にこう変換される (概念図)
React.createElement(StrictMode, null, React.createElement(App, null));
```

つまり `<StrictMode>...</StrictMode>` は実は:

- `StrictMode` という **値** (関数 / コンポーネント) に対して
- 中身 (`<App />`) を **子要素** として渡す
- **関数呼び出し** に展開される

### HTML 風に見えて違う 3 点

1. **属性は camelCase**: `class` ではなく `className`、`onclick` ではなく `onClick`
2. **値は JS 式**: `{}` で囲んだ中は JS が評価される (`<img src={heroImg} />`)
3. **閉じタグ必須**: `<br>` ではなく `<br />`

### `<App />` (自己閉じタグ) と `<StrictMode>...</StrictMode>` (子要素あり)

- `<App />`: 子要素を持たない。HTML の `<input />` と同じ書き方
- `<StrictMode>子</StrictMode>`: 開きタグと閉じタグの間に **子要素** を持つ。子は別の JSX 要素や文字列

### Java との差別化

Java には JSX のようなテンプレート構文は **言語標準にはない**。Android の Jetpack Compose の `@Composable` 関数 (`Column { Text("hi") }`) が概念的に近いが、それは Kotlin で実現された別系譜。

JSX のポイントは「**UI の宣言が言語の式の中に自然に埋め込める**」こと。テンプレート文字列でも HTML ファイル別離でもなく、**式の一部** として UI が値になる。

### TypeScript 補足

TS では `.tsx` 拡張子 + `<App />` のようなコンポーネント呼び出しに対して **props の型チェック** がかかる。JSX の安全性は TS と組み合わせて初めて発揮される。

### Self-Explanation Prompt

- `<App />` を `<App></App>` と書いても等価。なぜ?
- `<StrictMode><App /><App /></StrictMode>` のように **2 つ** の `<App />` を子に置けるか?

---

## 5. 末尾カンマ (`,`) — Trailing Comma

```jsx
.render(
  <StrictMode>...</StrictMode>,   // ← この最後の `,`
)
```

これは **JS が許す末尾カンマ**。動作には影響しないスタイル習慣。

### なぜ付けるか

```jsx
.render(
  <StrictMode>...</StrictMode>,
)
```

から、後で 2 番目の引数を追加するとき:

```jsx
.render(
  <StrictMode>...</StrictMode>,   // ← 既存行は変えない
  callback,                       // ← 1 行足すだけ
)
```

末尾カンマがないと、既存行の末尾に `,` を追加する **diff が出る**。コードレビューや blame が汚れる。

### Java との差別化

| 場所                              | Java               | JavaScript |
| --------------------------------- | ------------------ | ---------- |
| 配列リテラル `[1, 2, 3,]`         | OK                 | OK         |
| メソッド/関数引数の末尾 `,`       | **不可**           | OK         |
| オブジェクト/Map リテラル末尾 `,` | OK (Map.of は不可) | OK         |

JS の方が末尾カンマの許容範囲が広い。

---

## 6. `<StrictMode>` の役目 (簡略)

React が用意した **開発時専用のお守り**:

- 副作用 (`useEffect` など) を **2 回実行** してバグの隠れ場所を炙り出す (本番ビルドでは無効)
- 廃止予定 API を使うと警告

詳細は Phase 2 で `useEffect` に出会ったとき改めて学ぶ。**いまは「外しちゃダメな安全装置」と認識**。

---

## 7. Java / TypeScript 比較サマリ表

| 構文                          | Java の対応物                            | TypeScript で何が変わるか                 |
| ----------------------------- | ---------------------------------------- | ----------------------------------------- |
| `import { X } from 'pkg'`     | `import com.pkg.X;` (ただし型解決は別物) | `import type { X }` で型のみ取得が可能    |
| `import X from './foo.jsx'`   | (デフォルト輸出は Java に無い)           | 型注釈付きで戻り値が明確になる            |
| `import './style.css'`        | (副作用 import は Java に無い)           | 同じ。型なし                              |
| `createRoot(...).render(...)` | `new Builder().build().render()` 風      | チェーンの各段階の戻り値型が IDE で見える |
| `const x = 1 + 2`             | `final int x = 1 + 2;`                   | `const x: number = 1 + 2;` (推論で省略可) |
| `<App />`                     | (テンプレート構文は Java 標準に無い)     | `.tsx` で props 型チェック                |
| `() => x + 1` (アロー関数)    | `(x) -> x + 1` (ラムダ)                  | 引数・戻り値型が型注釈可能                |
| 末尾カンマ                    | 引数では不可                             | JS と同じ                                 |

---

## 8. Self-Explanation 統合プロンプト

このセッションの最後に自分で答えてみる質問群 (答えは別ファイル化しない、自分の言葉で `_log/` に書く):

1. **構造**: main.jsx の 10 行を、自分の言葉で 3 文以内に要約せよ。
2. **import**: なぜ `import './index.css'` だけ `from` がないのか? `from` がない場合、何が「取り込まれて」いるのか?
3. **メソッドチェーン**: `createRoot(...).render(...)` を、いったん変数 `root` を経由する形に書き換えよ。両者の意味は同じか?
4. **JSX**: `<App />` は HTML タグではないと言える根拠を 2 つ挙げよ。
5. **Java 比較**: Java しか知らない友人に「JS の `import` は Java の `import` と何が違うのか」を 1 分で説明する原稿を書け。
6. **再現**: `createRoot` も `App` も使わず、純粋な DOM API だけで `<div id="root">` の中に `Hello` という文字を出すコードを書け (ヒント: `document.getElementById('root').textContent = 'Hello'`)。これを書くと React が肩代わりしている範囲が見える。

---

## 9. 次セッションへの橋渡し

main.jsx で道具立てが分かったので、次は **`App.jsx`** へ進む。`App.jsx` には:

- `function App() { ... }` — 関数コンポーネント
- `const [count, setCount] = useState(0)` — **分割代入** + フック
- `() => setCount((count) => count + 1)` — **アロー関数** + 関数型 setState
- JSX 内の **式埋め込み** (`{count}`)
- `export default App` — main.jsx の `import App from './App.jsx'` と対応

これらが新規で出てくる。本ファイルで触れた **基礎の上に** 載るので、いきなり詰まることは減るはず。

---

## 10. 関連リンク

- 本セッションで芽が出た JS 構文の深掘り (今後の `00-foundations/javascript/00-concept/` 候補):
  - `01-bindings.md` — `const` / `let` / `var` の差 (Java の `final` 比較)
  - `03-modules.md` — ESM の named / default / side-effect の本質差
  - `04-functions.md` — 第一級関数とアロー関数 / メソッドチェーン
  - `06-objects.md` — Root のような「関数が返すオブジェクト」と JS のオブジェクト観
- foundations 全体: [`00-foundations/javascript/README.md`](../../../00-foundations/javascript/README.md)
- 次の見取り図: `02-app-jsx-tour.md` (未作成)
