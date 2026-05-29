local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local gui = player.PlayerGui:WaitForChild("ScreenGui")
local flipBtn = gui:WaitForChild("MainFrame"):WaitForChild("FlipButton")

local isFlipped = false
local FLIP_SOUND_ID = "rbxassetid://131961136" --or whatever sound u want

local sound = Instance.new("Sound")
sound.SoundId = FLIP_SOUND_ID
sound.Volume = 0.8
sound.Parent = rootPart

local function flipGravity()
    isFlipped = not isFlipped
    sound:Play()

    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Bounce)

    if isFlipped then
        local tween = TweenService:Create(rootPart, tweenInfo, {
            CFrame = rootPart.CFrame * CFrame.Angles(math.pi, 0, 0)
        })
        tween:Play()
        humanoid.WalkSpeed = 16
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 50, 0)
    else
        local tween = TweenService:Create(rootPart, tweenInfo, {
            CFrame = rootPart.CFrame * CFrame.Angles(math.pi, 0, 0)
        })
        tween:Play()
        rootPart.AssemblyLinearVelocity = Vector3.new(0, -50, 0)
    end
end

flipBtn.MouseButton1Click:Connect(function()
    flipGravity()
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    isFlipped = false
end)
