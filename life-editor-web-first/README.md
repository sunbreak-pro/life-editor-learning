# life-editor-web-first 学習マップ

## プロジェクト概要

life-editor を Tauri から **Vite + React + TypeScript + Supabase + Capacitor** に移行する 2.5-4 ヶ月計画の **Phase 0**(2 週間)で身につける技術を、ハンズオンで習得するための学習教材。

**ゴール**:

- 各ツールが「何を / なぜ / どう」してくれるかを、自分の言葉で説明できる
- 素のプロジェクトを 1 つ作って動かせる
- 既存の life-editor コードを Web スタックに移植する時、各レイヤを迷わず組み立てられる

**前提知識**(ユーザー自己申告): JavaScript と SQLite の基礎は少し分かるが、まだあやふや。React / TypeScript / Tailwind / Supabase / Capacitor は未経験。

**学習方針**:

- **Lv.2 (基礎)** から開始し、Lv.3 (実践) を目標に
- 説明 → ハンズオン → クイズ → 振り返り の繰り返し
- 概念の名前を先に教え、後から具体実装を見る("名前を知ってから手を動かす"順)
- 詰まったら 1 段下げる、スラスラなら 1 段上げる

## 学習トピック

| #   | トピック                                                                 | 対象                                    | 期間目安  | 状態   |
| --- | ------------------------------------------------------------------------ | --------------------------------------- | --------- | ------ |
| 1   | [Vite + React + TS + Tailwind 基礎](./day-01-03-vite-react-ts-tailwind/) | 素プロジェクトを 1 個作って動かす       | Day 1-3   | 進行中 |
| 2   | Supabase 基礎 (DB + CRUD)                                                | Postgres とは / SDK の使い方            | Day 4-5   | 未着手 |
| 3   | Supabase Auth                                                            | Email / Magic Link / Apple Sign-in 概念 | Day 6-8   | 未着手 |
| 4   | Supabase Realtime                                                        | Postgres CDC / WebSocket / 楽観的 UI    | Day 9-11  | 未着手 |
| 5   | Capacitor で iOS / Android 化                                            | Web → ネイティブの仕組み                | Day 12-14 | 未着手 |

## 学習ログ

`_learning-log/YYYY-MM-DD-<slug>.md` に各セッションのログを記録する。
始める前に前回のログをサッと読み返して "今どこにいるか" を把握する習慣を作る。

## ハンズオン用コードの置き場

`~/dev/learning/web-first-spike-1/` (このリポジトリ外) に Day 1-3 で実際の Vite プロジェクトを作る。教材(本ディレクトリ)とコード(spike ディレクトリ)を分けて、教材は git 管理しない。

## 関連ドキュメント

- 移行プラン本体: `~/dev/apps/life-editor/.claude/2026-04-29-web-first-migration.md`
- 学習ブランチ: `refactor/web-first-v2`(life-editor 側)
