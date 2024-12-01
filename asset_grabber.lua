local function getAssetIdsFromGame()
    local assetIds = {}
    
    -- Iterate over all parts, accessories, clothes, and decals in the game
    for _, object in pairs(workspace:GetDescendants()) do
        -- Check if the object is a valid asset type
        if object:IsA("MeshPart") or object:IsA("Accessory") or object:IsA("Shirt") or object:IsA("Pants") or object:IsA("Decal") then
            local assetId = nil
            
            -- Get the asset ID for different types of assets
            if object:IsA("MeshPart") then
                if object.MeshId then
                    assetId = object.MeshId
                end
            elseif object:IsA("Accessory") then
                if object.AttachmentPoint then
                    -- Some accessories may have an asset ID
                    assetId = object.TextureID
                end
            elseif object:IsA("Shirt") or object:IsA("Pants") then
                assetId = object.AssetId
            elseif object:IsA("Decal") then
                assetId = object.Texture
            end

            -- If an asset ID was found, store it
            if assetId and not table.find(assetIds, assetId) then
                table.insert(assetIds, assetId)
            end
        end
    end
    
    -- Print the asset IDs to the console for review
    for _, assetId in ipairs(assetIds) do
        print("Asset ID: " .. assetId)
    end
end

-- Run the function to grab the asset IDs
getAssetIdsFromGame()
