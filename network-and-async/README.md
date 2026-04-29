# Network and Async — 通信と非同期

> 「離れたコンピュータと、いつ起きるか分からないイベントを扱う」を扱うジャンル。HTTP / WebSocket / async-await / イベントループ / リアルタイム通信。

## このジャンルが扱う問題

- HTTP は「リクエスト / レスポンス」だけではない — メソッド / ヘッダ / キャッシュの意味論
- なぜ async / await が生まれたのか — コールバック地獄 → Promise → async/await の進化
- イベントループは「並列実行」ではない — シングルスレッドで非同期を捌く仕組み
- REST / GraphQL / RPC / tRPC — それぞれが解こうとした別の問題
- WebSocket / SSE / Long Polling — リアルタイムの 3 つの選択肢
- リトライ / 冪等性 / 指数バックオフ — 通信は失敗するもの

## ジャンル内ロードマップ

```
00-concept/
  overview.md                        # 通信モデル / 非同期の本質 / Latency vs Throughput
  mental-model.md                    # イベントループ図 / Promise 状態遷移 / HTTP メッセージ構造
  key-terms.md                       # Promise / async-await / HTTP / WebSocket / SSE / 冪等性 / バックオフ

01-implementation/
  walkthrough.md                     # fetch + AbortController + リトライを書く / WebSocket でチャット
  code/
  self-explanation-prompts.md

02-comparison/
  services-overview.md               # REST / GraphQL / tRPC / gRPC / WebSocket / SSE / Polling
  why-each-exists.md                 # 各 API スタイルの誕生背景
  decision-matrix.md

quiz/
_log/
```

## 推奨学習順

1. `00-concept/overview.md` で **同期通信と非同期通信の違い** を物理的に理解
2. `00-concept/mental-model.md` で「Promise が pending → fulfilled になる瞬間に何が起きるか」を可視化
3. `01-implementation/` で **失敗する通信** を書き、リトライを足す
4. `02-comparison/` で REST と GraphQL を同じ機能で書き比べる

## 関連ジャンル

- `../state-and-time/`: 楽観的 UI / サーバー状態キャッシュ
- `../persistence/`: コネクションプール / レイテンシ
- `../auth-trust/`: HTTPS / Authorization ヘッダ / CORS / CSRF

## 主な比較対象サービス

| カテゴリ          | 代表                              | 設計上の重点                                              |
| ----------------- | --------------------------------- | --------------------------------------------------------- |
| HTTP クライアント | fetch / axios / ky                | 標準 vs インターセプタ vs DX                              |
| データフェッチ層  | TanStack Query / SWR / RTK Query  | キャッシュ + 再検証 + 楽観的更新                          |
| API スタイル      | REST / GraphQL / tRPC / gRPC      | リソース指向 / クエリ言語 / 型安全 RPC / バイナリ高速通信 |
| Realtime          | WebSocket / SSE / Long Polling    | 双方向 / 単方向ストリーム / 互換性重視                    |
| BaaS Realtime     | Supabase Realtime / Pusher / Ably | Postgres CDC / Pub-Sub サービス                           |
| ストリーミング    | Streaming SSE / Server Components | LLM 出力 / Suspense streaming                             |

## Dreyfus 到達基準

| Lv. | できること                                                                   |
| --- | ---------------------------------------------------------------------------- |
| 1   | URL を叩けばデータが返る、async と sync の違いを説明できる                   |
| 2   | fetch + JSON で REST API を叩き、Promise / async-await を読める              |
| 3   | エラー処理 / リトライ / AbortController を扱え、WebSocket 接続を維持できる   |
| 4   | REST / GraphQL / RPC を比較選択、CORS / CSRF / キャッシュ戦略を設計できる    |
| 5   | 大規模分散の整合性 / バックプレッシャ / リトライポリシーを統合的に設計できる |
