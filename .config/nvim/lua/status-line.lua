local api = vim.api
local S = {}

local context
local notes = io.popen("pwd"):read("*a")

if string.find(notes, "/.notes") then
  context = 'notes | '
end

function S.statusLine()
  local filetype = api.nvim_buf_get_option(0, 'filetype')
  if not context then
    context =
    "%{FugitiveHead()!=''?FugitiveHead().' | ':''}" -- current git branch
  end
  local statusline = ''
  statusline = statusline
  ..'%2n'                                           -- buffer nummber
  ..' %f'                                           -- file path
  ..' %m%h%r%w'                                     -- file flags
  ..'%='                                            -- left-right separator
  ..context
  ..'%{&fileformat}'                                -- file format - unix
  ..' | %{&fileencoding?&fileencoding:&encoding}'   -- file encoding
  if filetype ~= '' then
    statusline = statusline..' | '..filetype        -- file type
  end
  statusline = statusline
  ..' %-7(%4l:%-2c%)'                               -- line:column numbers
  ..' '                                             -- extra space at the end
  return statusline
end

return S
