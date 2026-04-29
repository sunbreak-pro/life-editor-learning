# Core Vision — なぜこの学習ワークスペースを作るのか

## 1-line

「**ライブラリは使えるが、なぜそれを選ぶのかを言語化できない**」を解消するため、ジャンルを概念抽象度で切り、概念 → 実装 → 比較 の 3 層を必ず通る。

---

## 学習者像

- N=1（作者本人）
- 自己評価: JavaScript と SQLite の基礎は浅く、まだあやふや。React / TypeScript / Tailwind / Supabase / Capacitor は未経験
- 強み: Claude Code / Tauri / プロジェクト設計の知見はある
- 弱み: 抽象概念が「サービスの API」と分かちがたく結びついていて、別サービスに移ると応用が効きにくい

---

## 何を目指すか

1. **概念ファースト**: サービス名で記憶せず、解こうとした問題（"なぜ生まれたか"）で記憶する
2. **比較ベース理解**: Redux と Zustand の違いを言える、PostgreSQL と MongoDB の住み分けを言える
3. **Lv.3 実践 (Dreyfus Competent)** を当面のゴール: 単独でルールを組み合わせて使え、状況に応じてジャンル内の選択ができる
4. **応用プロジェクトでの転移**: `life-editor-web-first` のような実プロジェクトに着手したとき、「このパートは `state-and-time/` で学んだ XYZ パターンだ」と既習概念に紐付けられる

---

## 何を目指さないか（Non-Goals）

- **特定 API の網羅**: 公式ドキュメントの劣化コピーを作らない
- **Lv.5 アーキテクト相当の到達**: 当面の射程外（Lv.4 でも実務には十分）
- **動画 / インタラクティブ教材の自前生成**: Claude が生成しやすい Markdown + コード + クイズに集中
- **非プログラミング領域**: ビジネス / マーケティング / デザインは別ワークスペースで

---

## 設計上の判断

### なぜ「ジャンル別」か

- 単一プロジェクト連動学習（life-editor のみ）は **応用が効かない**: 同じ概念が別サービスで現れたとき気づけない
- ジャンルが「概念のチャンク単位」になっていれば、ワーキングメモリ負荷が下がる（Hermans 2021）
- ジャンル間の依存関係が明示できれば、推奨学習順を設計できる

### なぜ「概念抽象度で切る」か

- 「React」「Vue」のようにサービス名で切ると、比較対象が他ジャンルに飛んでしまう
- 「ui-rendering」のように切れば、React / Vue / Svelte / Solid を **同じディレクトリで並べて比較** できる
- 学術的根拠: Marton の Variation Theory（対比 = 概念理解の前提）/ Gentner の Analogical Encoding（比較で抽象スキーマ形成が約 2 倍に加速）

### なぜ「概念 → 実装 → 比較」の 3 層か

- 概念だけ → 抽象論で終わって手が動かない
- 実装だけ → 表面的な API 暗記で終わる
- **3 層通すと**: 「なぜ」「どう」「他とどう違う」が同時に固定される（Self-Explanation Effect + Variation Theory）

### なぜ Active Recall + Spaced Repetition か

- Roediger & Karpicke 2006: 5 分後は再読有利だが 1 週間後は想起練習が大幅に勝つ
- Cepeda et al. 2006 メタ分析（317 研究）: 適切な分散で保持率 +200%
- Dunlosky 2013 メタ分析: 10 技法のうち Practice Testing と Distributed Practice だけが "High Utility"

### なぜ「最小動作アプリから」か（4C/ID）

- van Merriënboer の Transfer Paradox: 部分スキルを順番に積み上げても転移しない
- 最初から「動く全体」を作りつつ、認知負荷を制御する（Worked Example で先に答えを見せる → 段階的に外す）

詳細な学術的根拠 → [`learning-principles.md`](./learning-principles.md)

---

## 開いておく問い

- ジャンル間の **横断 quiz**（Interleaving）は、いつから導入するべきか？
- 「分散復習」を Markdown だけで運用するか、Anki などへ書き出すか？
- 応用プロジェクト（`applications/`）と概念ジャンルの **行き来** をどう設計するか？
