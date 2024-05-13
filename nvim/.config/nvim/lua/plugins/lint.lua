return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "--disable", "MD032", "--disable", "MD033", "--" },
        },
      },
    },
  },
}
