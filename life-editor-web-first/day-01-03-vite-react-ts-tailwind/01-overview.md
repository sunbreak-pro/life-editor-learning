# Day 1-3: Vite + React + TypeScript + Tailwind 基礎

## このトピックで身につけること

3 日間で「**Web フロントエンドの素の道具立て**」を体験する。具体的には:

1. 4 つのツール(Vite / React / TypeScript / Tailwind)が **それぞれ何を解決するために存在するか** を自分の言葉で説明できる
2. 4 つを組み合わせた **空の SPA(Single Page Application)** を 1 個立ち上げ、ブラウザで開ける
3. その上に **カウンタ + ローカル TODO リスト** を実装できる(localStorage 永続化付き)
4. `npm run dev` と `npm run build` の違いを区別できる

これは life-editor 移行で全ページの土台になる組み合わせ。**この 4 つの役割分担を体に染み込ませると、後の作業が一気に早くなる。**

---

## 全体像 — 4 つのツールの役割

絵で先に整理する:

```
┌──────────────────────────────────────────────────────────┐
│  あなたが書くコード(.tsx, .ts ファイル)                    │
│  ├─ JSX で UI を書く                  ← React の領域       │
│  ├─ TypeScript で型を付ける           ← TypeScript の領域  │
│  └─ className に Tailwind ユーティリティ ← Tailwind の領域 │
└────────────────┬─────────────────────────────────────────┘
                 │ 開発時 / ビルド時に変換・束ね
                 ▼
┌──────────────────────────────────────────────────────────┐
│  Vite                                                     │
│  ├─ 開発サーバを立てる(npm run dev)                        │
│  ├─ ファイル保存で即ブラウザに反映(HMR)                    │
│  └─ 本番用にバンドル(npm run build → dist/)               │
└────────────────┬─────────────────────────────────────────┘
                 │ 配信
                 ▼
            ブラウザで動く HTML + JS + CSS
```

**ひとことで言うと**:

| ツール         | 役割                      | 一言                                   |
| -------------- | ------------------------- | -------------------------------------- |
| **Vite**       | ビルドツール / 開発サーバ | "コードを束ねて配るやつ"               |
| **React**      | UI ライブラリ             | "画面を関数(コンポーネント)で書く流儀" |
| **TypeScript** | 言語                      | "JS に型を足したやつ"                  |
| **Tailwind**   | CSS フレームワーク        | "クラス名でスタイルを当てる流儀"       |

---

## 各ツールの役割を 1 つずつ深掘り

### 1. Vite (ヴィート — フランス語で "速い")

**何を解決するか**: 「ブラウザは `.tsx` も `.ts` も読めない」「数百ファイルに分かれたコードを 1 個にまとめる必要がある」「保存するたびに毎回ブラウザを更新したくない」を全部肩代わりする。

**ざっくり 2 つのモード**:

- `npm run dev` → 開発用の **HTTP サーバ**を立てる(default は http://localhost:5173)。ファイル保存すると **HMR(Hot Module Replacement)** で必要な部分だけ即座に差し替わる
- `npm run build` → 本番配信用に **dist/ フォルダ**を生成。ここを Web サーバ(Supabase Storage や Capacitor)に置けば動く

**なぜ Vite か**(後で詳しく — `02-design-decisions.md`): 競合の Webpack や Create React App(CRA)に比べて開発時の起動が**桁違いに速い**(数百 ms vs 数十秒)。理由は、開発時は ES Modules(ブラウザ標準のモジュール仕組み)をそのまま使い、本番だけバンドルするから。

### 2. React 19

**何を解決するか**: 「画面を 1 個の巨大な HTML として書くのではなく、**小さな部品(コンポーネント)を組み合わせて作る**」流儀を提供する。

最小例:

```tsx
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <button onClick={() => setCount(count + 1)}>{count} 回クリック</button>
  );
}
```

3 つの要素が同居している:

- `function Counter()` — **コンポーネント**(画面の部品。関数で書く)
- `useState(0)` — **フック**(状態を持たせる仕掛け)
- `<button>...</button>` — **JSX**(JS の中に HTML 風の構文を混ぜる記法)

React 19 は 2024 年末リリース。19 の目玉は **Server Components**(今回は使わない)と **`use()` フック**だが、Day 1-3 では従来の `useState` / `useEffect` を中心に学ぶ。

### 3. TypeScript

**何を解決するか**: JS は実行するまでバグに気づけない(`undefined` の `.length` を呼んで爆発する等)。**実行前にエラーを潰す型チェッカ**を JS に被せたのが TS。

最小例:

```ts
// JS だとこれが通ってしまう
function double(n) {
  return n * 2;
}
double("hello"); // → "hellohello" が返る(意図と違う)

// TS なら型注釈でガード
function double(n: number): number {
  return n * 2;
}
double("hello"); // → エディタで赤線、ビルドエラー
```

**重要な勘違いポイント**: TS を書いても、ブラウザで動くのは結局 JS。TS は **書いてる時だけ型チェックして、ビルド時に型を消した JS にする**。実行性能は JS と同じ。

### 4. Tailwind CSS 4

**何を解決するか**: CSS を別ファイルに書く伝統的な方式は、「クラス名が増えすぎる」「使われていないクラスが残る」「グローバルなので衝突する」が辛い。Tailwind は**事前定義された大量のユーティリティクラス**を className に並べる流儀。

最小例:

```tsx
// 伝統的 CSS(別ファイルで .button-primary を定義)
<button className="button-primary">送信</button>

// Tailwind(className に直接ユーティリティを並べる)
<button className="bg-blue-500 hover:bg-blue-700 text-white px-4 py-2 rounded">
  送信
</button>
```

賛否があるが(`02-design-decisions.md` で扱う)、**life-editor 既存コードが既に Tailwind を使っている**ので、ここは選択肢ではなく必須。

---

## ハンズオン手順 (Day 1)

実際に動かす。順に実行してくれ。

### 0. 前提確認

```bash
node -v   # v20 以上が望ましい
npm -v    # 10 以上
```

Node.js が古ければ先に `nvm` 等で更新。

### 1. **プロジェクト作成**

```bash
mkdir -p ~/dev/learning/web-first-spike-1
cd ~/dev/learning/web-first-spike-1
npm create vite@latest . -- --template react-ts
```

`.` は "今のディレクトリに作る" の意味。`--template react-ts` で React + TypeScript テンプレが選ばれる。

### 2. 依存インストール → 起動

```bash
npm install
npm run dev
```

`http://localhost:5173/` が開く。**ここで Vite のデフォルト画面が見えるのを確認してから次へ**。

### 3. 何が生成されたか観察

```bash
ls -la
cat package.json
```

ポイント:

- `package.json` の `scripts` に `dev` / `build` / `preview` が定義されている
- `src/main.tsx` がエントリポイント
- `src/App.tsx` が最初のコンポーネント
- `tsconfig.json` で TS 設定
- `vite.config.ts` で Vite 設定

### 4. Tailwind 4 を追加

Tailwind 4 は **Vite 4+ プラグイン形式**で入れるのが現在の主流:

```bash
npm install -D tailwindcss @tailwindcss/vite
```

`vite.config.ts` を編集:

```ts
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
  plugins: [react(), tailwindcss()],
});
```

`src/index.css` に 1 行追加:

```css
@import "tailwindcss";
```

`src/App.tsx` を以下に書き換えて Tailwind が効くか確認:

```tsx
function App() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-slate-900 text-white">
      <h1 className="text-4xl font-bold">Hello, Tailwind</h1>
    </div>
  );
}

export default App;
```

ブラウザに濃いグレー背景 + 白い太字の "Hello, Tailwind" が出れば成功。

---

## チェックポイント (Day 1 完了判定)

以下を満たしたら Day 2 に進む:

- [ ] `npm run dev` が動く
- [ ] http://localhost:5173/ で "Hello, Tailwind" が見える
- [ ] Tailwind クラスを書き換える(例: `bg-slate-900` → `bg-emerald-700`)とブラウザが即座に変わる(HMR の体験)
- [ ] `npm run build` がエラーなく終わる
- [ ] `dist/` フォルダができていて、index.html / assets/\*.js が入っている

詰まったらここで止めて質問してくれ。

---

## Day 2-3 でやること(プレビュー)

Day 1 が通ったら次は:

- **Day 2**: カウンタコンポーネント(useState) + フォームコンポーネント(controlled input + IME 対応)
- **Day 3**: TODO リストアプリ(useState で配列管理 + localStorage で永続化 + useEffect の使いどころ)

詳細は Day 1 終了時に `02-design-decisions.md` と `03-alternatives.md` を作る。

---

## 学習ログの書き方

各日の終わりに `_learning-log/YYYY-MM-DD-day-N.md` に以下を残す:

```markdown
# Day 1 学習ログ

- 日付: 2026-04-29
- 所要時間: 2h
- 完了したチェックポイント: [v] [v] [v] [v] [v]
- 詰まったところ: 〇〇のコマンドが効かなかった → 〇〇で解決
- 自分の言葉でまとめ: Vite は "コードを束ねるやつ"。React は "関数で UI を書く流儀"。TS は "型付き JS"。Tailwind は "className でスタイル当てる流儀"。
- 翌日の不安: useState がよくわからなそう
```

特に「**自分の言葉でまとめ**」が重要。覚えた風で実は分かってない、を防ぐ。
