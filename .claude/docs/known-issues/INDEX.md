# Known Issues INDEX — Programming Learning Workspace

つまずきパターン・誤理解・教材設計の落とし穴の Root Cause を蓄積する索引。同じ誤理解を **2 回以上** 踏んだら必ず登録する。

## Active（未解決）

（なし）

## Monitoring（要観察）

（なし）

## Resolved（解消済み）

（なし）

---

## 運用ルール

- **発見時**: `NNN-<slug>.md` を `_TEMPLATE.md` ベースで作成、本 INDEX に追記
- **解決時**: 修正方針・Lessons Learned を記録、INDEX の Active → Resolved 移動
- **再発時**: 同種のつまずきに遭遇したらまず本 INDEX を grep
- **対象**:
  - 概念の誤理解（例: 「Promise は async の糖衣構文だと思っていた」）
  - 教材設計の失敗（例: 「概念だけ書いて実装に行ったら混乱した」）
  - クイズが機能しなかったパターン（例: 「答えを見ても腹落ちしない問題形式」）
- **対象外**:
  - 一回きりの単純ミス（タイポ等）
  - 現プロジェクト固有の API バグ（それは `applications/<app>/` 内に記録）
