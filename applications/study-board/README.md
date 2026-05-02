# study-board

Trello 風 Kanban で **学習ロードマップを管理する** アプリ。素の JavaScript / React で書きながら基本構文を体得することが目的。

## 関連ジャンル

| ジャンル        | この application で扱う部分                           |
| --------------- | ----------------------------------------------------- |
| `ui-rendering/` | React コンポーネント、props、JSX、`useState`          |
| 言語土台        | アロー関数、配列メソッド、`===`、テンプレートリテラル |

> 注: 言語土台は独立ジャンル化していないため、本プロジェクトが事実上の入り口になる。

## このプロジェクトの特殊性

`applications/<name>/` は本来「教材だけ」だが、本プロジェクトでは **コードと教材を同居** させる。理由は study-board 自体が「コードを書きながら学ぶための学習アプリ」で、コードと学習ノートを分離するメリットが薄いため。詳細 → `applications/README.md` の規約改訂を参照。

## 学習方針

- option (ii) **ヒントだけ出す → 学習者が書く → Claude がレビュー**
- 完全初学者から再スタート（JS は触ったことがない前提）
- 詰まりは即 `.claude/docs/known-issues/` に記録、解決時に `.claude/docs/learning-log/` に自分の言葉で書く

## 始め方

```bash
cd ~/dev/learning/applications/study-board
npm install   # 初回のみ
npm run dev
```

Claude は `~/dev/learning/applications/study-board/` から起動する。`.claude/CLAUDE.md` が学習パートナーモードを設定する。

## ロードマップ

- **Phase 1**（MVP）: 3 列表示 + カード追加 / 削除 / 移動
- **Phase 2**: 編集 + メモ + localStorage + 並び替え
- **Phase 3**: D&D + タグ + 検索 + 完了集計（`reduce` 初登場）
- **Phase 4** (構想): MCP サーバ連携

詳細 → `.claude/docs/requirements/`

## 学習ロードマップ（20 トピック）

`.claude/docs/requirements/learning-roadmap.md` 参照。完成後はアプリ上で「未学習 / 学習中 / 完了」を動かしながら学んでいく。
