-- return top level if within a git directory
-- otherwise return nil
local function git_base_dir(dir)
	local handle = io.popen("cd " .. dir .. " && git rev-parse --show-toplevel 2>/dev/null")
	local result = handle:read("*a")
	handle:close()

	if result:match("/") ~= nil then
		return result:gsub("\n", "")
	else
		return nil
	end
end

-- returns true if current file is a cpp file
local function is_cpp_file()
	local filetype = vim.bo.filetype
	return filetype == "cpp" or filetype == "c++"
end

-- return true if file exists
local function file_exists(filename)
	local file = io.open(filename, "r")
	if file then
		file:close()
		return true
	else
		return false
	end
end

-- return true if makefile is in git repo base
local function repo_has_makefile(dir)
	return file_exists(dir .. "/makefile") or file_exists(dir .. "/Makefile")
end

-- select best guess for compiled C executable location
local function selectExecutable(dir)
	local paths = { "/build/main", "/build/amelia" }

	for i = 1, 2 do
		if file_exists(dir .. paths[i]) then
			return "." .. paths[i]
		end
	end

	return "./main"
end

-- Create keymap for running make
local function set_make_keymap(git_dir, run_executable)
	local modes = { "n", "i" }
	for i = 1, 2 do
		vim.api.nvim_buf_set_keymap(
			0,
			modes[i],
			"<F7>",
			"<Esc>:w<CR>:!(cd " .. git_dir .. " && make && " .. run_executable .. ")<CR>",
			{ desc = "Run make and execute in git directory." }
		)
	end
end

-- Create keymap for compiling a single file for C/C++
local function set_local_run_keymap()
	local compiler = "gcc"
	if is_cpp_file() then
		compiler = "g++"
	end

	local modes = { "n", "i" }
	for i = 1, 2 do
		vim.api.nvim_buf_set_keymap(
			0,
			modes[i],
			"<F7>",
			"<Esc>:w<CR>:!" .. compiler .. " -o %< % && ./%< <CR>",
			{ desc = "Compile and execute." }
		)
	end
end

-- Compile and run C files/projects with F7
--
-- if in git directory with Makefile, make and run executable
-- otherwise, compile current file and run with gcc
function Create_keymap()
	local git_dir = git_base_dir(vim.fn.getcwd())
	if git_dir ~= nil and repo_has_makefile(git_dir) then
		local run_executable = selectExecutable(git_dir)
		set_make_keymap(git_dir, run_executable)
	else
		set_local_run_keymap()
	end
end
