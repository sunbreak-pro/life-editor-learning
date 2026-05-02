# MEMORY.md — study-board 学習進捗

> 進行中・直近完了・予定。task-tracker スキルが更新する。手動編集は最小限。

---

## 現在の Phase

**Phase 1 MVP** 着手前。`.claude/` 構築完了 → 次は `App.jsx` の中身を一緒に眺めて Vite 雛形を理解するところから。

---

## 進行中

（なし — Phase 1.0 着手準備中）

---

## 直近完了

- **2026-05-02** プロジェクト雛形生成（`npm create vite@latest study-board -- --template react`）
- **2026-05-02** `~/dev/learning/applications/study-board/` 配下に統合、`.claude/` ツリー構築（`applications/` 規約も「動くコードと教材の同居」型を許容するよう更新）

---

## 予定

### Phase 1（MVP）

- [ ] 1.0 Vite 雛形を一緒に眺める（`App.jsx` / `main.jsx` / `index.html` の役割を理解）
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
