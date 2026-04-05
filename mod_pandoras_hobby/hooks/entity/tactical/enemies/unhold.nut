::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/unhold", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //Boost their hitpoints
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 100;
        
        //give back the vanilla perks
        this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));		
        this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));

        //bonus perk -- they should worry with a giant looming over them!
        this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));

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
                ret.push(::new("scripts/items/misc/ph_unhold_liver_item"));
                
                //guarantee some valuables drop at least
                ret.push(::new("scripts/items/loot/deformed_valuables_item"));
                ret.push(::new("scripts/items/supplies/strange_meat_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "unhold", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
		}

		return ret;
    }
});