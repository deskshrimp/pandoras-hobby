//Note: champion odds are naturally reduced by 1 when under 90 days, so w/o bounty hunter they won't appear until then unless Variant > 1

//Direwolf
::Const.World.Spawn.Troops.Direwolf.Variant = 1; // vanilla 0
::Const.World.Spawn.Troops.Direwolf.NameList <- ::Const.Strings.PH_DirewolfNames;
::Const.World.Spawn.Troops.Direwolf.TitleList <- null;

::Const.World.Spawn.Troops.DirewolfHIGH.Variant = 2; // vanilla 0
::Const.World.Spawn.Troops.DirewolfHIGH.NameList <- ::Const.Strings.PH_DirewolfNames;
::Const.World.Spawn.Troops.DirewolfHIGH.TitleList <- null;

//Hyena
::Const.World.Spawn.Troops.Hyena.Variant = 1;  // vanilla 0
::Const.World.Spawn.Troops.Hyena.NameList <- ::Const.Strings.PH_DirewolfNames;
::Const.World.Spawn.Troops.Hyena.TitleList <- null;

::Const.World.Spawn.Troops.HyenaHIGH.Variant = 2;  // vanilla 0
::Const.World.Spawn.Troops.HyenaHIGH.NameList <- ::Const.Strings.PH_DirewolfNames;
::Const.World.Spawn.Troops.HyenaHIGH.TitleList <- null;

// Ghost
::Const.World.Spawn.Troops.Ghost.Variant = 1;
::Const.World.Spawn.Troops.Ghost.NameList <- ::Const.Strings.PH_GhostNames;
::Const.World.Spawn.Troops.Ghost.TitleList <- ::Const.Strings.PH_GhostTitles;

// Spider
::Const.World.Spawn.Troops.Spider.Variant = 2;
::Const.World.Spawn.Troops.Spider.NameList <- ::Const.Strings.PH_SpiderNames;
::Const.World.Spawn.Troops.Spider.TitleList <- null;

//Necromancer -- already exists at 1%, boost it to 3%
//but we buff him with extra power and drops
::Const.World.Spawn.Troops.Necromancer.Variant = 3;

//Zombies
::Const.World.Spawn.Troops.ZombieKnight.Variant = 2;	// Vanilla: 1 // Hardened: 0
if ( ::Hooks.hasMod("mod_hardened") )
{
    //Zombie Knight -- Fallen Hero (HD > Fallen Soldier) -- we need him to drop the regular Zombie potion    
    ::Const.World.Spawn.Troops.ZombieKnight.NameList = ::Const.Strings.CharacterNames; //generic names for generic soldiers
    ::Const.World.Spawn.Troops.ZombieKnight.TitleList = null; //remove the hero titles

    //Zombie Betrayer -- Fallen Betrayer (HD > Fallen Hero) -- will drop the Fallen Hero potion
    //Hardened -> ::Const.World.Spawn.Troops.ZombieBetrayer.Variant = 2;	// Vanilla: 0
    //let them have the old names and titles for heros
    ::Const.World.Spawn.Troops.ZombieBetrayer.NameList <- ::Const.Strings.KnightNames,
    ::Const.World.Spawn.Troops.ZombieBetrayer.TitleList <- ::Const.Strings.FallenHeroTitles
}


//Skeletons
//rf_skeleton_medium_elite_polearm    Variant = 1 //HD  -- low skele drop
if ( ::Hooks.hasMod("mod_hardened") )
{
    ::Const.World.Spawn.Troops.RF_SkeletonMediumElitePolearm.NameList <- ::Const.Strings.AncientDeadNames;   //let them have names
    ::Const.World.Spawn.Troops.RF_SkeletonMediumElitePolearm.TitleList <- null;
}
//SkeletonHeavy  Variant = 1 //vanilla  -- heavy skele drops
//RF_SkeletonLegatus  Variant = 1 //RF  -- heavy skele drops

// Skeleton Priest (Ancient Priest) -- skele priest drops
::Const.World.Spawn.Troops.SkeletonPriest.Variant = 2;
::Const.World.Spawn.Troops.SkeletonPriest.NameList <- ::Const.Strings.PH_SkeletonPriestNames;
::Const.World.Spawn.Troops.SkeletonPriest.TitleList <- null;

//Goblins
//Goblin Ambusher & Goblin Skirmisher have Variant = 1 in vanilla -- drop goblin grunt potion
::Const.World.Spawn.Troops.GoblinOverseer.Variant = 1;
::Const.World.Spawn.Troops.GoblinOverseer.NameList <- ::Const.Strings.GoblinNames;
::Const.World.Spawn.Troops.GoblinOverseer.TitleList <- ::Const.Strings.GoblinTitles;

::Const.World.Spawn.Troops.GoblinShaman.Variant = 2;
::Const.World.Spawn.Troops.GoblinShaman.NameList <- ::Const.Strings.GoblinNames;
::Const.World.Spawn.Troops.GoblinShaman.TitleList <- ::Const.Strings.GoblinTitles;

//Orcs
//Orc Warrior, has vanilla Variant = 1 -- drop Young & Warrior potions
//Orc Warlord, has vanilla Variant = 10 -- drop all 4 orc potion types

//Hexe -- quite rare, need a high spawn rate
::Const.World.Spawn.Troops.Hexe.Variant = 10;
::Const.World.Spawn.Troops.Hexe.NameList <- ::Const.Strings.CharacterNamesFemale;
::Const.World.Spawn.Troops.Hexe.TitleList <- ::Const.Strings.PH_WitchTitles;

//Alps -- fairly rare, boost odds a bit
::Const.World.Spawn.Troops.Alp.Variant = 5;
::Const.World.Spawn.Troops.Alp.NameList <- ::Const.Strings.GoblinNames;
::Const.World.Spawn.Troops.Alp.TitleList <- null;

//Nacho Ghouls -- high only to avoid hitting the HD growth code (rarely spawn as tier 3)
::Const.World.Spawn.Troops.GhoulHIGH.Variant = 5;
::Const.World.Spawn.Troops.GhoulHIGH.NameList <- ::Const.Strings.PH_GhoulNames;
::Const.World.Spawn.Troops.GhoulHIGH.TitleList <- ::Const.Strings.PH_GhoulTitles;

//Snakes
::Const.World.Spawn.Troops.Serpent.Variant = 1;
::Const.World.Spawn.Troops.Serpent.NameList <- ::Const.Strings.PH_SnakeNames;
::Const.World.Spawn.Troops.Serpent.TitleList <- null;

//Unholds -- come in many varieties, we only want wild champions!
::Const.World.Spawn.Troops.Unhold.Variant = 3;
::Const.World.Spawn.Troops.Unhold.NameList <- ::Const.Strings.PH_GiantNames;
::Const.World.Spawn.Troops.Unhold.TitleList <- null;
::Const.World.Spawn.Troops.UnholdBog.Variant = 5;
::Const.World.Spawn.Troops.UnholdBog.NameList <- ::Const.Strings.PH_GiantNames;
::Const.World.Spawn.Troops.UnholdBog.TitleList <- null;
::Const.World.Spawn.Troops.UnholdFrost.Variant = 3;
::Const.World.Spawn.Troops.UnholdFrost.NameList <- ::Const.Strings.PH_GiantNames;
::Const.World.Spawn.Troops.UnholdFrost.TitleList <- null;

//Schrat
::Const.World.Spawn.Troops.Schrat.Variant = 2;
::Const.World.Spawn.Troops.Schrat.NameList <- ::Const.Strings.PH_TreeNames;
::Const.World.Spawn.Troops.Schrat.TitleList <- null;

//Lindwurm
::Const.World.Spawn.Troops.Lindwurm.Variant = 5;
::Const.World.Spawn.Troops.Lindwurm.NameList <- ::Const.Strings.PH_LindwurmNames;
::Const.World.Spawn.Troops.Lindwurm.TitleList <- null;