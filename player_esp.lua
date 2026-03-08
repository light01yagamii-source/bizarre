-- player_esp.lua
local toggle = getgenv().PlayerESPToggle

local function clear()
    for _, chr in pairs(workspace.Live:GetChildren()) do
        local b = chr:FindFirstChild("ESPBox")
        if b then b:Destroy() end
    end
end

toggle:Callback(function(on)
    clear()
    if on then
        toggle._conn = game:GetService("RunService")
                        .RenderStepped:Connect(function()
            for _, chr in pairs(workspace.Live:GetChildren()) do
                if not chr:FindFirstChild("ESPBox") then
                    local b = Instance.new("BoxHandleAdornment")
                    b.Name    = "ESPBox"
                    b.Adornee = chr
                    b.Size    = chr:GetExtentsSize()
                    b.Transparency = 0.5
                    b.Color3  = Color3.new(1,0,0)
                    b.ZIndex  = 10
                    b.Parent  = chr
                end
            end
        end)
    elseif toggle._conn then
        toggle._conn:Disconnect()
        toggle._conn = nil
    end
end)
