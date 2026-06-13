function pathExists(path)
    local file = io.open(path, "r")
    if file == nil then
        return false
    else
        io.close(file)
        return true
    end
end
