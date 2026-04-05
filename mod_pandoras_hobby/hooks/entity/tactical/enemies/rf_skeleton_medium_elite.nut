::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/rf_skeleton_medium_elite", function(q) {	// Ancient Palatinus
	
    //HD makes this skele a champion
    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {                
                ret.push(::new("scripts/items/misc/ph_skele_clavicle_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "skeleton_warrior", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
        }

        return ret;
    }
});
