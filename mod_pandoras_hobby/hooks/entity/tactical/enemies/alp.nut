::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/alp", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //some simple boosts to make them even more annoying
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 30;
        
        //+20% dmg vs sleeping!
        this.getSkills().add(::new("scripts/skills/perks/perk_coup_de_grace"));

        return true;
    }
        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                ret.push(::new("scripts/items/misc/ph_alp_eye_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {                    
                    this.PH_AttemptIncompletePotionDrop( ret, "alp", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
            }
		}

		return ret;
    }
});