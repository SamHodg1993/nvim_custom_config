local M = {}
local api = vim.api
local curl = require('plenary.curl')
local config = require('claude.config')

function M.setup(opts)
    -- Load configuration
    M.config = config.load(opts)
    
    -- Ensure API key is available
    if not M.config.api_key then
        vim.notify(
            "Claude API key not found. Please set CLAUDE_API_KEY environment variable or create claude_local_config.lua",
            vim.log.levels.ERROR
        )
        return
    end
end

-- Get current buffer context
local function get_context()
    local cursor = api.nvim_win_get_cursor(0)
    local line = cursor[1]
    local lines = api.nvim_buf_get_lines(0, math.max(0, line - 10), line, false)
    return table.concat(lines, '\n')
end

-- Function to make API request to Claude
local function request_completion(prompt)
    local response = curl.post('https://api.anthropic.com/v1/messages', {
        headers = {
            ['x-api-key'] = M.config.api_key,
            ['anthropic-version'] = '2023-06-01',
            ['content-type'] = 'application/json',
        },
        body = vim.fn.json_encode({
            model = 'claude-3-opus-20240229',
            max_tokens = M.config.max_tokens,
            temperature = M.config.temperature,
            messages = {
                {
                    role = 'user',
                    content = prompt
                }
            }
        })
    })
    
    if response.status ~= 200 then
        error('Claude API request failed: ' .. vim.inspect(response))
    end
    
    local result = vim.fn.json_decode(response.body)
    return result.content[1].text
end

-- Get completion at current cursor position
function M.complete()
    local context = get_context()
    local prompt = string.format([[
        Based on this code context, provide a completion for the next line:
        %s
        
        Complete the code in a concise way, providing only the code completion without any explanation.
    ]], context)
    
    local completion = request_completion(prompt)
    
    -- Insert completion at cursor
    local line = api.nvim_win_get_cursor(0)[1]
    api.nvim_buf_set_lines(0, line, line, false, {completion})
end

-- Setup keymaps
function M.setup_keymaps()
    -- Map <Leader>cc to trigger completion
    vim.keymap.set('n', '<Leader>cc', M.complete, {
        noremap = true,
        silent = true,
        desc = 'Get Claude completion'
    })
end

return M
