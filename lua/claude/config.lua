local M = {}

-- Default configuration
M.defaults = {
    max_tokens = 500,
    temperature = 0.7
}

-- Function to get API key from environment or local config
function M.get_api_key()
    -- Try environment variable
    local env_key = os.getenv("CLAUDE_API_KEY")
    if env_key then
        return env_key
    else
        vim.notify("No API key found in environment variables", vim.log.levels.WARN)
    end

    -- Try local config file
    local config_path = vim.fn.stdpath('config') .. '/claude_local_config.lua'

    local ok, local_config = pcall(dofile, config_path)
    if ok and local_config and local_config.api_key then
        return local_config.api_key
    else
        vim.notify("No API key found in local config", vim.log.levels.WARN)
    end

    return nil
end

-- Load and merge configurations
function M.load(user_config)
    vim.notify("Loading configuration...", vim.log.levels.INFO)
    
    -- Start with defaults
    local config = vim.deepcopy(M.defaults)
    
    -- Merge user config
    if user_config then
        config = vim.tbl_deep_extend('force', config, user_config)
    end

    -- Add API key from environment or local config
    config.api_key = M.get_api_key()
    
    if config.api_key then
    else
        vim.notify("Configuration loaded but no API key found", vim.log.levels.ERROR)
    end

    return config
end

return M
