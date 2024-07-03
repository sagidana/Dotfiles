vim.g.mapleader = " "
vim.opt.cursorline = true

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup(
{
    {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                }
            }
        end,
    },
    'nvim-treesitter/playground',
    'mg979/vim-visual-multi',
    -- {
        -- 'theprimeagen/harpoon',
        -- dependencies = { 'nvim-lua/plenary.nvim' },
        -- config = function()
        -- local mark = require("harpoon.mark")
        -- local ui = require("harpoon.ui")

        -- vim.keymap.set("n", "<leader>a", mark.add_file)
        -- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
        -- end
    -- },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end
    },

    'neovim/nvim-lspconfig',
    {
        'williamboman/mason.nvim',
        config = function()
            require("mason").setup()
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        on_attach = function(client, bufnr)
                            vim.keymap.set('n', 'K', vim.lsp.buf.hover)
                            vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
                            vim.keymap.set('n', 'gr', vim.lsp.buf.references)
                        end
                    })
                end,
                -- ["lua_ls"] = function()
                -- end
            })
            vim.diagnostic.config({  -- https://neovim.io/doc/user/diagnostic.html
                virtual_text = false,
                signs = false,
            })
        end
    },
})
