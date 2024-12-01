local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

-- GUI Setup
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0, 0, 0)

local loadingText = Instance.new("TextLabel", frame)
loadingText.Size = UDim2.new(1, 0, 0.2, 0)
loadingText.Position = UDim2.new(0, 0, 0, 10)
loadingText.Text = "Loading... 0%"
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.TextSize = 18
loadingText.BackgroundTransparency = 1

local progressBar = Instance.new("Frame", frame)
progressBar.Size = UDim2.new(0, 0, 0.2, 0)
progressBar.Position = UDim2.new(0, 0, 0.3, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

local contentFrame = Instance.new("ScrollingFrame", frame)
contentFrame.Size = UDim2.new(1, 0, 0.5, 0)
contentFrame.Position = UDim2.new(0, 0, 0.6, 0)
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.ScrollBarThickness = 8
contentFrame.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", contentFrame)
UIListLayout.Padding = UDim.new(0, 5)

local assetIds = {}

-- Function to grab asset IDs from the game
local function grabAssetIds()
    local totalAssets = 0
    local currentAsset = 0
    
    -- Counting the total number of assets in the workspace to display the percentage
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("MeshPart") or object:IsA("Accessory") or object:IsA("Shirt") or object:IsA("Pants") or object:IsA("Decal") then
            totalAssets = totalAssets + 1
        end
    end
    
    -- Grabbing the asset IDs
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("MeshPart") or object:IsA("Accessory") or object:IsA("Shirt") or object:IsA("Pants") or object:IsA("Decal") then
            local assetId = nil
            if object:IsA("MeshPart") then
                if object.MeshId then
                    assetId = object.MeshId
                end
            elseif object:IsA("Accessory") then
                if object.TextureID then
                    assetId = object.TextureID
                end
            elseif object:IsA("Shirt") or object:IsA("Pants") then
                assetId = object.AssetId
            elseif object:IsA("Decal") then
                assetId = object.Texture
            end
            
            -- Add unique asset IDs to the list
            if assetId and not table.find(assetIds, assetId) then
                table.insert(assetIds, assetId)
            end

            -- Update the loading progress
            currentAsset = currentAsset + 1
            local progress = (currentAsset / totalAssets)
            loadingText.Text = string.format("Loading... %d%%", math.floor(progress * 100))
            progressBar.Size = UDim2.new(progress, 0, 0.2, 0)
            wait(0.01)
        end
    end
    
    -- Display the asset IDs once loading is complete
    loadingText.Text = "Done! Copy the Asset IDs Below"
    
    for _, assetId in ipairs(assetIds) do
        local assetLabel = Instance.new("TextLabel")
        assetLabel.Text = assetId
        assetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        assetLabel.TextSize = 14
        assetLabel.Size = UDim2.new(1, 0, 0, 30)
        assetLabel.BackgroundTransparency = 1
        assetLabel.TextWrapped = true
        assetLabel.Parent = contentFrame
        
        -- Make the text copyable
        assetLabel.MouseButton1Click:Connect(function()
            setclipboard(assetId)
        end)
    end
end

-- Start the process
grabAssetIds()
