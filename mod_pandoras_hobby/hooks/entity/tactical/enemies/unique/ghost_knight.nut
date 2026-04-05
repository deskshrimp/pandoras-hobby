::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/ghost_knight", function(q) { //Rachegeist
    
    //Just adding the incomplete potion drop
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_3))
        {
            if( ::World.Flags.get("PH_Ghost_Knight_Drop") == false )
            {
                ::World.Flags.set("PH_Ghost_Knight_Drop", true);
                ret.push(::new("scripts/items/misc/anatomist/pandora/ph_inc_rachegeist_potion_item"));
            }            
        }

		return ret;
    }
});