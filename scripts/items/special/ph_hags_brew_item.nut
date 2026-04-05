this.ph_hags_brew_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
        this.item.create();
		this.m.ID = "accessory.ph_hags_brew";
		this.m.Name = "Hag's Brew";
		this.m.Description = "A swamp witch's cure for common sickness. After you finish wretching you won't feel sick anymore. Sometimes the cure is poison, afterall.";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/ph_hags_tea.png";
		this.m.Value = 100;
	}

	function getTooltip()
	{
        local result = this.item.getTooltip();

		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		
		result.push({
			id = 11,
			type = "text",
			icon = "ui/tooltips/positive.png",
			text = ::MSU.Text.colorPositive("Cures or Treats Sickness")
		});

        result.push({
			id = 12,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = ::MSU.Text.colorNegative("Caution: Will inflict damage, and may inflict injury, sometimes but rarely permanent.")
		});

        result.push({
			id = 11,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "Perks & Traits such as " + ::Const.Strings.PerkName.HoldOut + ", " + ::Const.Strings.PerkName.NineLives + ", Tough, and Survivor generally improve patient outcomes." 
		});

		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		//are they sick?
        if (!_actor.getSkills().hasSkill("injury.sickness"))
		{
			return false;
		}

		this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
		
		//grab the skill
		local sick = _actor.getSkills().getSkillByID("injury.sickness");
		local healTime = sick.getHealingTime();
        
        //we will be doing damage to their hitpoints
        local minDamage = ::Math.max(10, ::Math.floor(healTime.Min * 1.5));
		local maxDamage = ::Math.max(20, ::Math.floor(healTime.Max * 2));

        //Cure or Treat the sickness
        if( !sick.isTreated() && ::Math.rand(0,100) < 50 )
        { //Treat
            sick.setTreated(true);
            maxDamage = ::Math.floor(maxDamage * 0.6);  //only 60% of possible dmg
        }
        else
        {
            //remove sickness
            _actor.getSkills().removeByID("injury.sickness");
        }

        //apply Tough and Resiliant dmg reductions
        if (_actor.getSkills().hasSkill("trait.tough")) maxDamage = ::Math.floor(maxDamage * 0.9);
		if (_actor.getSkills().hasSkill("perk.hold_out")) maxDamage = ::Math.floor(maxDamage * 0.9);

        if(minDamage >= maxDamage){ minDamage = maxDamage - 1; }

        local damage = ::Math.rand(minDamage, maxDamage);

        if( _actor.getHitpoints() > damage)
        {
            _actor.setHitpoints(_actor.getHitpoints()-damage);

            //small chance of temp injury based on % dmg done
            this.inflictTempInjury( _actor, ::Math.floor(damage / _actor.getHitpointsMax() * 100.0 * 0.5) );
        }
        else
        {
            //they do not have enough hitpoints!
            local overkill = damage - _actor.getHitpoints();

            _actor.setHitpoints(1);

            //inflict possible injuries
            //Temp: burnt lungs, broken ribs, burnt face/hands/leg, crushed windpipe, stabbed guts, concussion
            //Perm: brain damage, weakened heart, traumatized

            //Attempt Permanent Injury            
            if(this.inflictPermanentInjury(_actor, overkill)) return true;

            //Attempt Temp Injury
            do
            {
                if(this.inflictTempInjury(_actor, overkill * 10)) overkill -= 15;
                overkill -= 10;
            } while (overkill > 0);
        }

		return true;
	}

    function inflictPermanentInjury(_actor, _odds)
    {
        //Survivor (-20% to perm injury odds)
        if (_actor.getSkills().hasSkill("trait.survivor")) _odds = ::Math.floor(_odds * 0.8);

        //Nine Lives (-10% to perm injury odds)
        if (_actor.getSkills().hasSkill("perk.nine_lives"))  _odds = ::Math.floor(_odds * 0.9);
        
        if(::Math.rand(1,100) > _odds){ return false; }

        
        //Perm: brain damage, weakened heart, traumatized
        local val = ::Math.rand(0,100);
        if(val < 50)
        {
            if (!_actor.getSkills().hasSkill("injury.brain_damage"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury_permanent/brain_damage_injury"));
                return true;
            }
        }
        else if(val < 80)
        {
            if (!_actor.getSkills().hasSkill("injury.weakened_heart"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury_permanent/weakened_heart_injury"));
                return true;
            }
        }
        else
        {
            if (!_actor.getSkills().hasSkill("injury.traumatized"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury_permanent/traumatized_injury"));
                return true;
            }
        }

        return false;
    }

    function inflictTempInjury(_actor, _odds)
    {
        //Nine Lives (-10% to temp injury odds)
        if (_actor.getSkills().hasSkill("perk.nine_lives"))  _odds = ::Math.floor(_odds * 0.9);

        if(::Math.rand(1,100) > _odds){ return false; }


        //Temp: burnt lungs, broken ribs, burnt face, burnt hands, crushed windpipe, stabbed guts, concussion
        local val = ::Math.rand(0,100);
        if(val < 30)
        {
            if (!_actor.getSkills().hasSkill("injury.inhaled_flames"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/inhaled_flames_injury"));
                return true;
            }
        }
        else if(val < 40)
        {
            if (!_actor.getSkills().hasSkill("injury.burnt_face"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/burnt_face_injury"));
                return true;
            }
        }
        else if(val < 50)
        {
            if (!_actor.getSkills().hasSkill("injury.broken_ribs"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/broken_ribs_injury"));
                return true;
            }   
        }
        else if(val < 60)
        {
            if (!_actor.getSkills().hasSkill("injury.burnt_hands"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/burnt_hands_injury"));
                return true;
            }
        }
        else if(val < 70)
        {
            if (!_actor.getSkills().hasSkill("injury.crushed_windpipe"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/crushed_windpipe_injury"));
                return true;
            }
        }
        else if(val < 80)
        {
            if (!_actor.getSkills().hasSkill("injury.stabbed_guts"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/stabbed_guts_injury"));
                return true;
            }
        }
        else
        {
            if (!_actor.getSkills().hasSkill("injury.severe_concussion"))
            {            
                _actor.getSkills().add(::new("scripts/skills/injury/severe_concussion_injury"));
                return true;
            }
        }

        return false;
    }
});

