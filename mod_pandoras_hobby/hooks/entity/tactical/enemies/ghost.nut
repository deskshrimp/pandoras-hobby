::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/ghost", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //buff base stats
        local baseProperties = this.m.BaseProperties;
        baseProperties.IsImmuneToZoneOfControl = true;
        baseProperties.IsImmuneToDamageReflection = true;
        baseProperties.MeleeSkill += 10;        
        baseProperties.ActionPoints += 1;

        //add new skills        
        this.getSkills().add(::new("scripts/skills/ph_champs/ethereal"));
        this.getSkills().add(::new("scripts/skills/ph_champs/chilling_aura"));
        
        //Remove old skills
        this.getSkills().removeByID("actives.ghastly_touch");
        this.getSkills().removeByID("actives.horrific_scream");
        
        //add champion skill versions
        this.getSkills().add(::new("scripts/skills/ph_champs/ph_champ_ghastly_touch"));
        this.getSkills().add(::new("scripts/skills/ph_champs/ph_champ_horrific_scream"));

        //Update AI Details
        this.m.AIAgent.m.Properties.EngageRangeMin = 1;
		this.m.AIAgent.m.Properties.EngageRangeMax = 2;
		this.m.AIAgent.m.Properties.EngageRangeIdeal = 1;

        this.m.AIAgent.getBehavior(::Const.AI.Behavior.ID.AttackDefault).m.PossibleSkills.push("actives.ph_champ_ghastly_touch");
        this.m.AIAgent.getBehavior(::Const.AI.Behavior.ID.Terror).m.PossibleSkills.push("actives.ph_champ_horrific_scream");

        return true;
    }

    q.getLootForTile = @(__original) function ( _killer, _loot )
    {
        local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{			
            if(this.m.IsMiniboss)
            {
                //unique loot
                ret.push(::new("scripts/items/misc/ph_ghost_blood_item"));

                //and some regular loot
                ret.push(::new("scripts/items/loot/rf_geist_tear_item"));
                if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/loot/rf_geist_tear_item"));
                if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/loot/rf_geist_tear_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "geist", ::Const.Items.PH_ReducedPotionDropRate );
                }
                else
                {
                    ret.push(::new("scripts/items/loot/rf_geist_tear_item"));
                }
            }
		}

		return ret;
    }
});