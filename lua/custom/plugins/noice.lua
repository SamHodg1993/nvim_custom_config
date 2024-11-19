-- local M = {
--     "folke/noice.nvim",
--     event = "VeryLazy",
--     dependencies = {
--         "MunifTanjim/nui.nvim",
--         "rcarriga/nvim-notify",
--     }
-- }
--
-- M.opts = {
--     -- Simple view configuration
--     views = {
--         cmdline_popup = {
--             position = {
--                 row = "50%",
--                 col = "50%",
--             },
--         },
--     },
--
--     -- Disable features that might cause conflicts
--     lsp = {
--         override = {
--             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--             ["vim.lsp.util.stylize_markdown"] = true,
--             ["cmp.entry.get_documentation"] = true,
--         },
--     },
--
--     -- Simple presets
--     presets = {
--         bottom_search = true,
--         command_palette = true,
--         long_message_to_split = false,
--     },
--
--     -- Minimal routes to start with
--     routes = {
--         {
--             filter = {
--                 event = "msg_show",
--                 kind = "",
--                 find = "written",
--             },
--             opts = { skip = true },
--         },
--     },
--
--     -- Basic notification settings
--     notify = {
--         enabled = true,
--         view = "notify",
--     },
-- }
--
-- return M

return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("notify").setup({
            background_colour = "#000000",
            stages = "fade",
            timeout = 3000,
            render = "default",
            icons = {
                ERROR = "",
                WARN = "",
                INFO = "",
                DEBUG = "",
                TRACE = "✎",
            },
        })
        -- Set as default notify handler
        vim.notify = require("notify")
        require("noice").setup({
            cmdline = {
                enabled = true,
                view = "cmdline_popup",
                format = {
                    cmdline = { pattern = "^:", icon = "", lang = "vim" },
                    search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                    search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                    filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                    lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
                    help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
                },
            },
            messages = {
                enabled = true,
                view = "notify",
                view_error = "notify",
                view_warn = "notify",
                view_history = "messages",
                view_search = "virtualtext",
            },
            popupmenu = {
                enabled = true,
                backend = "nui",
            },
            lsp = {
                progress = {
                    enabled = true,
                    format = "lsp_progress",
                    format_done = "lsp_progress_done",
                    throttle = 1000 / 30,
                    view = "mini",
                },
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
                hover = {
                    enabled = true,
                    silent = false,
                    view = nil,
                    render = "plain",
                },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        luasnip = true,
                        throttle = 50,
                    },
                    view = nil,
                    render = "plain",
                },
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = "50%",
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = "auto",
                    },
                },
                popupmenu = {
                    relative = "editor",
                    position = {
                        row = 8,
                        col = "50%",
                    },
                    size = {
                        width = 60,
                        height = 10,
                    },
                    border = {
                        style = "rounded",
                        padding = { 0, 1 },
                    },
                    win_options = {
                        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                    },
                },
            },
        })
    end
}
