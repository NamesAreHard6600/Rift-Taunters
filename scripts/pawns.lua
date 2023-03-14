local path = mod_loader.mods[modApi.currentMod].scriptPath

local pawnColor = 0
--Mechs
TauntMech = {
	Name = "Taunt Mech",
	Class = "Prime",
	Health = 4,
	MoveSpeed = 3,
	Image = "MechPunch",
	ImageOffset = 0,
	SkillList = { "Taunt_Fist" }, --Prime_Punchmech
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
}
	
AddPawn("TauntMech")

JeerMech = {
	Name = "Jeer Mech",
	Class = "Brute",
	Health = 4,
	Image = "MechTank",
	ImageOffset = 0,
	MoveSpeed = 3,
	SkillList = { "Taunt_Cannon" },  --Brute_Tankmech  
	SoundLocation = "/mech/brute/tank/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
}

AddPawn("JeerMech")
	
InsultMech = {
	Name = "Insult Mech",
	Class = "Ranged",
	Health = 2,
	Image = "MechArt", 
	ImageOffset = 0,
	MoveSpeed = 3,
	SkillList = { "Taunt_Artillery" }, --Ranged_Artillerymech
	SoundLocation = "/mech/distance/artillery/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
}
	
AddPawn("InsultMech")
