-- lua/typewriter/init.lua
-- Keeps the cursor at set vertical location in buffer.
-- Toggle via `TypeWriter` command

local M = {}

M.enabled = false
M.augroup = vim.api.nvim_create_augroup("TypewriterScroll", { clear = true })

M.opts = {
	position = 0.05,
	immediate = true, -- if false then it will wait until the first keystroke
	notify = false, -- show debug notifications
}

-- scroll to a particular position on screen
local function scroll(position)
	local win_height = vim.fn.winheight(0)
	local target = math.floor(win_height * position)

	local line = vim.fn.line(".")
	local top = math.max(line - target, 1)

	vim.fn.winrestview({
		topline = top,
	})
end

function M.enable()
	if M.enabled then
		return
	end
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = M.augroup,
		callback = function()
			scroll(M.opts.position)
		end,
	})

	if M.opts.immediate then
		scroll(M.opts.position)
	end

	M.enabled = true

	if M.opts.notify then
		vim.notify("Typewriter mode " .. tostring(M.enabled))
	end
end

function M.disable()
	if M.disabled then
		return
	end
	vim.api.nvim_clear_autocmds({
		group = M.augroup,
	})

	M.enabled = false

	if M.opts.notify then
		vim.notify("Typewriter mode " .. tostring(M.enabled))
	end
end

function M.toggle()
	if M.enabled then
		M.disable()
	else
		M.enable()
	end
end

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

	vim.api.nvim_create_user_command("TypeWriter", function()
		M.toggle()
	end, {})
end

return M
