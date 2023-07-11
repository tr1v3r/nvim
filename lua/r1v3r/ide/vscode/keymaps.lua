local map = require("helper.mapping").map

function setKeys()
    vim.cmd[[nunmap <up>]]
    vim.cmd[[nunmap <down>]]
    vim.cmd[[nunmap <left>]]
    vim.cmd[[nunmap <right>]]

    -- Split the screens to up/down/left/right
    map("su", "workbench.action.splitEditorUp"):mode("n"):vscNotify():noremap():silent():desc("editor: split up"):set()
    map("se", "workbench.action.splitEditorDown"):mode("n"):vscNotify():noremap():silent():desc("editor: split down"):set()
    map("sn", "workbench.action.splitEditorLeft"):mode("n"):vscNotify():noremap():silent():desc("editor: split left"):set()
    map("si", "workbench.action.splitEditorRight"):mode("n"):vscNotify():noremap():silent():desc("editor: split right"):set()
    
    -- editor operator
    map("tu", "workbench.action.files.newUntitledFile"):mode("n"):vscNotify():noremap():silent():desc("editor: create new editor"):set() -- workbench.action.newWindowTab
    map("tw", "workbench.action.closeActiveEditor"):mode("n"):vscNotify():noremap():silent():desc("editor: close active editor"):set()
    map("to", "workbench.action.closeOtherEditors"):mode("n"):vscNotify():noremap():silent():desc("editor: close other editors"):set()
    map("tq", "workbench.action.closeEditorsInOtherGroups"):mode("n"):vscNotify():noremap():silent():desc("editor: close other editors groups"):set()

    -- move tabs
    map("tn", "workbench.action.previousEditor"):mode("n"):vscNotify():noremap():silent():desc("editor: move to previous editor"):set()
    map("ti", "workbench.action.nextEditor"):mode("n"):vscNotify():noremap():silent():desc("editor: move to next editor"):set()
    map("tN", "workbench.action.moveEditorLeftInGroup"):mode("n"):vscNotify():noremap():silent():desc("editor: move editor to left"):set()
    map("tI", "workbench.action.moveEditorRightInGroup"):mode("n"):vscNotify():noremap():silent():desc("editor: move editor to right"):set()

    -- editor switch
    map("<LEADER>1", "workbench.action.openEditorAtIndex1"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 1"):set()
    map("<LEADER>2", "workbench.action.openEditorAtIndex2"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 2"):set()
    map("<LEADER>3", "workbench.action.openEditorAtIndex3"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 3"):set()
    map("<LEADER>4", "workbench.action.openEditorAtIndex4"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 4"):set()
    map("<LEADER>5", "workbench.action.openEditorAtIndex5"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 5"):set()
    map("<LEADER>6", "workbench.action.openEditorAtIndex6"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 6"):set()
    map("<LEADER>7", "workbench.action.openEditorAtIndex7"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 7"):set()
    map("<LEADER>8", "workbench.action.openEditorAtIndex8"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 8"):set()
    map("<LEADER>9", "workbench.action.openEditorAtIndex9"):mode("n"):vscNotify():noremap():silent():desc("editor: jump to editor 9"):set()

    -- editor jump
    map("<LEADER>u", "workbench.action.focusAboveGroup"):vscNotify():noremap():silent():set()
    map("<LEADER>e", "workbench.action.focusBelowGroup"):vscNotify():noremap():silent():set()
    map("<LEADER>n", "workbench.action.focusLeftGroup"):vscNotify():noremap():silent():set()
    map("<LEADER>i", "workbench.action.focusRightGroup"):vscNotify():noremap():silent():set()

    -- misc action
    map("<LEADER>fc", "workbench.action.selectTheme"):vscNotify():noremap():silent():set()
    map("<LEADER>ff", "workbench.action.quickOpen"):vscNotify():noremap():silent():set()
    map("<LEADER>fw", "workbench.action.findInFiles"):vscNotify():noremap():silent():set()
    -- map("tt", "workbench.view.explorer"):mode("n"):vscNotify():noremap():silent():desc("view: toggle file explorer"):set()

    -- Code Action
    map("<LEADER>cw", "editor.action.refactor"):vscNotify():noremap():silent():set()

    -- save and quit
    map("S", "workbench.action.files.save"):mode("n"):vscNotify():noremap():silent():desc("editor: save files"):set()
    map("Q", "workbench.action.quit"):mode("n"):vscNotify():noremap():silent():desc("editor: quit all"):set()
end

setKeys()
