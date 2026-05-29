local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local gui = player.PlayerGui:WaitForChild("ScreenGui")
local flipBtn  = gui:WaitForChild("MainFrame"):WaitForChild("FlipButton")
local resetBtn = gui:WaitForChild("MainFrame"):WaitForChild("ResetButton")

local isFlipped = false
local FLIP_SOUND_ID = "rbxassetid://131961136" --or whatever sound u want

local sound = Instance.new("Sound")
sound.SoundId = FLIP_SOUND_ID
sound.Volume = 0.8
sound.Parent = rootPart

local function flipGravity()
    isFlipped = true
    sound:Play()

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Bounce)
    local tween = TweenService:Create(rootPart, tweenInfo, {
        CFrame = rootPart.CFrame * CFrame.Angles(math.pi, 0, 0)
    })
    tween:Play()
    rootPart.AssemblyLinearVelocity = Vector3.new(0, 50, 0)
end

local function resetGravity()
    if not isFlipped then return end  -- does nothing if already normal
    isFlipped = false
    sound:Play()

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Bounce)
    local tween = TweenService:Create(rootPart, tweenInfo, {
        CFrame = rootPart.CFrame * CFrame.Angles(math.pi, 0, 0)
    })
    tween:Play()
    rootPart.AssemblyLinearVelocity = Vector3.new(0, -50, 0)
end

flipBtn.MouseButton1Click:Connect(function()
    if not isFlipped then  -- only flips if not already flipped
        flipGravity()
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    resetGravity()
end)

-- Handle respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    isFlipped = false
end)
