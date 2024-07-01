-- Treesitter query for grabbing the repo name
-- (return_statement
--   (expression_list
--     (table_constructor
--       (field
--         !name
--         value: (string 
--                  content: (string_content) @repo-name)
--         ) @repo-index
--       ) @table
--     ) @expression
--   ) @return


return {
  "nvim-treesitter/playground",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup({
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    })
  end,
}
