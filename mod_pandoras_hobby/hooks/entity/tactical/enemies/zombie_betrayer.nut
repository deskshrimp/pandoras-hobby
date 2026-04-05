::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/zombie_betrayer", function(q) {

    //just add our new drops and go
    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {
                //unique loot
                ret.push(::new("scripts/items/misc/ph_zombie_ring_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "fallen_hero", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
        }

        return ret;
    }
});