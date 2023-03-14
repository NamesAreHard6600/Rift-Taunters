--Functions and Variables
local path = mod_loader.mods[modApi.currentMod].resourcePath
local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath
local taunt = require(scriptPath.."taunt/taunt")
local function IsTipImage()
	return Board:GetSize() == Point(6,6)
end

Taunt_Fist = Skill:new{
	Class = "Prime",
	Icon = "weapons/prime_punchmech.png",
	Rarity = 3,
	Explosion = "",
	LaunchSound = "/weapons/titan_fist",
	Range = 1, -- Tooltip?
	PathSize = 1,
	Damage = 2,
	PushBack = false,
	Flip = false,
	Dash = false,
	Shield = false,
	Projectile = false,
	Push = 1, --Mostly for tooltip, but you could turn it off for some unknown reason
	PowerCost = 1,
	Upgrades = 2,
	--UpgradeList = { "+1 Taunt Range",  "+2 Damage"  },
	UpgradeCost = { 2 , 3 },
	TipImage = StandardTips.Melee,
	ExtraTaunt = false
}

Taunt_Fist_A = Taunt_Fist:new{
	ExtraTaunt = true,
}

Taunt_Fist_B = Taunt_Fist:new{
	Damage = 4,
}

Taunt_Fist_AB = Taunt_Fist:new{
	ExtraTaunt = true,
	Damage = 4,
}

function Taunt_Fist:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	
	taunt.addTauntEffectSpace(ret, p2, p1, self.Damage)
	if self.ExtraTaunt then
		taunt.addTauntEffectSpace(ret, p2+DIR_VECTORS[dir], p2) 
		--LOG(p2-DIR_VECTORS[dir])
		--LOG(p2)
	end
	local damage = SpaceDamage(p2, 0)
	damage.sAnimation = "explopunch1_"..dir
	ret:AddDamage(damage)
	return ret
end	


Taunt_Cannon = TankDefault:new{
	Class = "Brute",
	Damage = 1,
	Icon = "weapons/brute_tankmech.png",
	Explosion = "",
	Sound = "/general/combat/explode_small",
	Damage = 1,
	PowerCost = 1,
	Upgrades = 2,
	Push = 0,
	UpgradeCost = {2,3},
	LaunchSound = "/weapons/modified_cannons",
	ImpactSound = "/impact/generic/explosion",
	TipImage = StandardTips.Ranged,
	ZoneTargeting = ZONE_DIR,
}

Taunt_Cannon_A = Taunt_Cannon:new{
	Damage = 2,
}

Taunt_Cannon_B = Taunt_Cannon:new{
	Damage = 2,
}

Taunt_Cannon_AB = Taunt_Cannon:new{
	Damage = 3,
	Explo = "explopush2_",
}

function Taunt_Cannon:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
	--local damage = SpaceDamage(p2, 0)
	--damage.sAnimation = self.Explo
	--ret:AddDamage(damage)
	local damage = SpaceDamage(target, 0)
	ret:AddProjectile(damage, self.ProjectileArt)
	taunt.addTauntEffectSpace(ret, target, p1, self.Damage)
	
	return ret
end


Taunt_Artillery = ArtilleryDefault:new{
	Class = "Ranged",
	Icon = "weapons/ranged_artillery.png",
	Rarity = 3,
	UpShot = "effects/shotup_tribomb_missile.png",
	ArtilleryStart = 2,
	ArtillerySize = 8,
	BuildingDamage = true,
	DamageOuter = 0,
	DamageCenter = 1,
	PowerCost = 1,
	Damage = 1,---USED FOR TOOLTIPS
	BounceAmount = 1,
	Explosion = "",
	ExplosionCenter = "ExploArt1",
	ExplosionOuter = "",
	Upgrades = 2,
	UpgradeCost = {2,3},
	--UpgradeList = { "Taunt +1 Range", "+2 Damage"  },
	LaunchSound = "/weapons/artillery_volley",
	ImpactSound = "/impact/generic/explosion",
	TauntExtra = false,
	TipImage = {
		Unit = Point(2,4),
		Enemy = Point(2,2),
		Enemy2 = Point(3,2),
		Enemy3 = Point(2,1),
		Target = Point(2,2),
		Mountain = Point(2,3)
	}
	
}

Taunt_Artillery_A = Taunt_Artillery:new{
	TauntExtra = true,
}

Taunt_Artillery_B = Taunt_Artillery:new{
	Damage = 3,
}

Taunt_Artillery_AB = Taunt_Artillery:new{
	TauntExtra = true,
	Damage = 3
}

function Taunt_Artillery:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	
	local damage = SpaceDamage(p2,self.Damage)
	damage.sAnimation = self.ExplosionCenter
	ret:AddBounce(p1, 1)
	ret:AddArtillery(damage, self.UpShot)
	if self.BounceAmount ~= 0 then	ret:AddBounce(p2, self.BounceAmount) end
	
	for dir = 0, 3 do
		taunt.addTauntEffectSpace(ret,p2 + DIR_VECTORS[dir],p2)
		if self.TauntExtra then
			taunt.addTauntEffectSpace(ret,p2 + DIR_VECTORS[dir]*2,p2 + DIR_VECTORS[dir])
		end
	end

	return ret
end