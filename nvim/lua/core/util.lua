local M = {}

-- Global on_attach
M.on_attach = function(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Keybindings untuk vtsls
  if client.name == "vtsls" then
    map("n", "gD", function()
      local params = vim.lsp.util.make_position_params()
      vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
        command = "typescript.goToSourceDefinition",
        arguments = { params.textDocument.uri, params.position },
      }, function(_, result)
        if result and result[1] then
          vim.lsp.util.jump_to_location(result[1], "utf-8")
        end
      end)
    end, "Goto Source Definition")

    map("n", "gR", function()
      vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
        command = "typescript.findAllFileReferences",
        arguments = { vim.uri_from_bufnr(0) },
      }, function(_, result)
        if result then
          vim.lsp.handlers["textDocument/references"](nil, result, { bufnr = bufnr })
        end
      end)
    end, "File References")

    map("n", "<leader>co", vim.lsp.buf.code_action, "Organize Imports")
    map("n", "<leader>cM", vim.lsp.buf.code_action, "Add missing imports")
    map("n", "<leader>cu", vim.lsp.buf.code_action, "Remove unused imports")
    map("n", "<leader>cD", vim.lsp.buf.code_action, "Fix all diagnostics")
    map("n", "<leader>cV", function()
      vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
        command = "typescript.selectTypeScriptVersion",
      })
    end, "Select TS workspace version")

    client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
      local action, uri, range = unpack(command.arguments)
      local function move(newf)
        client.request("workspace/executeCommand", {
          command = command.command,
          arguments = { action, uri, range, newf },
        })
      end
      local fname = vim.uri_to_fname(uri)
      client.request("workspace/executeCommand", {
        command = "typescript.tsserverRequest",
        arguments = {
          "getMoveToRefactoringFileSuggestions",
          {
            file = fname,
            startLine = range.start.line + 1,
            startOffset = range.start.character + 1,
            endLine = range["end"].line + 1,
            endOffset = range["end"].character + 1,
          },
        },
      }, function(_, result)
        local files = result.body.files
        table.insert(files, 1, "Enter new path...")
        vim.ui.select(files, {
          prompt = "Select move destination:",
          format_item = function(f)
            return vim.fn.fnamemodify(f, ":~:.")
          end,
        }, function(f)
          if f and f:find("^Enter new path") then
            vim.ui.input({
              prompt = "Enter move destination:",
              default = vim.fn.fnamemodify(fname, ":h") .. "/",
              completion = "file",
            }, function(newf)
              return newf and move(newf)
            end)
          elseif f then
            move(f)
          end
        end)
      end)
    end
  end

  print(client.name .. " attached to buffer " .. bufnr)
end

return M
