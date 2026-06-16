::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/ghoul", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //Hardened removes and overwrites the reforged perks using the grow method so we need to be mindful about what we add here        
        if(this.getSize() == 3){
            //perks to make him thrash morale
            this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		    this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
        }
        else
        {
            this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
        }

        return true;
    }
        
    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {                
                ret.push(::new("scripts/items/misc/ph_ghoul_brain_item"));

                if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/misc/ph_ghoul_guts_item"));
                
                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "nachzehrer", ::Const.Items.PH_ReducedPotionDropRate );
                }
            }
		}

		return ret;
    }
});