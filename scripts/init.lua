
local function init(self)
	--init variables
	local path = mod_loader.mods[modApi.currentMod].scriptPath
	--libs
	local mod = mod_loader.mods[modApi.currentMod]
	local resourcePath = mod.resourcePath
	local scriptPath = mod.scriptPath
	local options = mod_loader.currentModContent[mod.id].options

	self.libs = {}
	self.libs.modApiExt = modapiext
	NAH_RiftTaunters_ModApiExt = self.libs.modApiExt

	--Scripts
	require(self.scriptPath.."weapons")
	require(self.scriptPath.."pawns")
	--require(self.scriptPath.."hooks")

	--Weapon Texts
	modApi:addWeapon_Texts(require(self.scriptPath .. "weapons_text"))
end

local function load(self,options,version)
	NAH_RiftTaunters_ModApiExt:load(self, optoins, version)
	modApi:addSquadTrue({"Rift Taunters", "TauntMech", "JeerMech", "InsultMech"}, "Rift Taunters", "Rift Walkers got an upgrade! Instead of displacement, Rift Taunters taunt their enemies, with a small health upgrade to offset.",self.resourcePath.."/squadIcon.png")
end
--[[
local function metadata()

end
]]--

return {
  id = "NamesAreHard - Rift Taunters",
  name = "Rift Taunters",
	icon = "modIcon.png",
	description = "Rift Walkers got an upgrade! Instead of displacement, Rift Taunters taunt their enemies, with a small health upgrade to offset.",
	modApiVersion = "2.9.1",
	gameVersion = "1.2.83",
	version = "1.1.0",
	requirements = { "kf_ModUtils" },
	dependencies = {
		modApiExt = "1.18",
		memedit = "1.0.2",
		easyEdit = "2.0.4",
	},
	--metadata = metadata,
	load = load,
	init = init
}
