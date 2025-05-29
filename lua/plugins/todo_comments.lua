local cryo_matte_cyan = "#0eb8be"
local cryo_pastel_pink = "#e87ddd"
local cryo_green = "#65ea70"
local cryo_red = "#cc44aa"

return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        keyword = "fg",
        after = "fg",
      },
      keywords = {
        IDEA = { icon = "⏲ ", color = "test", alt = { "THOUGHT", "MUSE" } },
        DESC = { icon = " ", color = cryo_matte_cyan, alt = { "DESCRIPTION" } },
        IMPROVEMENT = { icon = " ", color = cryo_pastel_pink, alt = { "IMPROV" } },
        SECTION = { icon = " ", color = cryo_green, alt = { "SECTION" } },
        EXAMPLE = { icon = " ", color = cryo_red, alt = { "EXAMPLE" } },
        REGION = { icon = " ", color = cryo_green, alt = { "REGION", "END REGION" } },
      },
    },
  },
}
