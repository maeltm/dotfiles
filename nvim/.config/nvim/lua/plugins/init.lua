return {
    -- lazy.nvim은 알아서 설치되었으니 생략
    { "nvim-lua/plenary.nvim" },

    -- 테마
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme("tokyonight-storm")
        end
    },

    -- UI
    {
        "vim-airline/vim-airline",
        lazy = false,
        dependencies = { "ryanoasis/vim-devicons" },
        init = function()
            vim.g["airline#extensions#tabline#enabled"] = 1
        end,
    },
    { "ryanoasis/vim-devicons", lazy = false },
    {
        "lambdalisue/glyph-palette.vim",
        lazy = false,
        dependencies = { "ryanoasis/vim-devicons" },
        config = function()
            vim.api.nvim_create_augroup("my_glyph_palette", { clear = true })
            vim.api.nvim_create_autocmd({ "FileType" }, {
                group = "my_glyph_palette",
                pattern = { "nerdtree" },
                callback = function()
                    vim.schedule(function()
                        vim.fn["glyph_palette#apply"]()
                    end)
                end,
            })
        end,
    },

    -- 파일탐색
    {
        "scrooloose/nerdtree",
        lazy = false,
        dependencies = { "ryanoasis/vim-devicons", "lambdalisue/glyph-palette.vim" },
        config = function()
            vim.g.NERDTreeQuitOnOpen = 0
            vim.g.NERDTreeShowHidden = 1
            vim.api.nvim_set_keymap("n", "<leader>k", ":NERDTreeToggle<cr>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>y", ":NERDTreeFind<cr>", { noremap = true, silent = true })
        end,
    },


    -- 검색
    {
        "junegunn/fzf",
        lazy = true,
        build = './install --bin',
    },
    {
        "junegunn/fzf.vim",
        dependencies = { "junegunn/fzf" },  -- fzf binary도 같이 필요
        cmd = { "Files", "Buffers", "Rg" }, -- lazy-load용
        keys = {
            { "<leader>r", "<cmd>Buffers<cr>", desc = "FZF Buffers" },
            { "<leader>t", "<cmd>Files<cr>",   desc = "FZF Files" },
            { "<leader>s", ":Rg ",             desc = "FZF Ripgrep" }, -- space 안붙이면 바로 입력창 못열림
        },
        config = function()
            vim.api.nvim_create_user_command("Rg", function(opts)
                local query = table.concat(opts.fargs, " ")
                local command = "rg --column --line-number --no-heading --color=always --smart-case "
                    .. "-g '!.git' -g '!node_modules' -g '!.svn' -- "
                    .. vim.fn.shellescape(query)

                vim.fn["fzf#vim#grep"](command, 1, vim.fn["fzf#vim#with_preview"](), opts.bang and 1 or 0)
            end, { bang = true, nargs = "*" })
        end,
    },

    -- 이동
    { "easymotion/vim-easymotion" },
    { "christoomey/vim-tmux-navigator" },

    -- 코딩
    -- { "neoclide/coc.nvim", branch = "release" },
    -- { "SirVer/ultisnips" },
    -- { "honza/vim-snippets" },

    { "fatih/vim-go",                  build = ":GoUpdateBinaries" },
    { "OmniSharp/omnisharp-vim" },

    { "plasticboy/vim-markdown" },
    {
        "vimwiki/vimwiki",
        lazy = false,
        init = function()
            vim.g.vimwiki_list = { {
                path = os.getenv('HOME') .. '/workspace/notes/',
                syntax = 'markdown',
                ext = '.md'
            } }

            vim.g.vimwiki_conceallevel = 0
            vim.g.vimwiki_global_ext = 0

            vim.g.vimwiki_key_mappings = {
                all_maps = 1,
                global = 1,
                headers = 1,
                text_objs = 1,
                table_format = 1,
                table_mappings = 0,
                lists = 1,
                links = 1,
                html = 0,
                mouse = 1,
            }
        end,
        config = function()
            -- keymap
            vim.api.nvim_set_keymap('n', '<Leader>lt', '<Plug>VimwikiToggleListItem', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('v', '<Leader>lt', '<Plug>VimwikiToggleListItem', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>VimwikiTableNextCell', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('i', '<C-h>', '<Plug>VimwikiTablePrevCell', { noremap = true, silent = true })
        end,

    },
    { "chrisbra/csv.vim" },
    { "tomlion/vim-solidity" },
    { "posva/vim-vue" },
    { "leafgarland/typescript-vim" },
    { "moll/vim-node" },
    {
        "editorconfig/editorconfig-vim",
        lazy = false,
        config = function()
            vim.g.EditorConfig_exclude_patterns = {
                "fugitive://.*",
                "scp://.*"
            }
        end,
    },

    -- 기타
    { "tpope/vim-fugitive" },
    { "tpope/vim-sensible" },
    { "tpope/vim-surround" },
    { "godlygeek/tabular" },
    { "AndrewRadev/splitjoin.vim" },
    { "fcpg/vim-osc52" },

    -- Copilot
    { "github/copilot.vim" },

    -- Lint

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },


}
