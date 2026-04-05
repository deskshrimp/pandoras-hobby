::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/orc_warrior", function(q) {
    
    //just add the potion drops to the champions
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_orc_head_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    if(::Math.rand(0,100) < 60)
                    {
                        this.PH_AttemptIncompletePotionDrop( ret, "orc_warrior", ::Const.Items.PH_ReducedPotionDropRate );                        
                    }
                    else
                    {
                        this.PH_AttemptIncompletePotionDrop( ret, "orc_young", ::Const.Items.PH_ReducedPotionDropRate );                        
                    }
                }
            }
		}

		return ret;
    }
});