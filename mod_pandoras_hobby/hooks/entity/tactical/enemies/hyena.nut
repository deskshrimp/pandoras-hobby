::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/hyena", function(q) {
    
    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        //buff base stats
        local baseProperties = this.m.BaseProperties;
        baseProperties.Hitpoints += 30;
	    baseProperties.Bravery += 20;
        baseProperties.DamageArmorMult += 0.3; //+30% armor dmg

        //Add skills
        if (this.getSkills().hasSkill("perk.overwhelm"))
			this.getSkills().add(::new("scripts/skills/perks/perk_fearsome"));
		else
			this.getSkills().add(::new("scripts/skills/perks/perk_overwhelm"));        

        return true;
    }
    
    q.getLootForTile = @(__original) function( _killer, _loot )
    {
        local ret = __original(_killer, _loot);
        
        if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)        
        {
            if(this.m.IsMiniboss)
            {
                //unique loot
                local item = ::new("scripts/items/misc/ph_hyena_gland_item");
                item.setVariant(101);
                ret.push(item);

                //and some regular loot
                ret.push(::new("scripts/items/misc/hyena_fur_item"));
                ret.push(::new("scripts/items/misc/acidic_saliva_item"));
                if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/misc/acidic_saliva_item"));
                ret.push(::new("scripts/items/loot/sabertooth_item"));
                ret.push(::new("scripts/items/supplies/strange_meat_item"));


                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "hyena", ::Const.Items.PH_ReducedPotionDropRate );
                }
                else
                {
                    ret.push(::new("scripts/items/loot/sabertooth_item"));
                }
            }
        }

        return ret;
    }
});
