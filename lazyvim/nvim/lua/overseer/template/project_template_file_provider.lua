-- Looks for a `.overseer.lua` file in the searched directory. If found,
-- it should `return` a list of overseer.TemplateDefinition tables, which
-- get exposed here as-is.
---@type overseer.TemplateFileProvider
return {
  generator = function(opts)
    local file = vim.fs.joinpath(opts.dir, ".overseer.lua")
    if vim.fn.filereadable(file) == 0 then
      return {}
    end

    local ok, templates = pcall(dofile, file)
    if not ok or type(templates) ~= "table" then
      vim.notify("Failed to load " .. file, vim.log.levels.WARN)
      return {}
    end

    return templates
  end,
  -- Re-scan only when the file itself changes, otherwise cache the result
  cache_key = function(opts)
    return vim.fs.joinpath(opts.dir, ".overseer.lua")
  end,
}
