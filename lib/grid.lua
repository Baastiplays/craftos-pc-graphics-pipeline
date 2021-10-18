local grid = {}
local res = {}

local function init(X, Y)
    res.x = X
    res.y = Y
    for y=1,Y do
        grid[y] = {}
        for x=1,X do
            grid[y][x] = {lightLevel=0,depth=math.huge}
        end
    end
end

local function GetlightLevel(X,Y)
    return grid[Y][X].lightLevel
end

local function NDCtoScreen(X,Y,res) 
    X = math.floor( (X+1) * res.x /2)
    Y = math.floor( (Y+1) * res.y /2)
    return X,Y
end

local function SetlightLevel(X,Y,Z,Value)
---@diagnostic disable-next-line: undefined-field
    X,Y = NDCtoScreen(X,Y,vec2(res.x,res.y))
    -- debugLog({X=X,Y=Y,Z=Z,V=Value},"setLL")
    if Z < grid[Y][X].depth then
        grid[Y][X].lightLevel = Value
        grid[Y][X].depth = Z
    end 
end

local function fill(X,Y,W,H,L,D)
    for y=1,H do
        for x=1,W do
            SetlightLevel(X+x-1,Y+y-1,D,L)
        end
    end
end

return {
    NDCtoScreen = NDCtoScreen,
    fill = fill,
    GetlightLevel = GetlightLevel,
    SetlightLevel = SetlightLevel,
    grid = grid,
    init = init
}
