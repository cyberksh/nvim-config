local config = require('plugins.configs.lspconfig')
local lspconfig = require('lspconfig')
local util = require('lspconfig/util')

local on_attach = config.on_attach 
local capabilities = config.capabilities
local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

lspconfig.pyright.setup({
  before_init = function(_, pyright_config)
    pyright_config.settings.python.pythonPath = get_python_path(pyright_config.root_dir)
  end,
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'python'},
})

lspconfig.perlnavigator.setup({
  cmd = {
    vim.fn.stdpath('data') ..
      "/mason/bin/perlnavigator",
    "--stdio",
  },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    perlnavigator = {
      perlPath = 'perl',
      enableWarnings = true,
      perltidyProfile = "",
      perlcriticProfile = "",
      perlcriticEnabled = true,
    }
  },
  filetypes = {'perl'},
})

lspconfig.rome.setup{}

lspconfig.clangd.setup{}

-- local util = require 'lspconfig/util'

-- lspconfig.rust_analyzer.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {'rust'},
--   root_dir = util.root_pattern('Cargo.toml'),
--   settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         allFeatures = true,
--       }
--     }
--   }
-- })

