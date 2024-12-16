local ts_group = vim.api.nvim_create_augroup('Vue Autotemplates', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*.vue',
  group = ts_group,
  callback = function (params)
    require('config.commands.tpl').insert_template({
      '<template>',
      '  <div>',
      '  </div>',
      '</template>',
      '',
      '<script setup lang="ts">',
      '',
      '</script>',
      '',
      '<style>',
      '',
      '</style>',
    })
    vim.api.nvim_win_set_cursor(0, { 7, 1 })
  end,
})