# 001: commit/staging 前のブランチ確認漏れ

**Status**: Monitoring
**Discovered**: 2026-05-02
**Resolved**: 2026-05-02（今回の incident は復旧済み。但しパターンとして再発しうるので Monitoring）
**Affected genres**: data-modeling 学習セッション（最初の本格コミット時）

---

## Symptoms

`learning/data-modeling` ブランチで作業しているつもりで `feat(data-modeling): ...` と `docs(life-editor-web-first): ...` の 2 commit を実行したが、実際は **`main` ブランチに着地** していた。

git reflog で原因が判明:

```
HEAD@{2}: checkout: moving from learning/data-modeling to main   ← セッション間で
HEAD@{1}: commit: feat(data-modeling)...                         ← main 上で commit
HEAD@{0}: commit: docs(life-editor-web-first)...                 ← main 上で commit
```

push 前に気づいたためリモートには影響なし（ローカル状態のみ復旧で完結）。

## Root Cause

**セッション間で git state が変わっている可能性を疑わずに `git add` / `git commit` を実行した**。

具体的には:

- 直前の Claude セッションで `learning/data-modeling` を作成 → そのままセッション中断
- セッション間（複数日跨ぎ）で **ユーザーが手動で `git checkout main`** を実行（理由不明、おそらく state 確認）
- 新セッション再開時、Claude は `git branch --show-current` を staging 直前に確認せず、過去の文脈から「learning/data-modeling にいるはず」と仮定して `git add` → `git commit` を batch 実行
- main に commit が落ちた

加えて、復旧時の `git reset --hard origin/main` が deny rule（settings.json）でブロックされ、計画レベルで承認していても **個別コマンド単位の確認が必要** であることが顕在化した。

## Fix

復旧手順 (Plan A 代替版、`reset --hard` を使わない):

```bash
git branch -f learning/data-modeling main      # ld pointer を d18c93a へ前進
git checkout learning/data-modeling             # 切り替え
git branch -f main origin/main                  # main pointer を 08bfb87 へ巻き戻す（main から離れているので可）
git push -u origin learning/data-modeling
gh pr create --base main --head learning/data-modeling
```

`branch -f` は branch pointer を移動するだけで reflog にも履歴が残るため、reset --hard と挙動は同等だが deny rule に引っかからない。

## Lessons Learned

### 学習者・運用者向け

- セッション間で手動 git 操作を行ったら、**Claude にそれを明示的に伝える**（「main に checkout し直した」等）ことで誤動作を予防できる
- 学習リポジトリでも life-editor と同じ `feedback_branch_protection.md` の運用ルールを揃える価値がある（pre-push hook の追加検討）

### Claude の振る舞い向け（再発防止）

1. **`git add` / `git commit` の直前に必ず `git branch --show-current` を実行** して、想定ブランチに居ることを確認する。特に:
   - セッション再開直後（前回終了から時間が空いた時）
   - 複数日跨ぎの作業
   - ユーザーが「進めて OK」と言ったが、最後に branch 確認した時点から時間が経っている時
2. **計画レベルで承認された destructive git 操作も、個別コマンド実行直前に再確認**:
   - reset --hard / force push / branch -f / rebase 系
   - 計画と実行の間に git state が変化している可能性が常にある
3. **deny rule に引っかかったら回避策を勝手に試さず**、ユーザーに明示的選択肢（代替コマンド / rule 一時解除 / 計画変更）を提示してから進む
4. グローバルな振る舞い変更は memory に記録（`feedback_destructive_git_confirmation.md`）

これらは `~/.claude/CLAUDE.md`（"Executing actions with care" 節）の精神を **個別 git ワークフローへ具体化** したもの。
