-- lua/typewriter/init.lua

local M = {}

M.enabled = false
M.augroup = vim.api.nvim_create_augroup("TypewriterScroll", { clear = true })

M.opts = {
	position = 0.25,
}

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
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = M.augroup,
		callback = function()
			scroll(M.opts.position)
		end,
	})

	scroll(M.opts.position)
	M.enabled = true
end

function M.disable()
	vim.api.nvim_clear_autocmds({
		group = M.augroup,
	})

	M.enabled = false
end

function M.toggle()
	if M.enabled then
		M.disable()
		vim.notify("Typewriter OFF")
	else
		M.enable()
		vim.notify("Typewriter ON")
	end
end

function M.setup(opts)
	M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})

	vim.api.nvim_create_user_command("TypeWriter", function()
		M.toggle()
	end, {})
end

return M
