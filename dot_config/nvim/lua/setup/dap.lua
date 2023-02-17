local fn = vim.fn

require('dap').set_log_level('TRACE');

require('dap').adapters.chrome = {
  type = "executable",
  command = "node",
  args = { fn.stdpath "data" .. '/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js' };
}

require('dap').configurations.javascript = {
  {
    type = 'node2';
    request = 'launch';
    program = '${file}';
    cwd = fn.getcwd();
    sourceMaps = true;
    protocol = 'inspector';
    console = 'integratedTerminal';
  }
}

require('dap').configurations.javascript = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}'
  }
}

require('dap').configurations.typescript = {
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}"
  }
}

require('dap').configurations.javascriptreact = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}'
  }
}

require('dap').configurations.typescriptreact = {
  {
    type = 'chrome',
    request = 'attach',
    program = '${file}',
    cwd = fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    port = 9222,
    webRoot = '${workspaceFolder}'
  }
}
