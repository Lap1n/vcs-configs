return {
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    cmd = "HopWord",
    opts = {},
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-path",
      {
        "zbirenbaum/copilot-cmp",
        dependencies = {
          "zbirenbaum/copilot.lua",
          opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
          },
          config = function()
            vim.defer_fn(function()
              require("copilot").setup()
            end, 100)
          end,
        },
      },
    },
    -- opts = function(_, opts)
    --   local has_words_before = function()
    --     unpack = unpack or table.unpack
    --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    --   end
    --
    --   local luasnip = require("luasnip")
    --   local cmp = require("cmp")
    --
    --   opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" }, { name = "copilot" } }))
    --
    --   opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --     ["<Tab>"] = cmp.mapping(function(fallback)
    --       if cmp.visible() then
    --         cmp.select_next_item()
    --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --         -- they way you will only jump inside the snippet region
    --       elseif luasnip.expand_or_jumpable() then
    --         luasnip.expand_or_jump()
    --       elseif has_words_before() then
    --         cmp.complete()
    --       else
    --         fallback()
    --       end
    --     end, { "i", "s" }),
    --     ["<S-Tab>"] = cmp.mapping(function(fallback)
    --       if cmp.visible() then
    --         cmp.select_prev_item()
    --       elseif luasnip.jumpable(-1) then
    --         luasnip.jump(-1)
    --       else
    --         fallback()
    --       end
    --     end, { "i", "s" }),
    --   })
    -- end,

    -- ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- local has_words_before = function()
      --   unpack = unpack or table.unpack
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local select_opts = { behavior = cmp.SelectBehavior.Select }
      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      opts.sources =
        cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" }, { name = "copilot", group_index = 2 } }))

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        -- ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
        -- ["<Down>"] = cmp.mapping.select_next_item(select_opts),
        --
        ["<C-k>"] = cmp.mapping.select_prev_item(select_opts),
        ["<C-j>"] = cmp.mapping.select_next_item(select_opts),
        ["<C-Space>"] = cmp.mapping.complete({}),
        -- ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
        -- ["<C-n>"] = cmp.mapping.select_next_item(select_opts),
        --
        -- ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --
        -- ["<C-e>"] = cmp.mapping.abort(),
        -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
        --
        -- ["<C-d>"] = cmp.mapping(function(fallback)
        --   if luasnip.jumpable(1) then
        --     luasnip.jump(1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        --
        -- ["<C-b>"] = cmp.mapping(function(fallback)
        --   if luasnip.jumpable(-1) then
        --     luasnip.jump(-1)
        --   else
        --     fallback()
        --   end
        -- end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
-- 2+ 2
