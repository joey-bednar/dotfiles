-- return top level if within a git directory
-- otherwise return nil
local function gitBase(dir)
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
local function fileExists(filename)
	local file = io.open(filename, "r")
	if file then
		file:close()
		return true
	else
		return false
	end
end

-- return true if makefile is in git repo base
local function hasMakefile(dir)
	return fileExists(dir .. "/makefile") or fileExists(dir .. "/Makefile")
end

-- select best guess for compiled C executable location
local function selectExecutable(dir)
	local paths = { "/build/main", "/build/amelia" }

	for i = 1, 2 do
		if fileExists(dir .. paths[i]) then
			return "." .. paths[i]
		end
	end

	return "./main"
end

-- Create keymap for running make
local function setMakeKeymap(git_dir, run_executable)
	local modes = { "n", "i" }
	for i = 1, 2 do
		vim.api.nvim_buf_set_keymap(
			0,
			modes[i],
			"<F5>",
			"<Esc>:w<CR>:!(cd " .. git_dir .. " && make && " .. run_executable .. ")<CR>",
			{ desc = "Run make and execute in git directory." }
		)
	end
end

-- Create keymap for compiling a single file for C/C++
local function setLocalRunKeymap()
	local compiler = "gcc"
	if is_cpp_file() then
		compiler = "g++"
	end

	local modes = { "n", "i" }
	for i = 1, 2 do
		vim.api.nvim_buf_set_keymap(
			0,
			modes[i],
			"<F5>",
			"<Esc>:w<CR>:!" .. compiler .. " -o %< % && ./%< <CR>",
			{ desc = "Compile and execute." }
		)
	end
end

-- Compile and run C files/projects with F5
--
-- if in git directory with Makefile, make and run executable
-- otherwise, compile current file and run with gcc
function MakeShortcut()
	local git_dir = gitBase(vim.fn.getcwd())
	if git_dir ~= nil then
		if hasMakefile(git_dir) then
			local run_executable = selectExecutable(git_dir)
			setMakeKeymap(git_dir, run_executable)
		end
	else
		setLocalRunKeymap()
	end
end

-- print("===== TESTS =====")
-- print("F",gitBase("~"))
-- print("T",gitBase("~/dotfiles"))
-- print("T",gitBase("~/dotfiles/.config"))
-- print("T",gitBase("~/personal/chess_old"))
-- print("=================")
-- print(hasMakefile(gitBase("~/dotfiles")))
-- print(hasMakefile(gitBase("~/personal/amelia")))
-- print("=================")
