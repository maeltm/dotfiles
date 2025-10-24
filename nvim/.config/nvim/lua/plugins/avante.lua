return {
    -- AI
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "ollama",
            cursor_applying_provider = "ollama",
            providers = {
                ollama = {
                    endpoint = "http://10.10.40.171:11434",
                    model = "gemma3:12b", -- your desired model (or use gpt-4o, etc.)
                    timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
                    extra_request_body = {
                        temperature = 0,
                        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
                    },
                },
            },
            behavior = {
                enable_cursor_planning_mode = true,
            },
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make BUILD_FROM_SOURCE=true", -- for linux
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "hrsh7th/nvim-cmp",
            --- The below dependencies are optional,
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
}
