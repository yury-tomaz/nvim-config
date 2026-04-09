return {
  "bnse/plantuml.nvim",
  ft = "plantuml",
  config = function()
    require("plantuml").setup({
      renderer = {
        type = "text",
        options = {
          split_cmd = "vsplit", -- split ou vsplit
        },
      },
      render_on_write = true, -- Atualiza ao salvar (Ctrl+S / :w)
    })

    -- Atalho para abrir/atualizar preview em buffers PlantUML
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "plantuml",
      callback = function()
        vim.keymap.set("n", "<leader>pv", ":PlantUML<CR>", { buffer = true, desc = "PlantUML preview" })
      end,
    })
  end,
}
