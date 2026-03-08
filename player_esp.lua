-- player_esp.lua
-- this file is fetched by the loader, make it valid Lua

local RS = game:GetService("RunService")
local pathRoot = workspace.Live -- customise if needed

local adornments = {}

local function clear()
    for _, a in pairs(adornments) do
        if a and a.Parent then a:Destroy() end
    end
    adornments = {}
end

local function makeBox(inst)
    if adornments[inst] then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Name        = "ESPBox"
    box.Adornee     = inst
    box.Size        = inst:GetExtentsSize()
    box.Transparency = 0.5
    box.Color3      = Color3.new(1,0,0)
    box.ZIndex      = 10
    box.Parent      = inst
    adornments[inst] = box
end

local conn
local function onToggle(val)
    if conn then conn:Disconnect(); conn = nil end
    clear()
    if val then
        conn = RS.RenderStepped:Connect(function()
            for _, c in pairs(pathRoot:GetChildren()) do
                if not adornments[c] then
                    makeBox(c)
                end
            end
        end)
    end
end

-- the loader will call this when the toggle value changes
return {
    Init = function(toggle)
        toggle:Callback(onToggle)
    end
}
