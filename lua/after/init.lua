require("luasnip.loaders.from_lua").load()

-- HARPOON --
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to Harpoon" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Open Harpoon Menu" })

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)


-- MASON --
require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})


vim.filetype.add({
  extension = {
    razor  = "html",
  },
})

-- AutoCompletion
local cmp = require('cmp')
local luasnip = require("luasnip")
cmp.setup({
    snippet = {
        expand = function(args)
            -- required even if not using snippets
            -- vim.fn["vsnip#anonymous"](args.body)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-k>'] = cmp.mapping.complete(),  -- manually trigger completion
        
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'html-css' },
    }),
    completion = {
        keyword_length = 1,
        completeopt = 'menu,menuone,noselect',
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
    }
})

local autotag = require('nvim-ts-autotag')
autotag.setup({
    enable = true,
    filetypes = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    skip_tags = { "img", "br", "hr" },  -- self-closing tags
})

local htmlcss = require('html-css')
htmlcss.setup({
    enable = true,
    enable_on = { "html" },
    handlers = {
        definition = {
            bind = "gd",
        },
        hover = {
            bind = "K",
            wrap = true,
            border = "none",
            position = "cursor",
        },
    },
    documentation = {
        auto_show = true,
    },
    style_sheets = {
        "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css",
        "./wwwroot/css/app.css",
        "./wwwroot/css/bootstrap/bootstrap.min.css"
    }
})

-- ROSLYN (C#)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("roslyn", {
    on_attach = function(client, bufnr)
        print("C# LSP attached to buffer " .. bufnr)
        -- You can set additional keymaps here if needed
    end,
    capabilities = capabilities,
    settings = {
        csharp = {
            inlayHints = {
                enableForImplicitVariableTypes = true,
                enableForImplicitObjectCreation = true,
            },
            codeLens = {
                references = true,
            },
        },
    },
})


vim.lsp.config("cssls", {
    on_attach = function(client, bufnr)
        print("CSS LSP attached to buffer " .. bufnr)
    end,
    capabilities = capabilities,
    filetypes = { "css", "scss", "sass", "less" },
    settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
    },
})

vim.lsp.enable("cssls")

-- GO
vim.lsp.config("gopls", {
    on_attach = function(client, bufnr)
        print("gopls attached to buffer " .. bufnr)

        -- Optional: format on zz
        vim.keymap.set("n", "zz", function()
            vim.lsp.buf.format({ timeout = 1000 })
        end, { buffer = bufnr, noremap = true, silent = true })
    end,
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
                unusedparams = true,
                nilness = true,
                shadow = true,
            },
        },
    },
})
vim.lsp.enable("gopls")

--
-- Automatically format on save for .cs files:
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.cs",
    callback = function()
        vim.lsp.buf.format({ timeout = 1000 })
    end,
})

-- LuaLine --
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = { { 'filename', path = 3 } },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- Indent Guide --
require("ibl").setup()

-- Auto insert quotes, brackets, parentheses
require('mini.pairs').setup()

-- luasnip
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- C# code snippets
ls.add_snippets("cs", {
    s("if", {
        t("if ("), i(1), t(")"),
        t({
            "",
            "{",
            "   ",
            "}"
        })
    }),

    s("while", {
        t("while ("), i(1), t(")"),
        t({
            "",
            "{",
            "   ",
            "}"
        })
    }),

    s("switch", {
        t("switch ("), i(1), t(")"),
        t({
            "",
            "{",
            "    case 1:",
            "       break;",
            "    case 2:",
            "        break;",
            "    case 3:",
            "        break;",
            "    default:",
            "        break;",
            "}"
        })
    }),

    s("prop", {
        t("public "), i(1), t(" { get; set; }"),
    }),

    s("props", {
        t("public string "), i(1), t(" { get; set; }"),
    }),

    s("propi", {
        t("public int "), i(1), t(" { get; set; }"),
    }),

    s("propb", {
        t("public bool "), i(1), t(" { get; set; }"),
    }),

    s("for", {
        t("for (int i = 0; i < 5; i++"), i(1), t(")"),
        t({
            "",
            "{",
            "   ",
            "}"
        })
    }),

    s("foreach", {
        t("foreach (var "), i(1), t(" in collection)"),
        t({
            "",
            "{",
            "   ",
            "}"
        })
    }),

    s("try", {
        t("try"),
        t({
            "",
            "{",
            "    ",
        }),
        i(1),
        t({
            "",
            "}",
            "catch (Exception ex)",
            "{",
            "    ",
            "}"
        })

    }),

    s("using", {
        t("using ("), i(1), t(")"),
        t({
            "",
            "{",
            "   ",
            "}"
        })
    }),
})


-- Keymap to expand snippet manually
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        return "<Plug>luasnip-expand-or-jump"
    end
end, { expr = true, silent = true })

