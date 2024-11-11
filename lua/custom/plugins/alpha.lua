return {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        local generateText = require "custom.scripts.generateId"

        -- Get current working directory name
        local function get_project_name()
            local cwd = vim.fn.getcwd()
            return vim.fn.fnamemodify(cwd, ':t')
        end

        -- Get last modified file
        local function get_last_modified()
            local handle = io.popen('ls -t | head -n 1')
            if handle then
                local result = handle:read("*a")
                handle:close()
                return result:gsub("^%s*(.-)%s*$", "%1")
            end
            return ""
        end

        -- Function to get project statistics
        local function get_project_stats()
            local stats = {
                files = "0",
                commits = "0",
                branches = "0",
                contributors = "0",
                last_commit = "No commits"
            }

            -- Check if we're in a git repository
            local is_git = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):find("true")

            if is_git then
                stats.files = vim.fn.system("git ls-files 2>/dev/null | wc -l"):gsub("^%s*(.-)%s*$", "%1")
                stats.commits = vim.fn.system("git rev-list --count HEAD 2>/dev/null"):gsub("^%s*(.-)%s*$", "%1")
                stats.branches = vim.fn.system("git branch --list 2>/dev/null | wc -l"):gsub("^%s*(.-)%s*$", "%1")
                stats.contributors = vim.fn.system("git shortlog -s HEAD | wc -l"):gsub("^%s*(.-)%s*$", "%1")
                stats.last_commit = vim.fn.system("git log -1 --pretty=%s"):gsub("^%s*(.-)%s*$", "%1")
            end

            -- Get total project files (including untracked)
            local total_files = vim.fn.system('find . -type f -not -path "*/\\.*" | wc -l'):gsub("^%s*(.-)%s*$", "%1")

            return {
                "┌ Project Overview ──────────────────────",
                "│",
                "├─ 📂 Project: " .. get_project_name(),
                "├─ 📝 Last Modified: " .. get_last_modified(),
                "├─ ⏰ Current Time: " .. os.date("%H:%M:%S"),
                "├─ 📅 Date: " .. os.date("%A, %d %B %Y"),
                "│",
                "├ Files & Storage ───────────────────────",
                "│",
                "├─ 📁 Total Files: " .. total_files,
                "│",
                "├ Git Statistics ────────────────────────",
                "│",
                "├─ 📊 Repository Stats:",
                "│  ├─ 📂 Tracked Files: " .. stats.files,
                "│  ├─ 🔀 Branches: " .. stats.branches,
                "│  ├─ 📝 Commits: " .. stats.commits,
                "│  ├─ 👥 Contributors: " .. stats.contributors,
                "│  └─ 🔄 Last Commit: " .. stats.last_commit:sub(1, 50) .. (stats.last_commit:len() > 50 and "..." or ""),
                "│",
                "└────────────────────────────────────────"
            }
        end

        -- Random programming tips
        local function get_random_tip()
            local tips = {
                "💡 Press 'gcc' to comment out a line",
                "💡 Use 'zi' to toggle fold",
                "💡 Press 'gd' to go to definition",
                "💡 Use 'K' to show documentation",
                "💡 Press 'gr' to show references",
                "💡 Use 'gc' for line comment",
                "💡 Press 'gf' to go to file under cursor",
            }
            return tips[math.random(1, #tips)]
        end

        local welcomeText = generateText.generateWelcome()

        -- Cool ASCII art header
        dashboard.section.header.val = {
            [[                   ,,,, ]],
            [[             ,;) .';;;;',]],
            [[ ;;,,_,-.-.,;;'_,|I\;;;/),,_]],
            [[  `';;/:|:);{ ;;;|| \;/ /;;;\__]],
            [[      L;/-';/ \;;\',/;\/;;;.') \]],
            [[      .:`''` - \;;'.__/;;;/  . _'-._ ]],
            [[    .'/   \     \;;;;;;/.'_7:.  '). \_]],
            [[  .''/     | '._ );}{;//.'    '-:  '.,L]],
            [[.'. /       \  ( |;;;/_/         \._./;\   _,]],
            [[ . /        |\ ( /;;/_/             ';;;\,;;_,]],
            [[. /         )__(/;;/_/                (;;''''']],
            [[ /        _;:':;;;;:';-._             );]],
            [[/        /   \  `'`   --.'-._         \/]],
            [[       .'     '.  ,'         '-,]],
            [[      /    /   r--,..__       '.\]],
            [[    .'    '  .'        '--._     |]],
            [[    (     :.(;>        _ .' '- ;/]],
            [[    |      /:;(    ,_.';(   __.']],
            [[     '- -'"|;:/    (;;;;-'--']],
            [[           |;/      ;;(]],
            [[           ''      /;;|]],
            [[                   \;;|]],
            [[                    \/]],
        }

        -- dashboard.section.header.val = {
        --     [[          ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ]],
        --     [[           ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
        --     [[                 ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ]],
        --     [[                  ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
        --     [[                 ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
        --     [[          ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
        --     [[         ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
        --     [[        ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
        --     [[        ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ]],
        --     [[             ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
        --     [[              ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
        -- }
        --
        -- Enhanced buttons with icons
        -- dashboard.section.buttons.val = {
        --     dashboard.button('n', '  New File', ':ene <BAR> startinsert <CR>'),
        --     dashboard.button('f', '  Find File', ':Telescope find_files<CR>'),
        --     dashboard.button('g', ' 󰱼 Find Text', ':Telescope live_grep<CR>'),
        --     dashboard.button('e', '  Explorer', ':NvimTreeToggle<CR>'),
        --     dashboard.button('q', '  Quit', ':qa<CR>'),
        -- }

        -- Get all stats and combine sections
        local stats = get_project_stats()
        dashboard.section.footer.val = vim.list_extend({
            welcomeText,
            '',
            get_random_tip(),
            '',
        }, stats)

        -- Layout with proper spacing
        dashboard.config.layout = {
            { type = "padding", val = 2 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            -- dashboard.section.buttons,
            -- { type = "padding", val = 2 },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)

        -- Auto-refresh stats when returning to dashboard
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
                dashboard.section.footer.val = vim.list_extend({
                    welcomeText,
                    '',
                    get_random_tip(),
                    '',
                }, get_project_stats())
                vim.cmd("redraw")
            end,
        })

        -- Refresh time every minute
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaClosed",
            callback = function()
                if _G.alpha_timer then
                    _G.alpha_timer:stop()
                    _G.alpha_timer:close()
                end
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function()
                _G.alpha_timer = vim.loop.new_timer()
                _G.alpha_timer:start(0, 60000, vim.schedule_wrap(function()
                    if vim.bo.filetype == "alpha" then
                        alpha.redraw()
                    end
                end))
            end,
        })
    end,
}
