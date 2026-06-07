local spaces = require("hs.spaces")

local wallpapers = {
    [1] = os.getenv("HOME") .. "/Pictures/wallpapers/1-pessoal.png",
    [2] = os.getenv("HOME") .. "/Pictures/wallpapers/2-trabalho.png",
    [3] = os.getenv("HOME") .. "/Pictures/wallpapers/3-finops.png",
    [4] = os.getenv("HOME") .. "/Pictures/wallpapers/4-devops-k8s.png",
    [5] = os.getenv("HOME") .. "/Pictures/wallpapers/5-devops-vault.png",
    [6] = os.getenv("HOME") .. "/Pictures/wallpapers/6-devops-ia.png",
    [7] = os.getenv("HOME") .. "/Pictures/wallpapers/7-bot.png",
}

local MIN_SPACES = 6
local CACHE_DIR = os.getenv("HOME") .. "/Library/Caches/hammerspoon-wallpapers"

local function isBuiltInScreen(screen)
    local info = screen and screen:getInfo() or {}

    if info.builtin ~= nil then return info.builtin end
    if info.Builtin ~= nil then return info.Builtin end
    if info.kCGDisplayIsBuiltin ~= nil then return info.kCGDisplayIsBuiltin end

    local name = (screen and screen:name() or ""):lower()
    return name:find("built%-in", 1, false) ~= nil
        or name:find("retina", 1, false) ~= nil
        or name:find("color lcd", 1, false) ~= nil
end

local function getTargetExternalScreen()
    local main = hs.screen.mainScreen()
    if main and not isBuiltInScreen(main) then
        return main
    end

    for _, screen in ipairs(hs.screen.allScreens()) do
        if not isBuiltInScreen(screen) then
            return screen
        end
    end

    return nil
end

local function getTargetScreenSpaces()
    local target = getTargetExternalScreen()
    if not target then
        return {}
    end

    local allSpaces = spaces.allSpaces() or {}
    local targetUUID = target:getUUID()

    return allSpaces[targetUUID] or {}
end

local function shellQuote(value)
    return string.format("'%s'", tostring(value):gsub("'", "'\\''"))
end

local function getCachedWallpaperPath(path)
    hs.fs.mkdir(CACHE_DIR)

    local attrs = hs.fs.attributes(path)
    if not attrs then
        return path
    end

    local fileName = path:match("([^/]+)$") or "wallpaper.png"
    local modifiedAt = tostring(attrs.modification or os.time())
    local cachedPath = string.format("%s/%s-%s", CACHE_DIR, modifiedAt, fileName)

    if not hs.fs.attributes(cachedPath) then
        local command = string.format("/bin/cp %s %s", shellQuote(path), shellQuote(cachedPath))
        local _, _, _, rc = hs.execute(command, true)
        if rc ~= 0 then
            return path
        end
    end

    return cachedPath
end

-- 🔒 só monitor externo (nunca tela interna)
local function setTargetWallpaper(path)
    local target = getTargetExternalScreen()
    if not target then
        return
    end

    local resolvedPath = getCachedWallpaperPath(path)

    for _, screen in ipairs(hs.screen.allScreens()) do
        if screen:id() == target:id() then
            screen:desktopImageURL("file://" .. resolvedPath)
        end
    end
end

-- 📊 contar Spaces
local function getSpaceCount()
    return #getTargetScreenSpaces()
end

-- 🧠 criar novo Space (simulando Mission Control)
local function createSpace()
    hs.eventtap.keyStroke({"ctrl"}, "up")
    hs.timer.usleep(300000)

    hs.eventtap.keyStroke({}, "n") -- cria novo desktop
    hs.timer.usleep(300000)

    hs.eventtap.keyStroke({"ctrl"}, "down")
end

-- 🚀 garantir mínimo de Spaces
local function ensureMinimumSpaces()

    local current = getSpaceCount()

    if current >= MIN_SPACES then return end

    local toCreate = MIN_SPACES - current

    print("🧠 Criando", toCreate, "Spaces...")

    for i = 1, toCreate do
        createSpace()
        hs.timer.usleep(500000)
    end

end

-- 📍 descobrir índice do Space
local function getSpaceIndex(spaceID)
    for index, id in ipairs(getTargetScreenSpaces()) do
        if id == spaceID then
            return index
        end
    end

    return nil
end

-- 🎯 lógica principal
local function updateWallpaper()

    local target = getTargetExternalScreen()
    if not target then
        print("ℹ️ Nenhum monitor externo detectado; wallpaper tematico ignorado.")
        return
    end

    ensureMinimumSpaces()

    local currentSpace = spaces.activeSpaceOnScreen(target)
    if not currentSpace then return end

    local index = getSpaceIndex(currentSpace)
    if not index then return end

    local wallpaper = wallpapers[index]

    -- 👉 se passar do 6, gera fallback automático
    if not wallpaper then
        wallpaper = os.getenv("HOME") .. "/Pictures/wallpapers/wallpaper-" .. index .. ".png"
    end

    if not hs.fs.attributes(wallpaper) then
        print("❌ Wallpaper não encontrado:", wallpaper)
        return
    end

    setTargetWallpaper(wallpaper)

    print("✅ Space:", index, "| Wallpaper:", wallpaper)

end

spaces.watcher.new(updateWallpaper):start()

-- roda ao iniciar
hs.timer.doAfter(2, function()
    updateWallpaper()
end)