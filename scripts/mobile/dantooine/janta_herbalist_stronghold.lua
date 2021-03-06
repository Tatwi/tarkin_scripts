janta_herbalist_stronghold = Creature:new {
	objectName = "@mob/creature_names:janta_herbalist",
	socialGroup = "janta_tribe",
	pvpFaction = "janta_tribe",
	faction = "janta_tribe",
	level = 120,
	chanceHit = 1,
	damageMin = 645,
	damageMax = 1000,
	baseXp = 15174,
	baseHAM = 24000,
	baseHAMmax = 30000,
	armor = 1,
	resists = {-1,45,-1,45,25,25,45,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dantari_male.iff",
		"object/mobile/dantari_female.iff"},
	lootGroups = {
	    {
			groups = {
				{group = "janta_common", chance = 3000000},
				{group = "loot_kit_parts", chance = 1500000},
				{group = "clothing_attachments", chance = 1150000},
				{group = "armor_attachments", chance = 1150000},
				{group = "binayre_common", chance = 1500000},
				{group = "forage_medical_component", chance = 1500000},
				{group = "forage_rare", chance = 200000}
			},
			lootChance = 65000000
		}	
	},
	weapons = {"primitive_weapons"},
	conversationTemplate = "",
	attacks = tkamaster
}

CreatureTemplates:addCreatureTemplate(janta_herbalist_stronghold, "janta_herbalist_stronghold")
