return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>/", LazyVim.pick("grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    },
  },
}
