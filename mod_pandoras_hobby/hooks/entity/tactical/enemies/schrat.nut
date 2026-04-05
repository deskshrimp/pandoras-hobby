::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/schrat", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //Boost their hitpoints & reduce init (he is a big old slow tree)
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 200;
        baseProperties.Initiative -= 20;
        
        //some extra perks that feel on theme for the ent army
        this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_strength_in_numbers"));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));

        return true;
    }

    //only the base class needs to handle the extra drops        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_schrat_sprouts_item"));
                
                //guarantee some valuables drop at least
                ret.push(::new("scripts/items/loot/ancient_amber_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "schrat", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
		}

		return ret;
    }
});