
 LPlr = game.Players.LocalPlayer
 MDown = false
 Mouse = LPlr:GetMouse()
    function ConvertNumbers(X, Y)
        local TX = Mouse.ViewSizeX*X
        local TY = Mouse.ViewSizeY*Y
    return TX, TY
end
    local OriginalMaxAndMin = {LPlr.CameraMaxZoomDistance, LPlr.CameraMinZoomDistance}
        function MoveableItem(item)
            item.InputBegan:connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            MDown = true
        local CX, CY = ConvertNumbers(item.Position.X.Scale, item.Position.Y.Scale)
        item.Position = UDim2.new(0, item.Position.X.Offset+CX, 0, item.Position.Y.Offset+CY)
        local StartX = Mouse.X - item.Position.X.Offset
        local StartY = Mouse.Y - item.Position.Y.Offset
    while MDown == true do
        item.Position = UDim2.new(0, Mouse.X - StartX, 0, Mouse.Y - StartY)
        wait()
        end
    end
end)

    item.InputEnded:connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
            MDown = false
            end
        end)
    end

    function LockedCamera(Val)
        local Dist = (game.Workspace.Camera.CoordinateFrame.p - LPlr.Character.Head.Position).Magnitude
        LPlr.CameraMaxZoomDistance = Dist
        LPlr.CameraMinZoomDistance = Dist
        if Val ~= true then
        LPlr.CameraMaxZoomDistance = OriginalMaxAndMin[1]
        LPlr.CameraMinZoomDistance = OriginalMaxAndMin[2]
    end
end
    function ChangePos(input, item, Amount)
    local Pos = item.CanvasPosition
    if Amount == nil then
    Amount = 90

end
        Amount = Amount *-1
            Pos = Pos + Vector2.new(0, input.Position.Z*Amount)
            if Pos.Y < 0 then
            Pos = Vector2.new(0, 0)
            elseif Pos.Y > item.CanvasSize.Y.Offset then
            Pos = Vector2.new(0, item.CanvasSize.Y.Offset)
        end
    item.CanvasPosition = Pos
end

        function ScrollableItem(item, Amount)
            item.ScrollingEnabled = false
            item.inputBegan:connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseWheel then
            ChangePos(input, item, Amount)
        end
    end)

        item.InputChanged:connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseWheel then
        ChangePos(input, item, Amount)
    end
end)

        item.MouseEnter:connect(function()
    LockedCamera(true)
end)

         item.MouseLeave:connect(function()
        LockedCamera()
    end)
end

Get = game:GetService("ReplicatedStorage").GET
function GetMainData()
    for i, v in pairs(debug.getregistry()) do
        if typeof(v) == "function" then
            for a, b in pairs(debug.getupvalues(v)) do
                if typeof(b) == "table" and rawget(b, "Fishing") then
                    return b
                end
            end
        end
    end
end
Data = GetMainData()
AuthKey = debug.getupvalue(Data["Network"]["getAuthKey"], 1)
function ToggleSubmarine(Val)
    local Sub = true
    if LPlr.Character ~= nil and LPlr.Character:FindFirstChild("UMVModel") then
        Sub = false
    end
    if Val ~= nil then
        Sub = Val
    end
    Get:InvokeServer(AuthKey, "ToggleSubmarine", Sub)
end
function GoInvisible()
    if LPlr.Character == nil or LPlr.Character:FindFirstChild("UMVModel") and not LPlr.Character.UMVModel:FindFirstChild("Root") then
        return
    end
    ToggleSubmarine(true)
    repeat
        wait()
    until LPlr.Character:FindFirstChild("UMVModel")
    LPlr.Character.UMVModel:FindFirstChild("Root"):remove()
end
function GoVisible()
    ToggleSubmarine(false)
end
local SF = {}
SF["Fish"] = Data["Fishing"]["Fish"]
SF["Fly"] = Data["Menu"]["map"]["fly"]
local SkipChat = true
local OldWait;
OldWait = hookfunction(Data["NPCChat"]["AdvanceSignal"]["wait"], function(...)
if SkipChat then
return
end
OldWait(...)
end)
local Old;
Old = hookfunction(Data["NPCChat"]["say"], function(...)
    local Args = {...}
if SkipChat then
for i = 3, #Args do
if typeof(Args[i]) == "string" then
Args[i] = "."
end
end
end
    return Old(unpack(Args))
end)

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Yemen Hub", HidePremium = false, IntroEnabled = false, SaveConfig = true, ConfigFolder = "OrionTest"})


local IMPORTANT = Window:MakeTab({
    Name = "IMPORTANT",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
IMPORTANT:AddParagraph("General Information","I will be adding a lot more to this soon but this is just basic shit so u guys can have what I have :) (This also works in gyms)")
IMPORTANT:AddParagraph("Pokemon Heal Information", "With the Pokemon Heal you MUST be in an area with an already existing pokecenter aka the thing that fucking heals your pokemon. ALSO DOES NOT WORK DURING A BATTLE!")
IMPORTANT:AddParagraph("Miscellaneous", "All of the things in miscellaneous should work anywhere you go, if there isn't then dm me and I'll try to fix it. If I can't fix it then I'll just fucking delete the module")
IMPORTANT:AddParagraph("Kick Information", "If you get kicked at anytime I'm like 99% sure it's not a ban, while making this script I was kicked about 1000 times and I'm still not banned. Its likely that you're just a fucking dumbass and did Pokemon Heal when there was no PokeCenter around.")
IMPORTANT:AddParagraph("Made with Love from Yemen <3", "((((PS YOU'RE WELCOME!!))))")
--pokemon modifications
local Pokmeon = Window:MakeTab({
    Name = "Pokemon",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
Pokmeon:AddButton({
    Name = "Heal All Pokemon",
    Default = false,
    Callback = function(Value)
    Get:InvokeServer(AuthKey, "PDS", "getPartyPokeBalls")
    OrionLib:MakeNotification({
        Name = "Healed!",
        Content = "All Pokemon healed!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
    end    
})
--changing char and other modifications to characters or environement.
local Misc = Window:MakeTab({
    Name = "Miscellaneous",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
Misc:AddParagraph("Works Anywhere Anytime", "")

Misc:AddToggle({
    Name = "Skip NPC Chats",
    Default = false,
    Callback = function(Value)
    SkipChat = Value
    end    
})

OrionLib:Innit()
