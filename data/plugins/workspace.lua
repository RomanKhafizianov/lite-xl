local core = require "core"
local common = require "core.common"
local DocView = require "core.docview"

local workspace_filename = ".lite_workspace.lua"


local function has_no_locked_children(node)
  if node.locked then return false end
  if node.type == "leaf" then return true end
  return has_no_locked_children(node.a) and has_no_locked_children(node.b)
end


local function get_unlocked_root(node)
  if node.type == "leaf" then
    return not node.locked and node
  end
  if has_no_locked_children(node) then
    return node
  end
  return get_unlocked_root(node.a) or get_unlocked_root(node.b)
end


local function save_view(view)
  local mt = getmetatable(view)
  if mt == DocView then
    return {
      type = "doc",
      active = (core.active_view == view),
      filename = view.doc.filename,
      selection = { view.doc:get_selection() },
      scroll = { x = view.scroll.to.x, y = view.scroll.to.y },
      text = not view.doc.filename and view.doc:get_text(1, 1, math.huge, math.huge)
    }
  end
  for name, mod in pairs(package.loaded) do
    if mod == mt then
      return {
        type = "view",
        active = (core.active_view == view),
        module = name
      }
    end
  end
end


local function load_view(t)
  if t.type == "doc" then
    local ok, doc = pcall(core.open_doc, t.filename)
    if not ok then
      return DocView(core.open_doc())
    end
    local dv = DocView(doc)
    if t.text then doc:insert(1, 1, t.text) end
    doc:set_selection(table.unpack(t.selection))
    dv.last_line, dv.last_col = doc:get_selection()
    dv.scroll.x, dv.scroll.to.x = t.scroll.x, t.scroll.x
    dv.scroll.y, dv.scroll.to.y = t.scroll.y, t.scroll.y
    return dv
  end
  return require(t.module)()
end


local function save_node(node)
  local res = {}
  res.type = node.type
  if node.type == "leaf" then
    res.views = {}
    for _, view in ipairs(node.views) do
      local t = save_view(view)
      if t then
        table.insert(res.views, t)
        if node.active_view == view then
          res.active_view = #res.views
        end
      end
    end
  else
    res.divider = node.divider
    res.a = save_node(node.a)
    res.b = save_node(node.b)
  end
  return res
end


local function load_node(node, t)
  if t.type == "leaf" then
    local res
    for _, v in ipairs(t.views) do
      local view = load_view(v)
      if v.active then res = view end
      node:add_view(view)
    end
    if t.active_view then
      node:set_active_view(node.views[t.active_view])
    end
    return res
  else
    node:split(t.type == "hsplit" and "right" or "down")
    node.divider = t.divider
    local res1 = load_node(node.a, t.a)
    local res2 = load_node(node.b, t.b)
    return res1 or res2
  end
end


local function split_on_slash(s, sep_pattern)
  local t = {}
  for fragment in string.gmatch(s, "([^/\\]+)") do
    t[#t + 1] = fragment
  end
  return t
end


local function relative_path(ref_dir, dir)
  local ref_ls = split_on_slash(ref_dir)
  local dir_ls = split_on_slash(dir)
  local i = 1
  while i <= #ref_ls do
    if dir_ls[i] ~= ref_ls[i] then
      break
    end
    i = i + 1
  end
  local ups = ""
  for k = i, #ref_ls do
    ups = ups .. "../"
  end
  return ups .. table.concat(dir_ls, "/", i)
end


local function save_directories()
  local project_dir = core.project_dir
  local dir_list = {}
  for i, dir in ipairs(core.project_directories) do
    dir_list[i] = relative_path(project_dir, dir.name)
  end
  return dir_list
end


local function save_workspace()
  local root = get_unlocked_root(core.root_view.root_node)
  local fp = io.open(workspace_filename, "w")
  if fp then
    local node_text = common.serialize(save_node(root))
    local dir_text = common.serialize(save_directories())
    fp:write(string.format("return { documents = %s, directories = %s }\n", node_text, dir_text))
    fp:close()
  end
end


local function load_workspace()
  local ok, t = pcall(dofile, workspace_filename)
  os.remove(workspace_filename)
  if ok then
    local root = get_unlocked_root(core.root_view.root_node)
    local active_view = load_node(root, t.documents)
    if active_view then
      core.set_active_view(active_view)
    end
    for i, dir_name in ipairs(t.directories) do
      if dir_name ~= "" then
        core.add_project_directory(system.absolute_path(dir_name))
      end
    end
  end
end


local run = core.run

function core.run(...)
  if #core.docs == 0 then
    core.try(load_workspace)

    local original_on_quit = core.on_quit
    function core.on_quit()
      save_workspace()
      original_on_quit()
    end
  end

  core.run = run
  return core.run(...)
end