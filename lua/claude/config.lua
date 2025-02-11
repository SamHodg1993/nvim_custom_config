local M = {}

-- Default configuration
M.defaults = {
    max_tokens = 500,
    temperature = 0.7
}

-- Function to get API key from environment or local config
function M.get_api_key()
    -- First try environment variable
    local env_key = os.getenv("CLAUDE_API_KEY") -- This is defined in the ~/.bashrc as "export CLAUDE_API_KEY=<api_key_here>"
    if env_key then
        return env_key
    end

    -- Then try local config file
    local config_path = vim.fn.stdpath('config') .. '/claude_local_config.lua' -- I DO NOT recommend this!!!
    local ok, local_config = pcall(dofile, config_path)
    if ok and local_config and local_config.api_key then
        return local_config.api_key
    end

    -- Return nil if no key found
    return nil
end

-- Load and merge configurations
function M.load(user_config)
    -- Start with defaults
    local config = vim.deepcopy(M.defaults)
    
    -- Merge user config
    if user_config then
        config = vim.tbl_deep_extend('force', config, user_config)
    end

    -- Add API key from environment or local config
    config.api_key = M.get_api_key()

    return config
end

return M
