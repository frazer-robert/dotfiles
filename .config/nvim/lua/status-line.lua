local api = vim.api
local S = {}

local context
local notes = io.popen("pwd"):read("*a")

if string.find(notes, "/notes") then
  context = 'notes | '
else
  context = ''
end

function S.statusLine()
  local filetype = api.nvim_buf_get_option(0, 'filetype')
  local statusline = ''

  statusline = statusline
  ..'%2n'                                             -- buffer nummber
  ..' %f'                                             -- file path
  ..' %m%h%r%w'                                       -- file flags
  ..'%='                                              -- left-right separator

  ..context                                           -- context e.g, notes
  .."%{FugitiveHead()!=''?FugitiveHead().' | ':''}"   -- current git branch
  ..'%{&fileformat}'                                  -- file format - unix
  ..' | %{&fileencoding?&fileencoding:&encoding}'     -- file encoding
  if filetype ~= '' then
    statusline = statusline..' | '..filetype          -- file type
  end
  statusline = statusline
  ..' '
  ..' %-7(%4l:%-2c%)'                                 -- line:column numbers
  ..' '                                               -- extra space at the end
  return statusline
end

return S

-- references
-- ..'%#LineInfo#'                                     -- start color
-- ..'%*'                                              -- end end
-- .." %{FugitiveHead()!=''?FugitiveHead():'LOCAL'} "  -- current git branch or LOCAL
