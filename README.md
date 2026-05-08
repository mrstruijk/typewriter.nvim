# typewriter.nvim

> Center the cursor vertically like a typewriter

The `position` is a number between `0` and `1`:

- `0.05` near top
- `0.25` high up
- `0.50` centered
- `0.75` very low

If `immediate` is false, it waits until the first keystroke to recenter cursor position.

```lua
return {
  url="mrstruijk/typewriter.nvim",

  cmd = { "TypeWriter" },

  opts = {
    position = 0.06,
    immediate = true,
  },

  keys = {
    {
      "<leader>zz",
      "<cmd>TypeWriter<CR>",
      desc = "Toggle Typewriter",
    },
  },
}
```
