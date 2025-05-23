local orig_notify = vim.notify
vim.notify = function(text, level, opts)
  if type(text) == "string" and string.find(text, "See :h deprecated", 1, true) then
    return
  end
  orig_notify(text, level, opts)
end

