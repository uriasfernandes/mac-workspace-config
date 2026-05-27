-- carregamento seguro
local ok, err = pcall(function()
    require("spaces-wallpaper")
end)

if not ok then
    hs.alert.show("❌ Erro na config")
    print(err)
end

-- auto reload com debounce
local function reloadConfig(files)
    hs.timer.doAfter(0.5, function()
        hs.reload()
    end)
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-- atalho para bloquear via protetor de tela
local lockMods = {"cmd"}
local lockKey = "l"

hs.hotkey.bind(lockMods, lockKey, function()
    hs.caffeinate.startScreensaver()
end)

hs.alert.show([[
🚀 Workspace carregado
   Atalho lock: Cmd+L
]])