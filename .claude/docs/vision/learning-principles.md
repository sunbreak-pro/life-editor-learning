# Learning Principles — 学習科学 12 原則

> 教材設計・対話設計・クイズ設計の根拠。すべて一次研究 / メタ分析にリンクされている。Claude はこれらを尊重して `code-teacher` スキルを実行する。

---

## TL;DR

- 三本柱は **想起練習・分散学習・インターリービング**（Dunlosky 2013 で実証的に "High Utility" と評価された 2 + 認知科学で堅固な 1）
- プログラミング固有では **チャンク形成・ワーキングメモリ負荷制御・メンタルモデル構築**（Hermans 2021）
- 「**概念 → 実装 → 比較**」の 3 層構成は Marton の Variation Theory + Gentner の Analogical Encoding の両方から理論的支持を得る
- ただし **Interleaving と Spaced Repetition には適用条件がある**（前提知識ゼロで使うと逆効果）

---

## 12 原則

### 1. 想起を先に、答えは後に（Active Recall / Testing Effect）

**根拠**: Roediger & Karpicke 2006, _Psychological Science_（5 分後は再読有利、1 週間後は想起練習が大幅に勝つ）/ Dunlosky et al. 2013, _Psychological Science in the Public Interest_（10 技法のうち Practice Testing が "High Utility" 評価）

**実装**:

- クイズは「評価」ではなく「学習手段」として作る
- 答えを見る前に必ず想起を試みる（`*.answer.*` を別ファイルにして物理的に分離）
- 対話中も AskUserQuestion で先に問う

---

### 2. 分散復習スケジュール（Spaced Repetition）

**根拠**: Cepeda et al. 2006 メタ分析（317 研究、適切な間隔で保持率 +200%）/ Wozniak SM-2 アルゴリズム / FSRS

**実装**:

- `quiz/INDEX.md` に復習スケジュールを書く: 学習直後 → 翌日 → 3 日後 → 1 週間後 → 1 ヶ月後
- 宣言的知識（用語・API 名）に強く効く。手続き的知識への直接適用は過信禁物

**制限**: フラッシュカード化が困難な「問題解決プロセス」には限界がある

---

### 3. 基礎習得後にジャンル混合練習（Interleaving）

**根拠**: Bjork & Bjork 2011 "Creating Desirable Difficulties"（Blocked 練習は短期パフォーマンス高、Interleaved は 1 週間後の保持と転移が大幅に勝つ）

**制限**: Firth et al. 2021 _Review of Education_（前提知識なしの Interleaving は Cognitive Overload を招き逆効果）

**実装**:

- 初学段階は **ブロック練習**（同ジャンル内で連続）
- ある程度習熟した後にジャンル横断 quiz を導入
- ジャンル `README.md` に「Interleaving 解禁ライン」を記す

---

### 4. 認知負荷 3 要素を制御（Cognitive Load Theory）

**根拠**: Sweller 1988〜 / Kalyuga 2007（Expertise Reversal Effect）

**3 要素**:

- **Intrinsic（本質的）**: 内容そのものの複雑さ → ジャンルの分割で制御
- **Extraneous（余分）**: 提示の悪さ → 図解・コード断片の最小化
- **Germane（生産的）**: スキーマ形成のための処理 → Self-Explanation で促進

**実装**: 1 セッションで導入する新規用語は **7±2 個まで**（ワーキングメモリ制約 / Hermans 2021）

---

### 5. 初学者にはワーキングサンプル先行（Worked Example Effect）

**根拠**: Sweller / Chi et al. 1989（解説済み例題を先に見せると初学者の学習加速）

**重要な留保 — Expertise Reversal Effect**: 熟達者には詳細な解説例が **逆効果** になる

**実装**:

- `01-implementation/walkthrough.md` に完成形コードを最初に提示
- 段階的にヒントを削っていく（fade-out）
- ユーザーの段階（Dreyfus）に応じて詳細度を調整

---

### 6. Self-Explanation 質問を挿入（Elaboration）

**根拠**: Chi et al. 1989, _Cognitive Science_

**実装**:

- 各概念ファイルに `self-explanation-prompts.md` を置く
- 典型的な問い:
  - 「なぜこの設計を選んだのか？」
  - 「他の方法だとどこが破綻するか？」
  - 「この概念は別ジャンルの XX とどう関係するか？」

---

### 7. 概念 → 最小実装 → 複数サービス比較の 3 層（Variation Theory + Analogical Encoding）

**根拠**:

- Marton, _Phenomenography_ / Variation Theory（対比なしに概念の本質は見えない）
- Gentner et al. 2004（compare-contrast 群は単純提示群の **約 2 倍** の概念転用率）

**実装**: ジャンル内の標準ディレクトリ構成 `00-concept/ → 01-implementation/ → 02-comparison/` を必ず通る

**比較の質を上げるコツ**:

- 単一サービスの紹介ではなく、**2 つ以上を同時に並べる**
- 「同じ問題を別のアプローチで解いている」という構図を強調する
- 各サービスの **誕生背景**（why does it exist）を書く

---

### 8. Dreyfus 段階に応じスキャフォールディング調整

**根拠**: Dreyfus & Dreyfus 1986, _Mind Over Machine_ / Vygotsky ZPD

**5 段階**: Novice → Advanced Beginner → Competent → Proficient → Expert

**実装**:

- 初学者には詳細な手順 + 全 Worked Example
- Competent には部分的ヒント + 自分で組み合わせさせる
- Proficient には「設計判断を聞く」形式に切り替え（クイズが議論になる）

---

### 9. 最小動作アプリから始める（4C/ID）

**根拠**: van Merriënboer 1992〜 / 4C/ID メタ分析 g=0.76

**Transfer Paradox**: 部分スキルを順番に積み上げても全体タスクへの転移は起きない

**実装**:

- `applications/` を空のままにせず、**早期に最小動作アプリを置く**
- ジャンルは応用層に紐付ける（学んだ概念がどこで使われるか見える）

---

### 10. 状態の可視化を学習環境に組み込む（Learnable Programming / Programmer's Brain）

**根拠**: Bret Victor 2012 "Learnable Programming" / Hermans 2021 _The Programmer's Brain_（見えない状態はワーキングメモリを浪費する）

**実装**:

- 各 `00-concept/mental-model.md` に **状態遷移図 / データフロー図** を含める
- Mermaid で可能な限り可視化
- コード断片は「実行前後の状態」を併記する

---

### 11. コードを書かせる（Generation Effect）

**根拠**: Slamecka & Graf 1978（自己生成は読むだけより保持率が有意に高い、効果量 d ≈ 0.40）

**実装**:

- `quiz/` に穴埋めだけでなく **ゼロから書く** 問題を必ず混ぜる
- ハンズオンでは Worked Example を見た後に **自分で同じものを書き直す** ステップを必須化

---

### 12. 量より意図的フィードバック練習（Deliberate Practice）

**根拠**: Ericsson 1993（核心: フィードバックを伴う意図的練習）

**重要な留保**: Macnamara et al. 2014, _Psychological Science_ メタ分析（88 研究）— 意図的練習がパフォーマンス分散を説明する割合は職業領域で **1% 未満**。**「10,000 時間ルール」（Gladwell 解釈）は否定された**

**実装**:

- 時間量を目標にしない（"100 時間勉強"ではなく "5 ジャンル × 3 層 × 各 3 トピック" のような構造的目標）
- フィードバックを必ず受け取る（Claude との対話で代替可能）
- 自分で誤答に向き合うルールを `quiz/INDEX.md` に書く

---

## 注意すべき矛盾・未解決領域

### A. 10,000 時間ルール論争

- Ericsson: 量がほぼ全てを説明
- Macnamara 2014: 職業 < 1%、教育 4%、スポーツ 18%
- **結論**: 量より質（フィードバック付き意図的練習）という核心は維持。「時間を積めば必ず熟達」は否定

### B. Interleaving の適用閾値

- どの程度習熟すれば導入すべきかの定量基準は未確立
- 安全策: 初学はブロック → 一定習熟後に Interleaving、というフェーズ設計

### C. Code Reading vs Code Writing 論争

- 実務では読む時間が書く時間を 7:1〜200:1 で上回る
- 学習研究では Generation Effect から書く方が有利
- 直接比較した RCT は乏しい（**未解決**）
- 当面の方針: 両方やる。`01-implementation/` で書き、`02-comparison/` で読む

---

## 出典（一次・メタ）

| 番号 | 文献                                                                       | 用途                       | 出典                                                                                       |
| ---- | -------------------------------------------------------------------------- | -------------------------- | ------------------------------------------------------------------------------------------ |
| 1    | Roediger & Karpicke 2006, _Psychological Science_ "Test-Enhanced Learning" | 原則 1 (Testing Effect)    | https://pubmed.ncbi.nlm.nih.gov/16507066/                                                  |
| 2    | Dunlosky et al. 2013, _Psychological Science in the Public Interest_       | 原則 1, 2 (10 技法評価)    | https://journals.sagepub.com/doi/abs/10.1177/1529100612453266                              |
| 3    | Cepeda et al. 2006 メタ分析                                                | 原則 2 (分散学習 +200%)    | https://psycnet.apa.org/record/2006-04017-002                                              |
| 4    | Bjork & Bjork 2011 "Creating Desirable Difficulties"                       | 原則 3 (Interleaving)      | https://bjorklab.psych.ucla.edu/wp-content/uploads/sites/13/2016/04/EBjork_RBjork_2011.pdf |
| 5    | Firth et al. 2021, _Review of Education_                                   | 原則 3 (Interleaving 限界) | https://bera-journals.onlinelibrary.wiley.com/doi/10.1002/rev3.3266                        |
| 6    | Sweller 1988〜 / Kalyuga 2007 (Expertise Reversal)                         | 原則 4, 5                  | https://link.springer.com/article/10.1007/s10648-010-9128-5                                |
| 7    | Chi et al. 1989, _Cognitive Science_ "Self-Explanations"                   | 原則 5, 6                  | https://onlinelibrary.wiley.com/doi/abs/10.1207/s15516709cog1302_1                         |
| 8    | Marton, _Phenomenography_ / Variation Theory                               | 原則 7                     | https://link.springer.com/article/10.1007/s11858-017-0858-4                                |
| 9    | Gentner et al. 2004 "Analogical Encoding"                                  | 原則 7                     | https://groups.psych.northwestern.edu/gentner/papers/GentnerLoewensteinThompson04.pdf      |
| 10   | Dreyfus & Dreyfus 1986, _Mind Over Machine_                                | 原則 8                     | https://www.bumc.bu.edu/facdev-medicine/files/2012/03/Dreyfus-skill-level.pdf              |
| 11   | van Merriënboer 1992〜 (4C/ID)                                             | 原則 9                     | https://link.springer.com/article/10.1007/BF02504993                                       |
| 12   | Bret Victor 2012 "Learnable Programming"                                   | 原則 10                    | https://worrydream.com/LearnableProgramming/                                               |
| 13   | Hermans 2021 _The Programmer's Brain_                                      | 原則 4, 10                 | https://www.manning.com/books/the-programmers-brain                                        |
| 14   | Slamecka & Graf 1978 "Generation Effect"                                   | 原則 11                    | https://psycnet.apa.org/record/1979-22232-001                                              |
| 15   | Ericsson et al. 1993 "Deliberate Practice"                                 | 原則 12                    | https://psycnet.apa.org/record/1993-40718-001                                              |
| 16   | Macnamara et al. 2014, _Psychological Science_ メタ分析                    | 原則 12 (10k 時間否定)     | https://journals.sagepub.com/doi/abs/10.1177/0956797614535810                              |

---

## 更新フロー

1. 新たな学術知見を見つけたら、該当原則の根拠に追加
2. 実践で原則が機能しなかった場合、**原則を捨てるのではなく適用条件を絞る**（Interleaving のように）
3. 矛盾を見つけたら「未解決領域」セクションに追記する。隠さない
