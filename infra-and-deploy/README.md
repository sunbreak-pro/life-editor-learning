# Infra and Deploy — インフラ・配布

> 「コードを動く環境に届ける」を扱うジャンル。コンテナ / CI/CD / Edge / CDN / モバイル配布。

## このジャンルが扱う問題

- なぜコンテナが生まれたのか — "It works on my machine" 問題
- VM / コンテナ / サーバーレス — それぞれの適切な抽象度
- Edge / CDN / リージョン — レイテンシは物理に縛られる
- CI/CD は「自動化」より「品質ゲート」
- Web → モバイル（Capacitor / React Native / Flutter）の境界
- Secrets 管理 / Infrastructure as Code

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # 配布の歴史 / VM → Container → Serverless / Edge の意味
  mental-model.md                    # デプロイパイプライン図 / Edge / Origin / CDN / DNS の関係
  key-terms.md                       # Container / Image / Serverless / Edge / CDN / IaC / Secret

01-implementation/
  walkthrough.md                     # Vite アプリを Cloudflare Pages にデプロイ → Capacitor で iOS 化
  code/
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # Vercel / Cloudflare / AWS / Render / Fly / Capacitor / RN / Flutter
  why-each-exists.md                 # PaaS / Edge / コンテナ / モバイル抽象層の誕生背景
  decision-matrix.md

quiz/
_log/
```

## 推奨学習順

1. `00-concept/overview.md` で **VM → Container → Serverless → Edge** の進化軸を理解
2. `01-implementation/` で実際に小さなアプリをデプロイ
3. `02-comparison/` で Vercel と Cloudflare、Capacitor と React Native を比較
4. IaC / Kubernetes は Lv.4 として後回し

## 関連ジャンル

- 全ジャンルの最終アウトプット先
- 特に `../auth-trust/`: secrets / KMS / IAM
- 特に `../network-and-async/`: Edge runtime の制約

## 主な比較対象サービス

| カテゴリ     | 代表                                              | 設計上の重点                             |
| ------------ | ------------------------------------------------- | ---------------------------------------- |
| PaaS         | Vercel / Netlify / Render                         | フロントエンド最適化 / DX                |
| Edge         | Cloudflare Workers / Pages / D1                   | エッジロケーション分散 / V8 isolate      |
| Container    | Docker / Fly.io / Railway                         | 任意ランタイム / 永続ボリューム          |
| Serverless   | AWS Lambda / Vercel Functions                     | 関数単位の従量課金                       |
| クラウド     | AWS / GCP / Azure                                 | フルスタッククラウド                     |
| モバイル抽象 | Capacitor / React Native / Flutter / Tauri Mobile | Web 流用 / ネイティブブリッジ / 完全独自 |
| CI/CD        | GitHub Actions / GitLab CI / CircleCI             | パイプライン定義 / セルフホスト          |
| IaC          | Terraform / Pulumi / CDK                          | 宣言的 / プログラマブル                  |

## Dreyfus 到達基準

| Lv. | できること                                                                |
| --- | ------------------------------------------------------------------------- |
| 1   | git push でデプロイされる仕組みを言葉で説明できる                         |
| 2   | Vercel / Cloudflare Pages にフロントエンドアプリをデプロイできる          |
| 3   | CI でテスト + ビルドを走らせ、環境変数 / secrets を管理できる             |
| 4   | Edge / Origin / モバイルパッケージング戦略を設計、Capacitor を運用できる  |
| 5   | マルチリージョン / IaC / コスト最適化を含む全体アーキテクチャを主導できる |
