# Keymap Quick Reference (kz)

最終更新: 2025-11-04。`<leader>` はスペース（` `）。モード表記: [n]=Normal, [i]=Insert, [v]=Visual, [x]=Visual/Select, [o]=Operator-pending, [t]=Terminal。

---

## ファイラー / バッファ
- [n] `<C-m>` → Neo-tree トグル（`:Neotree toggle`） — `lua/options/keymap.lua:1`
- [n] `<C-n>` → Neo-tree にフォーカス — `lua/options/keymap.lua:2`
- [n] `<leader>e` / `<leader>E` → Neo-tree トグル/フォーカス — `lua/plugins/neo-tree.lua:11`
- [n] `<Tab>` / `<S-Tab>` → 次/前バッファ — `lua/plugins/bufferline.lua:64`
- [n] `<leader>x` → 現在バッファを閉じる — `lua/plugins/bufferline.lua:66`
- [n] `<leader>X` → その他のバッファを閉じる — `lua/plugins/bufferline.lua:67`
- [n] `<leader>bp` → ピン切替 — `lua/plugins/bufferline.lua:68`
- [n] `<leader>bP` → 非ピンを一括閉じ — `lua/plugins/bufferline.lua:69`
- [n] `[b` / `]b` → 前/次バッファへ — `lua/plugins/bufferline.lua:70`

## 検索 / 移動（Telescope）
- [n] `<leader>ff` → ファイル検索 — `lua/plugins/telescope.lua:73`
- [n] `<leader>fg` → live grep — `lua/plugins/telescope.lua:74`
- [n] `<leader>fw` → カーソル単語 grep — `lua/plugins/telescope.lua:75`
- [n] `<leader>fb` → バッファ一覧 — `lua/plugins/telescope.lua:76`
- [n] `<leader>fh` → ヘルプ — `lua/plugins/telescope.lua:77`
- [n] `<leader>fr` → 最近のファイル — `lua/plugins/telescope.lua:78`
- [n] `<leader>fc` → コマンド — `lua/plugins/telescope.lua:79`
- [n] `<leader>fk` → キーマップ — `lua/plugins/telescope.lua:80`
- [n] `<leader>fs` / `<leader>fS` → LSP シンボル（バッファ/WS）— `lua/plugins/telescope.lua:81`
- Telescope プロンプト内（参考）— `lua/plugins/telescope.lua:33`
  - [i] `<C-j>/<C-k>` 移動, `<C-q>` QF, `<C-x>/<C-v>/<C-t>` 分割/新タブ, `<C-u>/<C-d>` プレビュー, `<Esc>/q` 閉じる

## Git（Gitsigns）
- [n] `]c` / `[c` → 次/前ハンク — `lua/plugins/gitsigns.lua:45`
- [n] `<leader>hs` / `<leader>hr` → ハンクをステージ/リセット — `lua/plugins/gitsigns.lua:58`
- [v] `<leader>hs` / `<leader>hr` → 選択範囲をステージ/リセット — `lua/plugins/gitsigns.lua:60`
- [n] `<leader>hS` / `<leader>hR` → バッファをステージ/リセット — `lua/plugins/gitsigns.lua:62`
- [n] `<leader>hu` → ステージ取り消し — `lua/plugins/gitsigns.lua:63`
- [n] `<leader>hp` → ハンクプレビュー — `lua/plugins/gitsigns.lua:65`
- [n] `<leader>hb` → blame 行（詳細）— `lua/plugins/gitsigns.lua:66`
- [n] `<leader>tb` → 行 blame トグル — `lua/plugins/gitsigns.lua:67`
- [n] `<leader>hd` / `<leader>hD` → diff（対 HEAD/`~`）— `lua/plugins/gitsigns.lua:68`
- [n] `<leader>td` → 削除行の表示トグル — `lua/plugins/gitsigns.lua:70`
- [o,x] `ih` → ハンク textobject — `lua/plugins/gitsigns.lua:73`

## ターミナル / ツール
- [n,t] `<leader>tt` → ToggleTerm トグル — `lua/plugins/toggleterm.lua:13`
- [n] `<leader>gg` → LazyGit（浮動）— `lua/plugins/toggleterm.lua:11`
- [n] `<leader>ls` / `<leader>lq` → Live Server 開始/停止（Bun 優先）— `lua/options/keymap.lua:24`
- ToggleTerm の開閉キー: `<C-\>` — `lua/plugins/toggleterm.lua:20`

## LSP（Arduino など LSP アタッチ時）
- [n] `gd/gD/gi/gr` → 定義/宣言/実装/参照 — `lua/plugins/lsp.lua:47`
- [n] `K` → ホバー — `lua/plugins/lsp.lua:51`
- [n] `<leader>rn` → リネーム — `lua/plugins/lsp.lua:52`
- [n] `<leader>ca` → コードアクション — `lua/plugins/lsp.lua:53`
- [n] `<leader>cf` → フォーマット — `lua/plugins/lsp.lua:54`
- コマンド: `:ArduinoCompile` / `:ArduinoUpload [port]` / `:ArduinoFqbn <fqbn>` — `lua/plugins/lsp.lua:119`

## 診断 / TODO / シンボル（Trouble / todo-comments）
- [n] `<leader>xx` → Diagnostics（全体）— `lua/plugins/trouble.lua:60`
- [n] `<leader>xX` → Diagnostics（バッファ）— `lua/plugins/trouble.lua:61`
- [n] `<leader>cs` → Symbols（右下）— `lua/plugins/trouble.lua:62`
- [n] `<leader>cl` → LSP 一覧（右）— `lua/plugins/trouble.lua:63`
- [n] `<leader>xL` / `<leader>xQ` → loclist / quickfix — `lua/plugins/trouble.lua:64`
- [n] `<leader>ft` / `<leader>fT` → TODO 検索（全体/主要）— `lua/plugins/todo-comments.lua:61`
- [n] `]t` / `[t` → 次/前の TODO にジャンプ — `lua/plugins/todo-comments.lua:63`

## 補完 / スニペット（nvim-cmp / LuaSnip / SnipRun）
- [i] `<Tab>` / `<S-Tab>` → 補完候補 次/前 — `lua/plugins/cmp-simple.lua:25`
- [i] `<CR>` → 補完確定（選択を自動確定）— `lua/plugins/cmp-simple.lua:27`
- [i] `<C-Space>` → 補完トリガー — `lua/plugins/cmp-simple.lua:28`
- [i] `<C-e>` → 補完キャンセル — `lua/plugins/cmp-simple.lua:29`
- [v] `<leader>r` → 選択コード実行（SnipRun）— `lua/plugins/sniprun.lua:47`
- [n] `<leader>r` / `rr` → オペレータ/行実行 — `lua/plugins/sniprun.lua:48`
- [n] `<leader>rc` / `rx` / `ri` → リセット/クローズ/情報 — `lua/plugins/sniprun.lua:50`

## コメント
- [operator] `gc`（行/モーション）/ `gb`（ブロック）— `lua/plugins/comment.lua:6`

## スクロール（Neoscroll）
- [n,v,x] `<C-u>/<C-d>` / `<C-b>/<C-f>` → スムーズスクロール — `lua/plugins/neoscroll.lua:25`
- [n,v,x] `<C-y>/<C-e>` → 少量スクロール — `lua/plugins/neoscroll.lua:29`
- [n,v,x] `zt/zz/zb` → スムーズ再配置 — `lua/plugins/neoscroll.lua:31`

## Emmet（HTML/JSX など）
- [i] `<C-e>,` → 略記展開 — `lua/options/keymap.lua:30`
- [i] `<C-e>;` → 単語展開 — `lua/options/keymap.lua:31`
- [i] `<C-e>` → 略記展開（ショートカット）— `lua/options/keymap.lua:34`
- 備考: Emmet のリーダーは `<C-e>`（`lua/plugins/emmet-simple.lua:7`）。nvim-cmp の `<C-e>`（中断）と競合する場合は、どちらかを変更してください。

## AI（Copilot / Copilot Chat）
- [n,v] `<leader>cc` → Copilot Chat を開く — `lua/options/keymap.lua:19`
- Copilot 提案（Insert 中）— `lua/plugins/copilot.lua:12`
  - [i] 受け入れ `<M-l>`／単語 `<M-w>`／行 `<M-j>`／次候補 `<M-]>`／前候補 `<M-[>`／閉じる `<C-]>`

## ダッシュボード（起動画面内）
- [normal in Dashboard] `u` 更新（Lazy update）, `f` Files, `r` Recent, `p` Projects, `c` Config, `q` Quit — `lua/plugins/dashboard.lua:12`

---

## メモ
- 多くの LSP/Git キーマップはバッファローカルです（該当バッファでのみ有効）。
- 競合例: Emmet `<C-e>` と nvim-cmp `<C-e>`。必要に応じてどちらかを変更してください。
- 追加/変更時はこのファイルに追記してください。

