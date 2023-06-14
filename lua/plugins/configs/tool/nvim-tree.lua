return function()
    local icons = {
        diagnostics = require("r1v3r.icons").get("diagnostics"),
        documents = require("r1v3r.icons").get("documents"),
        git = require("r1v3r.icons").get("git"),
        ui = require("r1v3r.icons").get("ui")
    }

    require("nvim-tree").setup({
        on_attach = function(bufnr)
            local api = require "nvim-tree.api"
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            -- delete mappings e
            vim.keymap.del('n', 'e', {
                buffer = bufnr
            })
            -- open file/dir
			vim.keymap.set("n", "i", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "n", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "o", api.node.open.no_window_picker, opts("Open: No Window Picker"))
			vim.keymap.set("n", "I", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "O", api.node.open.tab, opts("Open: New Tab"))
            -- vim.keymap.set('n', 'E', api.node.open.horizontal, opts('Open: Horizontal Split'))
        end,
        auto_reload_on_write = true,
        create_in_closed_folder = false,
        disable_netrw = false,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = true,
        open_on_tab = false,
        respect_buf_cwd = false,
        sort_by = "name",
        -- prefer_startup_root = true,
        sync_root_with_cwd = true,
        view = {
            adaptive_size = false,
            centralize_selection = false,
            width = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            float = {
                enable = false,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1
                }
            }
        },
        renderer = {
            add_trailing = false,
            group_empty = true,
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "none",
            special_files = {"Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt"},
            symlink_destination = true,
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    item = "│ ",
                    none = "  "
                }
            },
            root_folder_label = ":.:s?.*?/..?",
            icons = {
                webdev_colors = true,
                git_placement = "before",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true
                },
                padding = " ",
                symlink_arrow = " 󰁔 ",
                glyphs = {
                    default = icons.documents.Default, -- 
                    symlink = icons.documents.Symlink, -- 
                    bookmark = icons.ui.Bookmark,
                    git = {
                        unstaged = icons.git.Mod_alt,
                        staged = icons.git.Add, -- 󰄬
                        unmerged = icons.git.Unmerged,
                        renamed = icons.git.Rename, -- 󰁔
                        untracked = icons.git.Untracked, -- "󰞋"
                        deleted = icons.git.Remove, -- 
                        ignored = icons.git.Ignore -- ◌
                    },
                    folder = {
                        arrow_open = icons.ui.ArrowOpen,
                        arrow_closed = icons.ui.ArrowClosed,
                        -- arrow_open = "",
                        -- arrow_closed = "",
                        default = icons.ui.Folder,
                        open = icons.ui.FolderOpen,
                        empty = icons.ui.EmptyFolder,
                        empty_open = icons.ui.EmptyFolderOpen,
                        symlink = icons.ui.SymlinkFolder,
                        symlink_open = icons.ui.FolderOpen
                    }
                }
            }
        },
        hijack_directories = {
            enable = true,
            auto_open = true
        },
        update_focused_file = {
            enable = true,
            update_root = true,
            ignore_list = {}
        },
        filters = {
            dotfiles = false,
            custom = {".DS_Store", "^.git$"},
            exclude = {}
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = {"notify", "qf", "diff", "fugitive", "fugitiveblame"},
                        buftype = {"terminal", "help"}
                    }
                }
            },
            remove_file = {
                close_window = true
            }
        },
        diagnostics = {
            enable = false,
            show_on_dirs = false,
            debounce_delay = 50,
            icons = {
                hint = icons.diagnostics.Hint_alt,
                info = icons.diagnostics.Information_alt,
                warning = icons.diagnostics.Warning_alt,
                error = icons.diagnostics.Error_alt
            }
        },
        filesystem_watchers = {
            enable = true,
            debounce_delay = 50
        },
        git = {
            enable = true,
            ignore = true,
            show_on_dirs = true,
            timeout = 400
        },
        trash = {
            cmd = "gio trash",
            require_confirm = true
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                dev = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false
            }
        }
    })
end
