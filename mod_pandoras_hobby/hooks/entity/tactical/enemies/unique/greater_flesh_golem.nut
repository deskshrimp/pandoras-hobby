::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/greater_flesh_golem", function(q) {
    
    //Just adding the incomplete potion drop
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_3))
        {
            if( ::World.Flags.get("PH_GreaterGolem_Drop") == false )
            {
                ::World.Flags.set("PH_GreaterGolem_Drop", true);
                ret.push(::new("scripts/items/misc/anatomist/pandora/ph_inc_greater_flesh_golem_potion_item"));
            }
        }

		return ret;
    }
});