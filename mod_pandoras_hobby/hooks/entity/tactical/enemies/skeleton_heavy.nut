::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/skeleton_heavy", function(q) {	// Ancient Honor Guard

    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {                
                ret.push(::new("scripts/items/misc/ph_skele_sternum_item"));                

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "honor_guard", ::Const.Items.PH_ReducedPotionDropRate );                    

                    //if they aren't using HD mod, then also drop the skele warrior items!
                    if (! ::Hooks.hasMod("mod_hardened") )
                    {
                        ret.push(::new("scripts/items/misc/ph_skele_clavicle_item"));
                        this.PH_AttemptIncompletePotionDrop( ret, "skeleton_warrior", ::Const.Items.PH_ReducedPotionDropRate );
                    }
                }
            }
        }

        return ret;
    }
});
