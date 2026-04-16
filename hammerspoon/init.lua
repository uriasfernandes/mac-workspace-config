local spaces = require("hs.spaces")

-- wallpapers na ordem visual dos Spaces
local wallpapers = {
    [1] = "/Users/urias/Pictures/wallpapers/1-pessoal.png",
    [2] = "/Users/urias/Pictures/wallpapers/2-trabalho.png",
    [3] = "/Users/urias/Pictures/wallpapers/3-finops.png",
    [4] = "/Users/urias/Pictures/wallpapers/4-devops-k8s.png",
    [5] = "/Users/urias/Pictures/wallpapers/5-devops-vault.png",
    [6] = "/Users/urias/Pictures/wallpapers/6-devops-ia.png",
    [7] = "/Users/urias/Pictures/wallpapers/7-devops-bot.png",
}

-- retorna a posição visual do Space atual
local function getSpaceIndex(spaceID)
    local allSpaces = spaces.allSpaces()

    for _, screenSpaces in pairs(allSpaces) do
        for index, id in ipairs(screenSpaces) do
            if id == spaceID then
                return index
            end
        end
    end

    return nil
end

-- atualiza wallpaper
local function updateWallpaper()

    local currentSpace = spaces.focusedSpace()
    if not currentSpace then return end

    local index = getSpaceIndex(currentSpace)
    if not index then return end

    local wallpaper = wallpapers[index]
    if not wallpaper then return end

    local screen = hs.screen.mainScreen()

    screen:desktopImageURL("file://" .. wallpaper)

end

-- watcher para detectar troca de Space
local spaceWatcher = spaces.watcher.new(function()
    updateWallpaper()
end)

spaceWatcher:start()

-- executa ao iniciar Hammerspoon
updateWallpaper()