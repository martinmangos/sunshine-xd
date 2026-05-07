local module = {}

local CollectionService = game:GetService("CollectionService")

local function parseSequenceIds(sequence)
	local ids = {}
	for id in string.gmatch(sequence, "%d+") do
		ids[#ids + 1] = id
	end
	return ids
end

function module.SoundPlay(handle, cloneMode, defaultSoundMode)
	if not handle or not handle:FindFirstChild("ShootSound") then
		return
	end

	local shootSound = handle.ShootSound

	if defaultSoundMode then
		local clone = shootSound:Clone()
		clone:SetAttribute("SequenceSFX", nil)
		clone.SoundId = shootSound:GetAttribute("DefaultSoundId") or shootSound.SoundId
		clone.Name = "DefaultShoot"
		clone.Parent = handle
		CollectionService:AddTag(clone, "GunSounds")
		clone:Play()
		task.delay(math.max(clone.TimeLength, 3), function()
			if clone.Parent then
				clone:Destroy()
			end
		end)
		return
	end

	local sequence = shootSound:GetAttribute("SequenceSFX")
	if type(sequence) == "string" and sequence ~= "" then
		local ids = parseSequenceIds(sequence)
		if #ids > 0 then
			local current = shootSound:GetAttribute("CurrentSequence") or 0
			current += 1
			shootSound:SetAttribute("CurrentSequence", current)
			local nextId = ids[(current - 1) % #ids + 1]
			shootSound.SoundId = "rbxassetid://" .. nextId
		end
	end

	if cloneMode then
		local clone = shootSound:Clone()
		clone.Name = "MG"
		clone.Parent = handle
		clone:Play()
		task.delay(math.max(clone.TimeLength, 3), function()
			if clone.Parent then
				clone:Destroy()
			end
		end)
		return
	end

	shootSound:Play()
end

return module
