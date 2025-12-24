--plugins
require('pckr').add{

	{ "nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, run = ":TSUpdate" },
	{ 'nvim-lua/plenary.nvim' }, -- dependency for one of these plugins
	{ 'nvim-telescope/telescope.nvim' }, --fuzzy finder
	{ 'shaunsingh/nord.nvim' }, --nord theme
	{ "ThePrimeagen/harpoon" }, --file switcher
    { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp"},
    { "rafamadriz/friendly-snippets" },

	--LSP config
    { 'mason-org/mason.nvim' }, --lsp manager
	{ 'neovim/nvim-lspconfig' },
	{ 'hrsh7th/nvim-cmp' }, -- autocompletion 
	{ 'hrsh7th/cmp-nvim-lsp' }, --autocompletion
	{ 'seblyng/roslyn.nvim' }, --LSP for C#
    { 'mattn/emmet-vim' }, --html emmet
    -- { 'fatih/vim-go', run = ":GoUpdateBinaries" },

    -- UI --
    { 'nvim-lualine/lualine.nvim' }, --status bar themer	
    { 'nvim-tree/nvim-web-devicons' }, --status bar icon	
    { 'folke/which-key.nvim' },	-- pop keybinding display
    { 'lukas-reineke/indent-blankline.nvim' }, --indent guide
    { 'nvim-mini/mini.pairs' }, -- automatically append quotes/brackets/parentheses
    { 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }, -- autoclose html tags

    {
        "Jezda1337/nvim-html-css",
        ft = { "html", "css", "javascriptreact", "typescriptreact", "razor" }
    }


}

