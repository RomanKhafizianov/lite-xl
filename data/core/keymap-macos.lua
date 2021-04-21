local function keymap_macos(keymap)
  keymap.add_direct {
    ["cmd+shift+p"] = "core:find-command",
    ["cmd+p"] = "core:find-file",
    ["cmd+o"] = "core:open-file",
    ["cmd+n"] = "core:new-doc",
    ["cmd+shift+c"] = "core:change-project-folder",
    ["cmd+shift+o"] = "core:open-project-folder",
    ["alt+return"] = "core:toggle-fullscreen",

    ["alt+shift+j"] = "root:split-left",
    ["alt+shift+l"] = "root:split-right",
    ["alt+shift+i"] = "root:split-up",
    ["alt+shift+k"] = "root:split-down",
    ["alt+j"] = "root:switch-to-left",
    ["alt+l"] = "root:switch-to-right",
    ["alt+i"] = "root:switch-to-up",
    ["alt+k"] = "root:switch-to-down",

    ["ctrl+w"] = "root:close",
    ["cmd+tab"] = "root:switch-to-next-tab",
    ["cmd+shift+tab"] = "root:switch-to-previous-tab",
    ["cmd+pageup"] = "root:move-tab-left",
    ["cmd+pagedown"] = "root:move-tab-right",
    ["alt+1"] = "root:switch-to-tab-1",
    ["alt+2"] = "root:switch-to-tab-2",
    ["alt+3"] = "root:switch-to-tab-3",
    ["alt+4"] = "root:switch-to-tab-4",
    ["alt+5"] = "root:switch-to-tab-5",
    ["alt+6"] = "root:switch-to-tab-6",
    ["alt+7"] = "root:switch-to-tab-7",
    ["alt+8"] = "root:switch-to-tab-8",
    ["alt+9"] = "root:switch-to-tab-9",

    ["cmd+f"] = "find-replace:find",
    ["cmd+r"] = "find-replace:replace",
    ["f3"] = "find-replace:repeat-find",
    ["shift+f3"] = "find-replace:previous-find",
    ["cmd+g"] = "doc:go-to-line",
    ["cmd+s"] = "doc:save",
    ["cmd+shift+s"] = "doc:save-as",

    ["cmd+z"] = "doc:undo",
    ["cmd+y"] = "doc:redo",
    ["cmd+x"] = "doc:cut",
    ["cmd+c"] = "doc:copy",
    ["cmd+v"] = "doc:paste",
    ["ctrl+insert"] = "doc:copy",
    ["shift+insert"] = "doc:paste",
    ["escape"] = { "command:escape", "doc:select-none", "dialog:select-no" },
    ["tab"] = { "command:complete", "doc:indent" },
    ["shift+tab"] = "doc:unindent",
    ["backspace"] = "doc:backspace",
    ["shift+backspace"] = "doc:backspace",
    ["cmd+backspace"] = "doc:delete-to-previous-word-start",
    ["cmd+shift+backspace"] = "doc:delete-to-previous-word-start",
    ["delete"] = "doc:delete",
    ["shift+delete"] = "doc:delete",
    ["cmd+delete"] = "doc:delete-to-next-word-end",
    ["cmd+shift+delete"] = "doc:delete-to-next-word-end",
    ["return"] = { "command:submit", "doc:newline", "dialog:select" },
    ["keypad enter"] = { "command:submit", "doc:newline", "dialog:select" },
    ["cmd+return"] = "doc:newline-below",
    ["cmd+shift+return"] = "doc:newline-above",
    ["cmd+j"] = "doc:join-lines",
    ["cmd+a"] = "doc:select-all",
    ["cmd+d"] = { "find-replace:select-next", "doc:select-word" },
    ["cmd+l"] = "doc:select-lines",
    ["cmd+/"] = "doc:toggle-line-comments",
    ["cmd+up"] = "doc:move-lines-up",
    ["cmd+down"] = "doc:move-lines-down",
    ["cmd+shift+d"] = "doc:duplicate-lines",
    ["cmd+shift+k"] = "doc:delete-lines",

    ["left"] = { "doc:move-to-previous-char", "dialog:previous-entry" },
    ["right"] = { "doc:move-to-next-char", "dialog:next-entry"},
    ["up"] = { "command:select-previous", "doc:move-to-previous-line" },
    ["down"] = { "command:select-next", "doc:move-to-next-line" },
    ["cmd+left"] = "doc:move-to-previous-word-start",
    ["cmd+right"] = "doc:move-to-next-word-end",
    ["cmd+["] = "doc:move-to-previous-block-start",
    ["cmd+]"] = "doc:move-to-next-block-end",
    ["home"] = "doc:move-to-start-of-line",
    ["end"] = "doc:move-to-end-of-line",
    ["cmd+home"] = "doc:move-to-start-of-doc",
    ["cmd+end"] = "doc:move-to-end-of-doc",
    ["pageup"] = "doc:move-to-previous-page",
    ["pagedown"] = "doc:move-to-next-page",

    ["shift+left"] = "doc:select-to-previous-char",
    ["shift+right"] = "doc:select-to-next-char",
    ["shift+up"] = "doc:select-to-previous-line",
    ["shift+down"] = "doc:select-to-next-line",
    ["cmd+shift+left"] = "doc:select-to-previous-word-start",
    ["cmd+shift+right"] = "doc:select-to-next-word-end",
    ["cmd+shift+["] = "doc:select-to-previous-block-start",
    ["cmd+shift+]"] = "doc:select-to-next-block-end",
    ["shift+home"] = "doc:select-to-start-of-line",
    ["shift+end"] = "doc:select-to-end-of-line",
    ["cmd+shift+home"] = "doc:select-to-start-of-doc",
    ["cmd+shift+end"] = "doc:select-to-end-of-doc",
    ["shift+pageup"] = "doc:select-to-previous-page",
    ["shift+pagedown"] = "doc:select-to-next-page",
  }
end

return keymap_macos
