::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/vampire", function(q) {
    

    //only rf_vampire_lord has a champion atm, but hooking the base class should get future additions as webbed_valuables_item

    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {
                //unique loot
                ret.push(::new("scripts/items/misc/ph_vamp_skull_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "necrosavant", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
        }

        return ret;
    }
});