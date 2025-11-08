# Neovim Architecture (kz)

このドキュメントは、`~/.config/nvim` にある現在の Neovim 設定（最終更新: 2025-11-04）を俯瞰できるようにまとめたものです。構成、起動フロー、プラグイン構成、主要キーマップ、保守手順、外部依存を記載しています。

---

## 概要
- プラグインマネージャ: lazy.nvim（モジュール分割したプラグイン定義を自動収集）
- リーダーキー: Space（`<Space>`）
- 主要目的: Web フロント開発の生産性向上、快適な UI、最低限の LSP（Arduino 特化）、AI 補助（Copilot）
- 設定レイヤ: `options`（基本/見た目/キーマップ）と `plugins`（機能別モジュール）

---

## ディレクトリ構成
```
~/.config/nvim
├─ init.lua
├─ lazy-lock.json
├─ lua/
│  ├─ options/
│  │  ├─ basic.lua
│  │  ├─ keymap.lua
│  │  └─ ui.lua
│  └─ plugins/
│     ├─ init.lua           # プラグイン定義の自動集約
│     ├─ colorscheme.lua    # テーマ jellybeans
│     ├─ treesitter.lua     # 構文木ハイライト
│     ├─ telescope*.lua     # ファジー検索
│     ├─ neo-tree.lua       # ファイルエクスプローラ
│     ├─ bufferline.lua     # バッファタブ
│     ├─ lualine.lua        # ステータスライン
│     ├─ indent-blankline.lua / rainbow-delimiters.lua
│     ├─ gitsigns.lua / toggleterm.lua
│     ├─ cmp-simple.lua / snippets.lua / autopair.lua
│     ├─ comment.lua / todo-comments.lua / trouble.lua
│     ├─ project.lua / dashboard.lua / neoscroll.lua
│     ├─ web_dev.lua / emmet-simple.lua / prisma.lua
│     └─ lsp.lua            # Arduino LSP + 専用コマンド
└─ luasnippets/             # LuaSnip のローカルスニペット
```

---

## 起動フロー
1. `init.lua`
   - リーダーキー設定と runtimepath に lazy.nvim を追加
   - 互換性 shim（`vim.lsp.buf_get_clients` → `vim.lsp.get_clients`）
   - `require("lazy").setup("plugins")` で `lua/plugins/*.lua` を読み込み
   - `options` の基本/キーマップ/UI 読み込み、`luasnippets` をロード
   - 備考: 以前は「ファイラーのみ残ったら自動終了」していたが、
     `<leader>x` で最後のバッファを閉じた際に終了してしまうため削除済み。
2. `lua/plugins/init.lua`
   - `lua/plugins/` 配下の各ファイルを `require("plugins.<name>")` して table を結合・返却

---

## プラグインマネージャ（lazy.nvim）
- 仕様: `lua/plugins` 下の各 Lua が 1 つのプラグイン定義（あるいは配列）を `return`。
- 集約: `lua/plugins/init.lua` がファイルを列挙し、`init.lua` から lazy.nvim に渡されます。
- ロック: `lazy-lock.json` にバージョン固定。

---

## プラグイン（カテゴリ別）

### UI/ナビゲーション
- テーマ: `nanotech/jellybeans.vim`
- ステータスライン: `nvim-lualine/lualine.nvim`
- バッファタブ: `akinsho/bufferline.nvim`
- ファイルツリー: `nvim-neo-tree/neo-tree.nvim`（`<leader>e`/`<C-m>` でトグル, `<leader>E`/`<C-n>` でフォーカス）
- 起動画面: `nvimdev/dashboard-nvim`
- インデント可視化: `lukas-reineke/indent-blankline.nvim`（`ibl`）
- 対応括弧着色: `HiPhish/rainbow-delimiters.nvim`
- スムーズスクロール: `karb94/neoscroll.nvim`

### 検索/移動
- FZF 連携ファジー検索: `nvim-telescope/telescope.nvim` + `telescope-fzf-native.nvim`
- プロジェクトルート管理: `ahmedkhalf/project.nvim`

### 編集支援
- コメントトグル: `numToStr/Comment.nvim`
- TODO 管理 + Telescope: `folke/todo-comments.nvim`
- クイック診断リスト: `folke/trouble.nvim`
- 自動ペア入力: `windwp/nvim-autopairs`
- スニペット: `L3MON4D3/LuaSnip` + `rafamadriz/friendly-snippets`
- コード実行: `michaelb/sniprun`
 - メッセージ/コマンドライン UI: `folke/noice.nvim`（依存: `nui.nvim`, 推奨: `nvim-notify`）

### Git/ターミナル
- 行単位差分/ブレーム: `lewis6991/gitsigns.nvim`
- 内蔵ターミナル + LazyGit: `akinsho/toggleterm.nvim`

### 構文解析/ハイライト
- Treesitter 本体: `nvim-treesitter/nvim-treesitter`
- HTML タグ自動クローズ: `windwp/nvim-ts-autotag`
- CSS 色プレビュー: `norcalli/nvim-colorizer.lua`

### Web 開発
- JSON スキーマ: `b0o/schemastore.nvim`
- Prettier 連携: `prettier/vim-prettier`
- Emmet: `mattn/emmet-vim`
- Prisma: `prisma/vim-prisma`
- ライブサーバ: `wolandark/vim-live-server`（`:LiveServerStart` / `:LiveServerStop`）
 - Bun 優先の Live Server 起動: `:BunServerStart` / `:BunServerStop`（bun が無い場合は vim-live-server にフォールバック）

### AI
- Copilot: `zbirenbaum/copilot.lua`
- Copilot Chat: `CopilotC-Nvim/CopilotChat.nvim`（`github/copilot.vim` 依存）

### 補完（nvim-cmp）
- 本体: `hrsh7th/nvim-cmp`
- ソース: `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-cmdline`, `cmp_luasnip`
- 表示アイコン: `onsails/lspkind.nvim`

---

## LSP と補完の流れ
- LSP: Arduino 専用構成（`arduino-language-server`）
  - `:ArduinoCompile`, `:ArduinoUpload[ <port> ]`, `:ArduinoFqbn <name>` のユーティリティコマンドを提供
  - FQBN は `g:arduino_fqbn` または `ARDUINO_FQBN` 環境変数で切替
  - `cmp-nvim-lsp` が `capabilities` を自動拡張
- 補完: nvim-cmp が LSP/スニペット/バッファ/パス/コマンドラインを統合

データフロー（概念図）
```
Buffer → Treesitter → (必要に応じ LSP) → nvim-cmp ← LuaSnip / Buffer / Path / Cmdline
                                           │
                                           └→ lspkind で表示装飾
```

---

## 主要キーマップ（抜粋）
- ファイルツリー: `<C-m>`/`<leader>e` でトグル, `<C-n>`/`<leader>E` でフォーカス
- Telescope: `<leader>ff` ファイル, `<leader>fg` grep, `<leader>fb` バッファ…
- バッファ巡回: `<Tab>` / `<S-Tab>`, 閉じる `<leader>x`, 他を閉じる `<leader>X`
- Git: ハンク移動 `]c/[c`, ステージ `<leader>hs`, プレビュー `<leader>hp`
- ターミナル: `<leader>tt` でトグル, LazyGit `<leader>gg`
- TODO: `]t/[t`, Telescope `<leader>ft`
- SnipRun: 選択実行 `<leader>r`, 行実行 `<leader>rr`
- Emmet: Insert で `<C-e>` 系（`,`, `;` など）
- Copilot Chat: `<leader>cc`（Normal/Visual）

※ 詳細は各 `lua/plugins/*.lua` と `lua/options/keymap.lua` を参照。

---

## パフォーマンス/UX
- 速度系: `lazyredraw`, `updatetime=300`, `synmaxcol=200`、大規模ファイルで機能を間引き
- Treesitter: 10万行以上で自動無効化、Markdown は従来ハイライト併用
- 背景の透明化: ターミナルの背景色を使用（`options/ui.lua` で主要グループを `bg = NONE`）
- Insert→Normal で自動保存（変更済みバッファのみ・静かに `:update`）

---

## プラグイン追加手順
1. `lua/plugins/your_plugin.lua` を新規作成
2. lazy.nvim の仕様に沿ってテーブルを `return` する
3. `:Lazy sync` を実行

サンプル:
```lua
-- lua/plugins/example.lua
return {
  "author/repo",
  event = "VeryLazy",
  opts = {
    -- plugin options
  },
  config = function(_, opts)
    require("plugin").setup(opts)
  end,
}
```

`lua/plugins/init.lua` が自動で検出・集約するため、追記は不要です。

---

## 保守コマンド
- `:Lazy` / `:Lazy sync` / `:Lazy update` / `:Lazy clean`
- `:checkhealth`（依存チェック）
- `:TSUpdate`（Treesitter 更新）

---

## 外部依存と前提
- Arduino: `arduino-language-server`（`~/go/bin/arduino-language-server`）、`arduino-cli`（`/opt/homebrew/bin/arduino-cli`）、`~/Library/Arduino15/arduino-cli.yaml`
- Telescope FZF: `make` が必要（`telescope-fzf-native.nvim`）
- SnipRun: `sh install.sh` により依存を取得
- Prettier: Node.js と各言語プラグイン（プロジェクト依存）
 - Live Server: Bun 推奨（`bunx --bun live-server` を使用）。Node の場合は `npm i -g live-server`
- Copilot: `:Copilot auth` でログイン

---

## 既知の注意点
- `lazy/` ディレクトリに `lazy.nvim` のコピーがありますが、`init.lua` は `stdpath('data')/lazy/lazy.nvim` を参照します（通常はデータディレクトリにインストール）。
- Emmet の `<C-e>` キーは Insert モードのみ。`neoscroll` の `<C-e>`（スクロール）は Normal/Visual なので競合しません。

---

## 参照（主要な実装箇所）
- `init.lua`: リーダーキー/起動フロー/スニペット/自動終了
- `lua/plugins/init.lua`: プラグイン自動集約
- `lua/options/basic.lua`: 基本・パフォーマンス最適化
- `lua/options/ui.lua`: 背景を透明化（端末背景を使用）
- `lua/options/keymap.lua`: 共通キーマップ・自動保存
- `lua/plugins/lsp.lua`: Arduino LSP とユーティリティコマンド
- `lua/plugins/cmp-simple.lua`: nvim-cmp のマッピング/ソース
- `lua/plugins/telescope.lua`: Telescope 設定とキーマップ
- `lua/plugins/neo-tree.lua`: Neo-tree のキー/設定
- `lua/plugins/bufferline.lua`: バッファラインとキー
- `lua/plugins/toggleterm.lua`: LazyGit トグル

---

必要に応じて、このドキュメントは増補していけます。新しいプラグインの導入や大きな構成変更を行った際は、本ファイルに追記してください。
