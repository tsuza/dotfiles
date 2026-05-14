local M = {}

M.base_dir = os.getenv("HOME") .. "/Pictures/Screenshots"

local function build_path()
    local folder = os.date("%Y-%m")
    local dir = M.base_dir .. "/" .. folder

    local file = "screenshot_" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png"
    local path = dir .. "/" .. file

    return dir, path
end

function M.copy()
    local dir, path = build_path()

    hl.dsp.exec_cmd('mkdir -p "' .. dir .. '"')
    hl.dsp.exec_cmd('flameshot gui -c -p "' .. path .. '"')
end

function M.upload()
    local dir, path = build_path()

    hl.dsp.exec_cmd('mkdir -p "' .. dir .. '"')
    hl.dsp.exec_cmd('flameshot gui -u -p "' .. path .. '"')
end

return M
