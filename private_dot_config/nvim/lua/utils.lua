-------------------- HELPERS -------------------------------
toggle_mouse = function()
    if vim.o.mouse == "a" then
        vim.o.mouse = ""
        print "Toggle Mouse Off"
    else
        vim.o.mouse = "a"
        print "Toggle Mouse On"
    end
end
