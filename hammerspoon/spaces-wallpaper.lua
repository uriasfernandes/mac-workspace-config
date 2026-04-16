local spaces = require("hs.spaces")

local wallpapers = {
    [1] = os.getenv("HOME") .. "/Pictures/wallpapers/1-pessoal.png",
    [2] = os.getenv("HOME") .. "/Pictures/wallpapers/2-trabalho.png",
    [3] = os.getenv("HOME") .. "/Pictures/wallpapers/3-finops.png",
    [4] = os.getenv("HOME") .. "/Pictures/wallpapers/4-devops-k8s.png",
    [5] = os.getenv("HOME") .. "/Pictures/wallpapers/5-devops-vault.png",
    [6] = os.getenv("HOME") .. "/Pictures/wallpapers/6-devops-ia.png",
}

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

spaces.watcher.new(updateWallpaper):start()

updateWallpaper()
