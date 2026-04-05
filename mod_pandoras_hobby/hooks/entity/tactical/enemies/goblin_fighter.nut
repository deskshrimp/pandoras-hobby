::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/goblin_fighter", function(q) {
    
    //just add the potion drops to the goblin champions
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_goblin_champ_ear_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "goblin_grunt", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
		}

		return ret;
    }
});