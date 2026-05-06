# MEMORY.md — study-board 学習進捗

> 進行中・直近完了・予定。task-tracker スキルが更新する。手動編集は最小限。

---

## 現在の Phase

**Phase 1 MVP** 進行中（⏸️ 中断中）。Phase 1.0 で `main.jsx` の統合解読まで完了。次は `App.jsx` tour または §8 Self-Explanation Prompts の Active Recall。

---

## 進行中

### ⏸️ Phase 1.0 — Vite 雛形を一緒に眺める（着手日: 2026-05-05）

**対象**: `src/main.jsx`, `src/App.jsx`, `index.html`, `docs/code-explanation/`

- 前回: —
- 現在: `main.jsx` の統合解読文書 `docs/code-explanation/01-vite-scaffold-tour.md` を完成（4 ブロック構造 + ESM import 3 形式 + DOM API + メソッドチェーンと「式が値を返す」感覚 + JSX の正体 + trailing comma + StrictMode、各節に Java/TS 比較と Self-Explanation Prompt 併設）
- 次: `App.jsx` tour（`02-app-jsx-tour.md`）着手 / または §8 Self-Explanation Prompts を学習者が解く → `docs/learning-log/2026-05-05-vite-scaffold.md` に自分の言葉で記録 → 詰まり点をフィードバック

---

## 直近完了

- **2026-05-05** Phase 1.0 着手 / `main.jsx` 統合解読文書完成（`docs/code-explanation/01-vite-scaffold-tour.md`）。Java/TS 比較と Self-Explanation Prompt 併設の統合スタイルを確立 ✅
- **2026-05-02** プロジェクト雛形生成（`npm create vite@latest study-board -- --template react`）
- **2026-05-02** `~/dev/learning/applications/study-board/` 配下に統合、`.claude/` ツリー構築（`applications/` 規約も「動くコードと教材の同居」型を許容するよう更新）

---

## 予定

### Phase 1（MVP）

- [ ] 1.1 3 列表示（未学習 / 学習中 / 完了）
- [ ] 1.2 カード追加（フォーム + 配列に追加）
- [ ] 1.4 カード削除（× ボタン）
- [ ] 1.3 カード移動（← → ボタン）

### 学習ロードマップ

20 トピック → `docs/requirements/learning-roadmap.md`

### 将来

- Phase 2: 編集 / メモ / localStorage / 並び替え
- Phase 3: D&D / タグ / 検索 / 完了集計（reduce 初登場）
- Phase 4: MCP 連携

---

## 仮説・現在の問い

- option (ii)（ヒントのみ → 学習者が書く）方式で、20 トピックのうちどれが詰まりやすいか？
- 学習中に発生した「自分の言葉での説明」は、後で読み返した時にどれだけ理解の助けになるか？
- アプリの初期データ（20 トピック）は markdown を SSOT とし、アプリは表示のみにすべきか？それとも localStorage を SSOT にすべきか？
