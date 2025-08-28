local dap = require("dap")
dap.adapters.python = {
	type = "executable";
	command = "/bin/python3";
	args = { "-m", "debugpy.adapter" };
}
