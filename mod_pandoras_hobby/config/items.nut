//add a new proprty for the Banner (use a high number that is unlikely to collide with other mods)
::Const.Items.Property.PlayerBattleStandard <- 2097152;

//register our items!
//armor
::Const.Items.NamedArmors.push("armor/named/ph_named_adventurers_carapace");
::Const.Items.NamedSouthernArmors.push("armor/named/ph_named_adventurers_carapace");

//helmets
::Const.Items.NamedHelmets.push("helmets/named/ph_named_adventurers_headgear");
::Const.Items.NamedSouthernHelmets.push("helmets/named/ph_named_adventurers_headgear");

::Const.Items.PH_ReducedPotionDropRate <- 25;

::Const.Items.PH_AP_Type <-
[
    //Common
    [300, "wiederganger_potion"],
    [200, "webknecht_potion"],    
    [200, "direwolf_potion"],
    [200, "nachzehrer_potion"],    
    
    //Uncommon
    [150, "hyena_potion"],
    [150, "goblin_grunt_potion"],
    [150, "goblin_overseer_potion"],
    [150, "goblin_shaman_potion"],    
    [150, "geist_potion"],
    [150, "fallen_hero_potion"],
    [150, "orc_young_potion"],
    [150, "skeleton_warrior_potion"],
    
    //Rare
    [100, "alp_potion"],
    [70, "ancient_priest_potion"],
    [100, "hexe_potion"],
    [80, "honor_guard_potion"],
    [100, "necromancer_potion"],
    [100, "orc_warrior_potion"],    
    [100, "serpent_potion"],
    [100, "unhold_potion"],
    [50, "ifrit_potion"],
    [50, "lindwurm_potion"],
    [100, "necrosavant_potion"],
    [100, "orc_berserker_potion"],
    [100, "orc_warlord_potion"],
    [100, "schrat_potion"],    
    
    //Uniques
    [10, "lesser_flesh_golem_potion"],
    [1, "greater_flesh_golem_potion"],
    [1, "grand_diviner_potion"],    
    [1, "ijirok_potion"],
    [1, "kraken_potion"],
    [1, "lorekeeper_potion"],
    [1, "rachegeist_potion"],
    [1, "ph_conqueror_potion"],    
];