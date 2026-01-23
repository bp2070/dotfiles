return {
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        hidden = true,
      },
      picker = {
        hidden = true,
      },
    },
    keys = {
      { "<leader>/", LazyVim.pick("grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    },
  },
}
