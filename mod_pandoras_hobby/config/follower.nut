::PandorasHobby.Follower <- {
    //these are also their slots visually around the fire!
    Archetype = {
        Agent = 0,
        Officer = 1,
        Healer = 2,
        Steward = 3,
        Ranger = 4,
    },

    ArchetypeStrings =
    [
        "Agent",
        "Officer",
        "Healer",
        "Steward",
        "Ranger",
    ],

    Type = {
        Follower = 1,
        Trainer = 0,
    }

    Age = {        
        Young = 0,
        Adult = 1,
        Old = 2,
    },

    AgeThreshold = [
        3,  //young
        6,  //adult
        9999,   //old

    ],

    MaxDailyXP = 2,

    Skill = {
        None = 0,

        // -------------------------- Ranger Skills
        Scouting_Report = 1,
        Scouting_Vision = 2,
        Raider_Snow_1 = 4,
        Raider_Snow_2 = 8,
        Guide_Move = 16,
        Lookout_High = 32,
        Lookout_All = 64,
        Carto_Pay = 128,
        Guide_Hunt_Forest = 256,
        Guide_Hunt_All = 512,
        Raider_Mountain = 1024,
        Raider_Pursuit = 2048,

        Pup_Hunt = 524288,
        Rambler_Move = 1048576,
        OldBear_Ammo = 2097152,

        // -------------------------- Healer Skills
        Alch_Snake_Oil_All = 1,
        Alch_Snake_Oil_2x = 2,
        Alch_Potions_1 = 4,
        Alch_Potions_2 = 8,
        Medic_Medicine = 16,
        Medic_Holywater = 32,
        Medic_Survive = 64,
        Medic_Temple_PInj = 128,
        Medic_Heal_Rate = 256,
        Medic_Treat_Tend = 512,
        Alch_Cultist = 1024,
        Alch_Anatomist_1 = 2048,
        Alch_Anatomist_2 = 4096,
        Alch_Anatomist_3 = 8192,

        Extra_Medicine = 524288,    //foundling
        Less_Infection = 1048576,   //quack
        True_Cultist = 2097152,     //Spook

        // -------------------------- Steward Skills
        Smith_Repair_Speed = 1,
        Smith_Recipes = 2,
        Smith_SaveTools = 4,
        Cook_Preserve = 8,
        Cook_Recipes = 16,
        Quart_Storage_1 = 32,
        Quart_Storage_2 = 64,
        Quart_Storage_3 = 128,
        Scav_RecoverAll = 256,
        Scav_Scavenge_1 = 512,
        Scav_Scavenge_2 = 1024,

        Net_Master = 524288,        //fish
        Scrap_Cook = 1048576,       //gruel
        Tool_Storage = 2097152,     //tinker

        // -------------------------- Officer Skills
        Bounty_Champ_1 = 1,
        Bounty_Champ_2 = 2,
        Bounty_Champ_3 = 4,        

        Drill_BoostXP = 8,
        Drill_BoostAttrib_1 = 16,
        Drill_BoostAttrib_2 = 32,
        Drill_BoostAttrib_3 = 64,
        Recruiter_Tryout = 128,
        Recruiter_Boost = 256,
        Paymaster_Disc_1 = 512,
        Paymaster_Disc_2 = 1024,

        Bounty_Champ_4 = 2048,
        Bounty_Champ_5 = 4096,

        Brat_HireDisc = 524288,
        Collector_Pay = 1048576,
        Wardog_Desert = 2097152,


        // -------------------------- Agent Skills
        Agent_Settlements = 1,
        Agent_Caravan = 2,
        Nego_Negotiation = 4,
        Nego_Decay_1 = 8,
        Nego_Decay_2 = 16,
        Nego_Decay_3 = 32,
        Minstrel_Renown_1 = 64,
        Minstrel_Renown_2 = 128,
        Trader_Trade = 256,
        Trader_Shop = 512,

        LittleBird_Rumors = 524288,
        Porter_Rarity = 1048576,
        Joro_Spider = 2097152,
    },

    SkillMasks = {
        Ranger_MAX = 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048,
        Healer_MAX = 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 | 8192,
        Steward_MAX = 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024,
        Officer_MAX = 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096,
        Agent_MAX = 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512,
    },

    HuntingOdds = [
	    0,      //Impassable
	    0,      //Ocean
	    10,     //Plains
	    8,      //Swamp
	    12,     //Hills
	    20,     //Forest
	    15,     //SnowyForest
	    25,     //LeaveForest
	    25,     //AutumnForest
	    5,      //Mountains
	    15,     //Urban
	    15,     //Farmland
	    5,      //Snow
	    5,      //Badlands
	    10,     //Tundra
	    5,      //Steppe
	    18,     //Shore
	    5,      //Desert
	    8,      //Oasis
    ],
};