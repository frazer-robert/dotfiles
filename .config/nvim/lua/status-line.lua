local api = vim.api
local S = {}

function S.statusLine()
  local filetype = api.nvim_buf_get_option(0, 'filetype')
  local statusline = ''
  statusline = statusline
  ..'%2n'                                           -- buffer nummber
  ..' %f'                                           -- file path
  ..' %m%h%r%w'                                     -- file flags
  ..'%='                                            -- left-right separator
  ..'%{FugitiveHead()}'                             -- current git branch
  ..' | %{&fileformat}'                                -- file format - unix
  ..' | %{&fileencoding?&fileencoding:&encoding}'   -- file encoding
  if filetype ~= '' then
    statusline = statusline..' | '..filetype        -- file type
  end
  statusline = statusline
  ..'%-6(%3l:%c%)'                                  -- line:column numbers
  ..' '                                             -- extra space at the end
  return statusline
end

return S
