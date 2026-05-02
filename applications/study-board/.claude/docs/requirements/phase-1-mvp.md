# Phase 1 — MVP 仕様

Trello 風 Kanban の最小機能。**ここまでで「動くアプリ」になる** ことを目標とする。

## 機能一覧

| #   | 機能                                      | 学べる概念                                                                                         |
| --- | ----------------------------------------- | -------------------------------------------------------------------------------------------------- |
| 1.0 | Vite 雛形を読む                           | `index.html` / `main.jsx` / `App.jsx` の役割                                                       |
| 1.1 | 3 列表示（未学習 / 学習中 / 完了）        | コンポーネント分割、props、`map` でリスト描画、`key` prop                                          |
| 1.2 | カード追加（フォーム → 「未学習」に追加） | `useState`、controlled input、`onChange`、`onSubmit`、`e.preventDefault()`、spread `[...arr, new]` |
| 1.4 | カード削除（× ボタン）                    | `filter` で配列から除外、ハンドラに引数を渡すパターン                                              |
| 1.3 | カード移動（隣の列へ ← → ボタン）         | `map` で特定要素だけ書き換え、配列の中の特定要素更新の常套句                                       |

実装順は **1.0 → 1.1 → 1.2 → 1.4 → 1.3**。移動が一番難しいので最後。

---

## 1.0 Vite 雛形を読む

### ゴール

`index.html` から `main.jsx` 経由で `App.jsx` がレンダリングされる流れを口頭で説明できる。

### 学習ポイント

- `<div id="root">` が React のマウント先
- `ReactDOM.createRoot()` の意味
- `import` / `export` の基本
- なぜ `App.jsx` の拡張子が `.jsx` なのか（`.js` との違い）

### 進め方

ヒントを Claude が出す → 学習者が口頭で説明 → 不正確なら Claude が訂正 → `learning-log/2026-MM-DD-vite-anatomy.md` に書く

---

## 1.1 3 列表示

### ゴール

画面に「未学習 / 学習中 / 完了」と書かれた 3 つの空の箱が横並びで表示される。

### コンポーネント

- `App` — 全体（`Board` を呼ぶ）
- `Board` — 3 列のレイアウト
- `Column` — 列 1 つ（タイトル + カード一覧、ただし最初は空）

### データ

```js
const COLUMNS = [
  { id: "todo", title: "未学習" },
  { id: "doing", title: "学習中" },
  { id: "done", title: "完了" },
];
```

### 学習ポイント

- コンポーネントの分割（1 ファイル 1 コンポーネント）
- props で親 → 子へデータを渡す
- `map` でリストを描画する書き方
- `key` prop の必要性

### TODO ヒント例

```jsx
// Board.jsx
function Board() {
  // TODO: COLUMNS 配列を map して、各要素から <Column ... /> を返す
  // ヒント: 親 → 子へは props で渡す、key prop を忘れない
}
```

---

## 1.2 カード追加

### ゴール

画面上部のフォームに文字を入れて「追加」ボタンを押すと、「未学習」列の末尾にカードが表示される。

### データ構造

```js
const [cards, setCards] = useState([
  // { id: 'card-1', title: 'reduce の引数順', columnId: 'todo' }
]);
```

### コンポーネント

- `AddCardForm` — input + button
- `Card` — カード 1 つ（タイトル表示）

### 学習ポイント

- `useState` の基本
- controlled input（`value` + `onChange` の組）
- `onSubmit` で `e.preventDefault()` する理由
- `setCards([...cards, newCard])` で破壊的 push を避ける

### TODO ヒント例

```jsx
// AddCardForm.jsx
function AddCardForm({ onAdd }) {
  // TODO: input の値を保持する state を作る
  // TODO: form の onSubmit ハンドラで:
  //   1. e.preventDefault() を呼ぶ
  //   2. 入力値が空ならスキップ
  //   3. onAdd(入力値) を呼ぶ
  //   4. input を空にリセット
}
```

---

## 1.4 カード削除

### ゴール

カード右上の × ボタンを押すと、そのカードが消える。

### 学習ポイント

- `filter` で「id が一致しないものだけ」配列に残す
- ハンドラに id を渡す: `onClick={() => onDelete(card.id)}`
- なぜ `onClick={onDelete(card.id)}` ではダメか（即時実行されてしまう）

### TODO ヒント例

```jsx
// App.jsx
const handleDeleteCard = (cardId) => {
  // TODO: setCards で、cards から id が cardId と異なるものだけ残した新しい配列をセット
  // ヒント: filter
};
```

---

## 1.3 カード移動

### ゴール

カードに `←` `→` ボタンがあり、押すと隣の列へ移動する。両端の列では片方のボタンが無効。

### 学習ポイント

- `map` で「特定の card だけ columnId を書き換えた新しい配列」を作る
- 配列の中の特定要素だけ更新する常套句
- 端の判定（`COLUMNS[0]` なら ← 無効、`COLUMNS[COLUMNS.length - 1]` なら → 無効）

### TODO ヒント例

```jsx
const handleMoveCard = (cardId, direction) => {
  // TODO: direction は 'left' か 'right'
  // TODO: setCards で、対象 card の columnId を隣のものに書き換える
  // ヒント: map で、id が一致したら新しいオブジェクトに置き換え、それ以外はそのまま
};
```

---

## 完了条件

- 4 機能すべて動作（手で確認）
- 学習ロードマップの 20 トピックの初期データを「未学習」列に手で投入できる
- `learning-log/` に Phase 1 完了時の振り返りを書く（自分の言葉で）
