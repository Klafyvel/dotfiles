return {
  {
    'JuliaEditorSupport/julia-vim',
    -- ft = {'julia'},
    setup = function()
      vim.g.latex_to_unicode_tab = 0
      vim.g.latex_to_unicode_keymap = 1
      vim.g.julia_blocks = 0
    end
  }
}
