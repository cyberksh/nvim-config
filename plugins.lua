local plugins = {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        -- ts/js dependencies
        'rome',
        'eslint_d',
        'prettier',

        -- rust dependencies
        'rust-analyzer',

        -- python dependencies
        'pyright',
        'isort',
        'mypy',
        'ruff',
        'black',
        'debugpy',
        'perlnavigator',

        -- c dependencies
        'clangd',
        'clang-format'
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function ()
      require 'plugins.configs.lspconfig'
      require 'custom.configs.lspconfig'
    end
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end
  },
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    init = function ()
      -- set rust autoformat on save
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    -- more intelligent rust lsp with other tools
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    dependencies = 'neovim/nvim-lspconfig',
    opts = function ()
      return require 'custom.configs.rust-tools'
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    -- rust debugging
    'mfussenegger/nvim-dap',
    config = function(_, opts)
      require('core.utils').load_mappings('dap')
    end
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function(_, opts)
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Python: Current File',
        program = '${file}',
        console = 'integratedTerminal',
        justMyCode = true
      })
      require('core.utils').load_mappings('dap_python')
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    ft = {'python'},
    opts = function()
      return require 'custom.configs.null-ls'
    end,
  },
  {
    'rmagatti/auto-session',
    cmd = { 'SessionSave', 'SessionRestore', 'SessionDelete' },
    config = function()
      require('auto-session').setup {
        log_level = 'error', 
        auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
        auto_session_allowed_dirs = {'~/projects', '~/.config/nvim', '~/obsidian'},
      }
    end,
  },
  {
    'lukas-reineke/virt-column.nvim',
    lazy = false,
    config = function()
      require('virt-column').setup {
        virtcolumn = "80,100" 
      }
    end
  }
  -- {
  --   'saecki/crates.nvim',
  --   ft = {'rust', 'toml'},
  --   config = function (_, opts)
  --     local crates = require('crates')
  --     crates.setup(opts)
  --
  --     -- set due to errors loading crates
  --     crates.show()
  --   end
  -- },
  -- {
  --   -- show more details related to crates in cargo.toml
  --   'hrsh7th/nvim-cmp',
  --   opts = function ()
  --     local M = require 'plugins.configs.cmp'
  --     table.insert(M.sources, {name = 'crates'})
  --     return M
  --   end
  -- }
}

return plugins
