local M = {}

M.disabled = {
  n = {
    ['<leader>b'] = ""
  }
}

M.general = {
  -- normal mode mappings
  n = {
    ['<leader>bc'] = {
      '<cmd> enew <CR>',
      'Buffer create'
    },
    ['<leader>bn'] = {
      '<cmd> bn <CR>',
      'Next buffer'
    },
    ['<leader>bp'] = {
      '<cmd> bp <CR>',
      'Previous buffer'
    },
    ['<leader>tc'] = {
      '<cmd> tabnew <CR>',
      'Tab create'
    },
    ['<leader>tn'] = {
      '<cmd> tabn <CR>',
      'Next tab'
    },
    ['leader>tp'] = {
      '<cmd> tabp <CR>',
      'Previous tab'
    },
    ['J'] = {
      '5j',
      'Move vertically faster'
    },
    ['K'] = {
      '5k',
      'Move vertically faster'
    },
    ['<leader>j'] = {
      'J',
      -- makes it harder to type join lines
      'Join lines'
    },
    ['<leader>ww'] = {
      -- workspace writes
      -- cant use ss because s is used to change current character
      '<cmd> SessionSave <CR>',
      'Save workspace session'
    },
    ['<leader>wr'] = {
      '<cmd> SessionRestore <CR>',
      'Restore workspace session'
    },
    ['<leader>wd'] = {
      '<cmd> SessionDelete <CR>',
      'Delete workspace session'
    },
    ['gh'] = {
      function ()
        require('lsp_signature').toggle_float_win()
      end,
      'Show function signature',
      opts = { silent=true, noremap=true}
    }
  },

  -- insert mode mappings
  i = {
    ['jk'] = {
      '<Esc>',
      'Escape insert mode'
    }
  }
}

M.dap = {
  plugin = true,
  n = {
    ['<leader>db'] = {
      '<cmd> DapToggleBreakpoint <CR>',
      'Toggle breakpoint',
    },
    ['<leader>dr'] = {
      function()
        require('dap').continue()
      end
    },
    ['<leader>dus'] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      'Open debugging sidebar'
    },
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ['<leader>dpr'] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

return M
