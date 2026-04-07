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
        baseProperties.Hitpoints += 200;
        
        if ( ::Hooks.hasMod("mod_hardened") )
        {
            this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_rattle", function(o) {
			    o.m.RequiredWeaponType = null;
		    }));
        }
        
        this.m.Skills.add(::new("scripts/skills/perks/perk_lone_wolf"));        
        
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
                local drops = null;
                if (this.isKindOf(this, "unhold_frost"))
                {
                    drops = ::MSU.Class.WeightedContainer([
                        [30, "misc/ph_unhold_liver_item"],
                        [70, "misc/ph_unhold_bones_item"],                        
                    ]);
                }
                else if (this.isKindOf(this, "unhold_bog"))
                {
                    drops = ::MSU.Class.WeightedContainer([
                        [70, "misc/ph_unhold_liver_item"],
                        [30, "misc/ph_unhold_bones_item"],                        
                    ]);
                }
                else    //regular Unhold
                {
                    drops = ::MSU.Class.WeightedContainer([
                        [30, "misc/ph_unhold_liver_item"],
                        [30, "misc/ph_unhold_bones_item"],
                        [30, "loot/deformed_valuables_item"],
                    ]);
                }                
                ret.push(::new("scripts/items/" + drops.roll() ));

                //always drop a heart
                ret.push(::new("scripts/items/misc/ph_unhold_heart_item"));
                
                //and some meat
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