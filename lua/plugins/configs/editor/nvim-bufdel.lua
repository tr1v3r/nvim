return function()
    require('bufdel').setup {
        next = 'tabs',
        quit = true -- quit Neovim when last buffer is closed
    }
end
