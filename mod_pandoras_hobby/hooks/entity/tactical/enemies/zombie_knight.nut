::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/zombie_knight", function(q) {


    q.makeMiniboss = @(__original) function()
    {
        //we are going to overwrite the original, to keeps things more inline with the HD changes
        //if( !__original() ) return false;

        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		
        //named shields only
		local shields = clone ::Const.Items.NamedUndeadShields;
        this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
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
                ret.push(::new("scripts/items/misc/ph_zombie_blood_item"));

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "wiederganger", ::Const.Items.PH_ReducedPotionDropRate );
                    
                    //without HD mod, this is the only real zombie champion to drop loot!
                    if (! ::Hooks.hasMod("mod_hardened") && ::Math.rand(0,100) < 50)
                    {
                        ret.push(::new("scripts/items/misc/ph_zombie_ring_item"));
                        this.PH_AttemptIncompletePotionDrop( ret, "fallen_hero", ::Const.Items.PH_ReducedPotionDropRate );
                    }
                }
            }
        }

        return ret;
    }
});