# Known Issues — INDEX

study-board 開発中に詰まったポイントの Root Cause + 再発防止知見を蓄積する。MEMORY.md / HISTORY.md では拾えないものをここに残す。

## 運用

- 詰まった瞬間に `NNN-<slug>.md` を作成、Status=Active
- 解決時に Status=Fixed + Resolved 日付 + Lessons Learned 追記
- 類似バグ再発時はまずこの INDEX を grep

## ファイル形式（テンプレート）

```markdown
# NNN — <slug>

- **Status**: Active / Fixed / Monitoring
- **Discovered**: YYYY-MM-DD
- **Resolved**: YYYY-MM-DD（Fixed の場合）
- **Phase**: 1.x / 2.x / 3.x

## 症状

何が起きた？ どう困った？

## Root Cause

なぜそうなった？ 1 段階深く（「タイポ」じゃなく「JS の何の挙動を勘違いしてた」レベルまで）

## 修正方法

どう直した？ コード抜粋付き

## Lessons Learned

次回同じ罠を避けるために、何を覚えておく？
```

---

## Active

（なし — 詰まったら追記）

## Fixed

（なし）

## Monitoring

（なし）
