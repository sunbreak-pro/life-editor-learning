# Day 2: useState とフォーム入力(controlled component + IME)

## このセッションで身につけること

1. **`useState`** で状態(state)を持つコンポーネントを書ける
2. **「state とは何か / なぜローカル変数で代用できないか」** を説明できる
3. **controlled component**(制御された入力)パターンで input を扱える
4. **IME 入力中の罠**(`isComposing` チェック)を知り、回避できる

これは life-editor の任意のフォーム/編集 UI で使う基礎。Tasks 入力 / Note 編集 / Schedule 作成、全部このパターン。
/
---

## 1. なぜ useState が必要か

普通の関数コンポーネントを思い出す:

```tsx
function Counter() {
  let count = 0; // 普通の変数
  return <button onClick={() => count++}>{count}</button>;
}
```

これ、**動かない**。なぜか?

### 答え

React のコンポーネントは「**画面に変化を出す時、関数を再実行して結果の JSX を比較する**」という動作モデル。

- ボタンクリック → React は再実行が必要かを知らない → そもそも再描画しない
- 仮に再実行されても、`let count = 0` から始まるので毎回 0 にリセット

つまり「**変数の値が変わったら React に再描画してほしい**」という関係性が必要。それを担うのが `useState`。

### useState を使うとこうなる

```tsx
import { useState } from "react";

function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>;
}
```

ポイント:

- `useState(0)` は **`[現在値, 値を更新する関数]`** のタプル(2 要素配列)を返す
- `count` が現在値、`setCount` が更新関数
- `setCount(...)` を呼ぶと React が「**この関数を再実行する必要がある**」と判定して再描画
- 関数再実行時には `useState(0)` の **0 ではなく、保持されてる最新値** が `count` に入る

「`useState(0)` の 0 は **初期値**であって、毎回そこからリスタートするわけではない」が最初の躓きポイント。

---

## 2. ハンズオン: カウンタを作る

`src/App.tsx` を以下に書き換え:

```tsx
import { useState } from "react";

function App() {
  const [count, setCount] = useState(0);

  return (
    <div className="min-h-screen flex flex-col items-center justify-center gap-4 bg-slate-900 text-white">
      <h1 className="text-4xl font-bold">Counter</h1>
      <p className="text-2xl">{count}</p>
      <div className="flex gap-2">
        <button
          onClick={() => setCount(count - 1)}
          className="px-4 py-2 bg-rose-600 rounded hover:bg-rose-700"
        >
          -1
        </button>
        <button
          onClick={() => setCount(count + 1)}
          className="px-4 py-2 bg-emerald-600 rounded hover:bg-emerald-700"
        >
          +1
        </button>
        <button
          onClick={() => setCount(0)}
          className="px-4 py-2 bg-slate-600 rounded hover:bg-slate-700"
        >
          Reset
        </button>
      </div>
    </div>
  );
}

export default App;
```

`npm run dev` 中ならファイル保存で即ブラウザに反映される。

### 小チャレンジ

- ボタン 3 つの並びを縦にしてみる(`flex gap-2` を `flex flex-col gap-2` に)
- 数字を 5 ずつ増やすボタンを追加
- 数字が偶数の時だけ青、奇数の時だけ赤、になるようにする(ヒント: `count % 2 === 0 ? "text-blue-400" : "text-red-400"` を className に)

---

## 3. controlled component(制御された入力)

input にユーザーが文字を打つ時の話。

### 普通の HTML(uncontrolled)

```html
<input type="text" />
<!-- ユーザーが打つ → DOM が値を持つ → JS 側は知らない -->
```

### React の controlled component

```tsx
const [text, setText] = useState("");
return (
  <input
    type="text"
    value={text} // ← 値は state が管理
    onChange={(e) => setText(e.target.value)} // ← 入力で state 更新
  />
);
```

ポイント:

- `value={text}` で「**input の表示値は state の値**」と宣言
- `onChange` で「**ユーザー入力 → state 更新**」を実装
- 結果: **input の見た目と state が常に同期**(これが "controlled" の意味)

### なぜわざわざこうするか

ローカル変数や DOM 直接操作だと、複数の場所からの更新が衝突する。
React 流儀では「**state が唯一の真実の源(single source of truth)**」を貫く。これにより:

- バリデーション・整形を `setText` の前に挟める
- 別コンポーネントから state を共有しやすい
- 履歴・undo/redo 等の機能を後付けしやすい

---

## 4. IME の罠(日本語入力で必須)

### 何が問題か

日本語入力の最中(変換確定前)も `onChange` が発火する:

```
[ユーザーが「あ」と打つ]
→ IME 変換中: 「あ」「a」「ア」など候補が次々表示
→ その都度 onChange が発火
→ state がコロコロ書き換わる
→ Enter で「Enter キーが押された」処理が走ってしまう(意図せず送信)
```

### 解決パターン

`e.nativeEvent.isComposing` で「IME 変換中か?」を判定:

```tsx
function CommentForm() {
  const [text, setText] = useState("");

  const handleSubmit = () => {
    console.log("送信:", text);
    setText("");
  };

  return (
    <input
      type="text"
      value={text}
      onChange={(e) => setText(e.target.value)}
      onKeyDown={(e) => {
        if (e.key === "Enter" && !e.nativeEvent.isComposing) {
          handleSubmit();
        }
      }}
      className="px-3 py-2 bg-slate-800 border border-slate-600 rounded text-white"
      placeholder="Enter で送信"
    />
  );
}
```

`!e.nativeEvent.isComposing` で「**変換中ではない時だけ Enter を受け付ける**」。これがないと「あ」と打って変換中に Enter を押した瞬間、submit が走って事故る。

life-editor の既存コードベースでも、`isComposing` チェックは多数の場所で必須にしている(CLAUDE.md §6.6)。**Web フロントエンドで日本語を扱う時の必須知識**。

---

## 5. ハンズオン: コメントフォーム + リスト

カウンタの下に「コメント追加 → リスト表示」を作る。`src/App.tsx` 全体を以下に置き換え:

```tsx
import { useState } from "react";

function App() {
  const [count, setCount] = useState(0);
  const [text, setText] = useState("");
  const [comments, setComments] = useState<string[]>([]);

  const handleSubmit = () => {
    if (text.trim() === "") return;
    setComments([...comments, text]);
    setText("");
  };

  return (
    <div className="min-h-screen flex flex-col items-center justify-start gap-6 p-8 bg-slate-900 text-white">
      {/* カウンタ */}
      <div className="flex flex-col items-center gap-3">
        <h2 className="text-2xl font-bold">Counter: {count}</h2>
        <div className="flex gap-2">
          <button
            onClick={() => setCount(count - 1)}
            className="px-3 py-1 bg-rose-600 rounded hover:bg-rose-700"
          >
            -1
          </button>
          <button
            onClick={() => setCount(count + 1)}
            className="px-3 py-1 bg-emerald-600 rounded hover:bg-emerald-700"
          >
            +1
          </button>
        </div>
      </div>

      {/* コメントフォーム */}
      <div className="flex flex-col gap-2 w-full max-w-md">
        <h2 className="text-2xl font-bold">Comments</h2>
        <input
          type="text"
          value={text}
          onChange={(e) => setText(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === "Enter" && !e.nativeEvent.isComposing) {
              handleSubmit();
            }
          }}
          placeholder="Enter で送信"
          className="px-3 py-2 bg-slate-800 border border-slate-600 rounded"
        />
        <ul className="flex flex-col gap-1 mt-2">
          {comments.map((c, i) => (
            <li key={i} className="px-3 py-2 bg-slate-800 rounded">
              {c}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default App;
```

### 注目してほしい構文

- `useState<string[]>([])`: TypeScript の **ジェネリクス**で「string の配列」と型注釈
- `setComments([...comments, text])`: **既存配列を展開して新要素を追加した新配列**を作る("immutable update" — state を直接 mutate しない)
- `comments.map((c, i) => <li key={i}>...)`: 配列を JSX 要素に変換。`key` は **React が差分検知に使う識別子**(必須)

---

## 6. Day 2 完了判定

- [ ] カウンタが動く(増減・リセット)
- [ ] コメントフォームに文字を打ってEnterで追加できる
- [ ] **日本語で「あいう」と打って変換中に Enter を押しても送信されない**ことを確認
  - `isComposing` チェックを外してみて、変な挙動を体感するのも勉強になる(壊して直す)
- [ ] コメントが配列で表示される

---

## 7. 振り返りクイズ(Day 2 終了時)

実機で動いた後、ここに戻ってきて答えてみる。

### Q3 (Lv.3): なぜローカル変数 `let count = 0` ではなく `useState(0)` を使う必要があるか?

選択肢:

- A. let は再代入できないから
- B. React コンポーネントは再描画のたびに関数が再実行されるので、let だと値がリセットされる + そもそも変更を React が検知できない
- C. パフォーマンスの問題
- D. 単に React のお作法

### Q4 (Lv.3): `setComments([...comments, text])` の `...comments` を `comments` に変えると何が起きる?

選択肢:

- A. 何も変わらない
- B. comments 配列の代わりに、文字列 1 つだけが入った配列になる
- C. エラーになる
- D. 配列が二重にネストする

回答してくれたら Day 3(TODO リスト + localStorage + useEffect)に進みます。
