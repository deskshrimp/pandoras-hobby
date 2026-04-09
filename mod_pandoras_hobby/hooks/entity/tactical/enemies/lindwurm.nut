::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/lindwurm", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
        
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 100;
        baseProperties.Initiative += 20;
        
        //add some snake-y perks
        this.getSkills().add(::new("scripts/skills/perks/perk_anticipation"));
        this.getSkills().add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));

        return true;
    }
        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_wurm_scales_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "lindwurm", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
		}

		return ret;
    }
});