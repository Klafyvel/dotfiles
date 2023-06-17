return {
  {
    'stevearc/vim-arduino',
    dependencies = 'jpalardy/vim-slime-ext-plugins',
    -- ft = {'arduino'},
    config = function()
      vim.g.arduino_use_cli = 1
      vim.g.arduino_serial_cmd = "wezterm serial --baud {baud} {port}"
      vim.g.arduino_auto_baud = 1
      vim.g.slime_bracketed_paste = 0
      vim.cmd([[
      nnoremap <buffer> <leader>am <cmd>ArduinoVerify<CR>
      nnoremap <buffer> <leader>au <cmd>ArduinoUpload<CR>
      nnoremap <buffer> <leader>ad <cmd>ArduinoUploadAndSerial<CR>
      nnoremap <buffer> <leader>ab <cmd>ArduinoChooseBoard<CR>
      nnoremap <buffer> <leader>ap <cmd>ArduinoChooseProgrammer<CR>
      ]])
    end
  }
}
