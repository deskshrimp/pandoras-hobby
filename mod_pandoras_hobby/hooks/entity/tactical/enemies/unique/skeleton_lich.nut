::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/skeleton_lich", function(q) { //The Lorekeeper
    
    //Just adding the incomplete potion drop
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_3))
        {
            if( ::World.Flags.get("PH_Lorekeeper_Drop") == false )
            {
                ::World.Flags.set("PH_Lorekeeper_Drop", true);
                ret.push(::new("scripts/items/misc/anatomist/pandora/ph_inc_lorekeeper_potion_item"));
            }
        }

		return ret;
    }
});