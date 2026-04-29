# Auth and Trust — 認証・認可・セキュリティ

> 「あなたが誰で / 何ができるか / 誰に何を見せるか」を扱うジャンル。OAuth / JWT / セッション / RBAC / OWASP / RLS。

## このジャンルが扱う問題

- 認証（Authentication）と認可（Authorization）は別物 — 混同が事故の原点
- パスワード認証 → OAuth 2.0 / OIDC への進化は何を解決したのか
- セッション Cookie と JWT — どちらがどんな場面で正解か
- RBAC / ABAC / ReBAC — 権限モデルの選択
- OWASP Top 10 はなぜ毎年似た顔ぶれなのか — 構造的脆弱性
- Row Level Security（RLS）は永続化レイヤで認可を強制する設計

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # 認証 vs 認可 / セッション vs トークン / なぜ OAuth が要るか
  mental-model.md                    # OAuth フロー図 / JWT 構造 / RLS のリクエスト経路
  key-terms.md                       # AuthN / AuthZ / OAuth / OIDC / JWT / セッション / CSRF / XSS / RBAC

01-implementation/
  walkthrough.md                     # Supabase Auth で Email + Magic Link 認証 → 認可つき API を作る
  code/
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # Supabase Auth / Auth0 / Clerk / NextAuth / Firebase Auth / Cognito
  why-each-exists.md                 # 各 Auth サービスの誕生背景
  decision-matrix.md

quiz/
_log/
```

## 推奨学習順

1. **前提**: `../persistence/` と `../network-and-async/` の概念
2. `00-concept/overview.md` で **認証 / 認可 / 暗号化を別軸として** 区別
3. `01-implementation/walkthrough.md` で動く認証を作る（OAuth フローを実際に観測）
4. `02-comparison/` で複数 Auth サービスを並べる
5. **OWASP Top 10 を後で学ぶ**（構造的脆弱性）

## 関連ジャンル

- `../persistence/`: RLS は永続化と一体
- `../network-and-async/`: HTTPS / Authorization ヘッダ / CORS
- `../infra-and-deploy/`: secrets 管理 / KMS / IAM

## 主な比較対象サービス

| カテゴリ           | 代表                          | 設計上の重点                   |
| ------------------ | ----------------------------- | ------------------------------ |
| BaaS Auth          | Supabase Auth / Firebase Auth | DB と密結合 / RLS と統合       |
| 専用 IDaaS         | Auth0 / Clerk                 | エンタープライズ機能 / DX      |
| OSS フレームワーク | NextAuth (Auth.js) / Lucia    | フレームワーク統合 / 自前実装  |
| クラウド IDaaS     | AWS Cognito / Azure AD B2C    | クラウド統合 / 大規模利用      |
| パスワードレス     | Passkey (WebAuthn)            | デバイスバウンド認証           |
| 認可               | OAuth 2.0 / Casbin / OPA      | RBAC / ABAC / ポリシーエンジン |

## Dreyfus 到達基準

| Lv. | できること                                                               |
| --- | ------------------------------------------------------------------------ |
| 1   | パスワード認証の概念、HTTPS の意味を説明できる                           |
| 2   | Email + パスワードでログインを組み込める、セッション Cookie の役割を理解 |
| 3   | OAuth 2.0 認可コードフローを追え、JWT を検証して RBAC を実装できる       |
| 4   | RLS / マルチテナント認可を設計、OWASP 主要脆弱性を予防的に検出できる     |
| 5   | ID 連邦 / Zero Trust / E2EE / 暗号鍵運用を含む全体設計を主導できる       |
