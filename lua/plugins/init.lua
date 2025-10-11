local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local plugins = {}

for _, file in ipairs(vim.fn.readdir(plugin_dir)) do
  if file:match("%.lua$") and file ~= "init.lua" then
    local name = file:gsub("%.lua$", "")
    local ok, plugin = pcall(require, "plugins." .. name)
    if ok then
      table.insert(plugins, plugin)
    else
      vim.notify("Failed to load plugin: " .. name, vim.log.levels.ERROR)
    end
  end
end

return plugins
