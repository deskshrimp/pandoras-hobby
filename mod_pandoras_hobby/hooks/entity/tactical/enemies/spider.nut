::PandorasHobby.MH.hook("scripts/entity/tactical/enemies/spider", function(q) {

    q.makeMiniboss = @(__original) function()
    {
        if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

        local variant = 420 + ::Math.rand(0,2);
        this.getFlags().set("ph_variant", variant);

        local baseProperties = this.m.BaseProperties;
        baseProperties.Bravery += 20;

        this.getSprite("legs_back").setBrush("ph_bust_spider_legs_back_" + variant);
        this.getSprite("body").setBrush("ph_bust_spider_body_" + variant);
        this.getSprite("legs_front").setBrush("ph_bust_spider_legs_front_" + variant);
        this.getSprite("head").setBrush("ph_bust_spider_head_" + variant);

        //adjust settings & stats for each type
        if(variant == 420)
        {
            //bright green
            //deadly poison variant
            this.setSize(0.75);
                        
            baseProperties.MeleeSkill += 10;
            baseProperties.Hitpoints += 20;
            baseProperties.MeleeDefense += 10;
		    baseProperties.RangedDefense += 10;

            this.getSkills().add(::new("scripts/skills/ph_champs/ph_champ_venom"));
        }
        else if(variant == 421)
        {
            //dark red
            //big bitter
            this.setSize(1.0);

            baseProperties.ActionPoints -= 2;
            baseProperties.Hitpoints += 40;
            baseProperties.MeleeSkill += 15;
		    baseProperties.MeleeDefense -= 10;
		    baseProperties.RangedDefense -= 10;
		    baseProperties.DamageRegularMax += 15;

            this.getSkills().add(::new("scripts/skills/perks/perk_fearsome"));
            if ( ::Hooks.hasMod("mod_hardened") )
            {
                this.getSkills().add(::Reforged.new("scripts/skills/perks/perk_rf_between_the_ribs", function(o) {
			        o.m.RequiredWeaponType = null;
			        o.m.RequiredDamageType = null;
		        }));
            }
            
        }
        else if(variant == 422)
        {
            //blue-grey
            //light & speedy variant
            this.setSize(0.65);

            baseProperties.ActionPoints += 1;
            baseProperties.Hitpoints += 10;
            baseProperties.Initiative += 100;
            
            this.getSkills().add(::new("scripts/skills/effects/dodge_effect"));
            this.getSkills().add(::new("scripts/skills/perks/perk_nimble"));
        }

        //all get boosted hit rate (vanilla mod)
        this.getSkills().add(::new("scripts/skills/perks/perk_fast_adaption"));
        
        this.setDirty(true); //needs to update its image!
                
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
                local variant = this.getFlags().getAsInt("ph_variant");
                if(variant == 420)
                {
                    //bright green //deadly poison variant
                    ret.push(::new("scripts/items/misc/ph_spider_eyes_item"));
                    if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/misc/ph_spider_gland_item"))
                }
                else if(variant == 421)
                {
                    //dark red //big bitter
                    ret.push(::new("scripts/items/misc/ph_spider_eyes_item"));
                    if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/misc/ph_spider_silk_item"));
                }
                else if(variant == 422)
                {
                    //blue-grey //light & speedy variant
                    ret.push(::new("scripts/items/misc/ph_spider_silk_item"));
                    if(::Math.rand(0,100) < 50) ret.push(::new("scripts/items/misc/ph_spider_silk_item"));
                }                

                //and some regular loot
                local roll = ::Math.rand(0,100);
                if(roll < 33)
                {
                    ret.push(::new("scripts/items/misc/spider_silk_item"));
                }
                else if(roll < 66)
                {
                    ret.push(::new("scripts/items/misc/poison_gland_item"));
                }
                else
                {                    
                    ret.push(::new("scripts/items/loot/webbed_valuables_item"));
                }

                if(::World.Retinue.PH_HasFollowerTypeWithSkill(::PandorasHobby.Follower.Archetype.Healer, ::PandorasHobby.Follower.Skill.Alch_Anatomist_1))
                {
                    this.PH_AttemptIncompletePotionDrop( ret, "webknecht", ::Const.Items.PH_ReducedPotionDropRate );                    
                }
                else
                {
                    ret.push(::new("scripts/items/loot/webbed_valuables_item"));
                }
            }
        }

        return ret;
    }
});