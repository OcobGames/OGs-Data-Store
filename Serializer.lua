local DataStoreService = game:GetService("DataStoreService")

local DS_id
local DataStore

local DSM = {}

function DSM:SetId(id)
	if id ~= nil and tostring(id) then
		DS_id = id
		DataStore = DataStoreService:GetDataStore(DS_id)
	else
		error(string.format("[DATA] %s cannot be used as id.", id))
	end
end

function DSM:Save(key,group)
	if DS_id ~= nil and DataStore ~= nil then
		local Data = {}
		
		if group:IsA("Folder") then
			for _,part in pairs(group:GetDescendants()) do
				if part:IsA("BasePart") then
					local Formula = {
						Position = {X = tostring(part.Position.X); Y = tostring(part.Position.Y); Z = tostring(part.Position.Z)};
						Material = string.sub(tostring(part.Material),15);
						Color = {R = 0; G = 0; B = 0};
						Size = {X = tostring(part.Size.X); Y = tostring(part.Size.Y); Z = tostring(part.Size.Z)};
						Orientation = {X = tostring(part.Orientation.X); Y = tostring(part.Orientation.Y); Z = tostring(part.Orientation.Z)};
						Anchored = part.Anchored;
					}
					
					local Splitted = tostring(part.Color):split(", ")
					Formula.Color.R = Splitted[1]
					Formula.Color.G = Splitted[2]
					Formula.Color.B = Splitted[3]

					table.insert(Data,Formula)
				end
			end
			
			if #Data > 2 and DS_id ~= nil and DataStore ~= nil then
				local success,err = pcall(DataStore.SetAsync, DataStore, key, Data)
				if success then
					print(tostring(key).." key was successfully saved.")
				else
					error("[DATA] "..err)
				end
			end
		end
	end
end

function DSM:Load(key,parent)
	if DS_id ~= nil and DataStore ~= nil then
		local Data = DataStore:GetAsync(key)
		if Data then
			for index,tbl in ipairs(Data) do
				local NewBlock = Instance.new("Part",parent)
				for key,value in pairs(tbl) do
					if parent then
						if key == "Position" then
							local X,Y,Z = value.X,value.Y,value.Z
							NewBlock.Position = Vector3.new(X,Y,Z)
						elseif key == "Orientation" then
							local X,Y,Z = value.X,value.Y,value.Z
							NewBlock.Orientation = Vector3.new(X,Y,Z)
						elseif key == "Material" then
							NewBlock.Material = Enum.Material[value]
						elseif key == "Color" then
							local R,G,B = value.R,value.G,value.B
							NewBlock.Color = Color3.new(R,G,B)
						elseif key == "Size" then
							local X,Y,Z = value.X,value.Y,value.Z
							NewBlock.Size = Vector3.new(X,Y,Z)
						elseif key == "Anchored" then
							NewBlock.Anchored = value
						end
						if NewBlock.Material == Enum.Material.Glass then
							NewBlock.Transparency = .75
						end
					end
				end
			end
			print("[DATA] "..tostring(key).." key was successfully loaded.")
		else
			warn("[DATA] "..tostring(key).." key is empty. \nCouldn't load data.")
		end
	end
end

function DSM:Clear(key)
	if DataStore:GetAsync(key) then
		local success,err = pcall(DataStore.RemoveAsync, DataStore, key)
		
		if success then
			print("[DATA] "..tostring(key).." key was successfully cleared.")
		else
			error("[DATA] "..err)
		end
	end
end

return DSM
