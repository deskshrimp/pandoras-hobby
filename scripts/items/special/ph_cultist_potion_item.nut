this.ph_cultist_potion_item <- this.inherit("scripts/items/item", {
	m = 
    {
        Effect = "",
        Tier = 0,
    },
	function create()
	{	 
        this.item.create();       
		this.m.Description = "A curious and devilish concoction. Its ingredients include the blood of one of our Brothers. Through imbibing this foul drink one may place themselves on the path to Davkul.";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = false;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.IconLarge = "";
		this.m.Value = 0;
	}

	function getTooltip()
	{
        local result = this.item.getTooltip();		

		result.push({
			id = 11,
			type = "text",
			icon = "ui/tooltips/positive.png",
			text = this.m.Effect
		});

        result.push({
			id = 12,
			type = "text",
			icon = "ui/tooltips/negative.png",
			text = ::MSU.Text.colorNegative("May inflict ") + "Dumb and/or Brain Damage."
		});

        result.push({
			id = 13,
			type = "text",
			icon = "ui/tooltips/negative.png",
			text = "Caution: Cannot be combined with other divine elixirs."
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
		this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);

        if( _actor.getSkills().hasSkill("effects.ph_barb_king_potion") )
        {
            //give them a crisis of faith! (permanent injury)
			_actor.getSkills().add("scripts/skills/injury_permanent/ph_faith_crisis");
        }
		
        if ( _actor.getSkills().hasSkill("trait.bright") )
        {
            //Bright must have brain damage!
            this.inflictBrainDamage(_actor);

            if(::Math.rand(0,100) < 15)
            {
                _actor.getSkills().removeByID("trait.bright");
            }
        }
        else if ( _actor.getBackground().isNoble() )
        {
            //Nobles must be dumb or brain damaged!
            this.inflictDeficiency(_actor,50,50,0);
        }
        else if( !_actor.getBackground().isLowborn() )
        {
            //Cultists are low | noble-dumb | brained, nothing else is normally allowed
            //inflict at least one deficiency
            this.inflictDeficiency(_actor,40,60,0);
        }
        else
        {
            //the potion is still dangerous
            this.inflictDeficiency(_actor,25,15,60);
        }

        //Check for sickness and increment the potion counter (shares with Anatomist & Barbarian).
        this.inflictSickness(_actor);

        _actor.updateInjuryVisuals();

		return true;
	}

    function canBecomeCultist(_actor)
    {
        if( _actor().PH_isCultist() ) return false;
        
        if (_actor.getFlags().get("IsSpecial") || _actor.getFlags().get("IsPlayerCharacter") || _actor.getBackground().getID() == "background.slave") return false;

        return true;
    }

    function getCultistTier(_actor)
    {
        if (_actor.getSkills().hasSkill("trait.cultist_prophet")) return 6;
		if (_actor.getSkills().hasSkill("trait.cultist_chosen")) return 5;
		if (_actor.getSkills().hasSkill("trait.cultist_disciple")) return 4;
		if (_actor.getSkills().hasSkill("trait.cultist_acolyte")) return 3;
		if (_actor.getSkills().hasSkill("trait.cultist_zealot")) return 2;
		if (_actor.getSkills().hasSkill("trait.cultist_fanatic")) return 1;

        if( _actor().PH_isCultist() ) return 0;

        return -1;
    }

    function inflictDeficiency(_actor, _dumbWeight, _brainWeight, _noWeight)
    {
        //reduce the odds for those already afflicted!
        if(_actor.getSkills().hasSkill("trait.dumb")) _noWeight += 500;
        if(_actor.getSkills().hasSkill("injury.brain_damage")) _noWeight += 500;

        local totalWeight = _dumbWeight + _brainWeight + _noWeight;
        local val = ::Math.rand(0, totalWeight);
        if(val < _dumbWeight) { return this.inflictDumb(_actor); }
        if(val < _dumbWeight + _brainWeight) { return this.inflictBrainDamage(_actor); }
    }

    function inflictDumb(_actor)
    {
        if(_actor.getSkills().hasSkill("trait.dumb")) return;

        _actor.getSkills().add(::new("scripts/skills/traits/dumb_trait"));
    }

    function inflictBrainDamage(_actor)
    {
        if(_actor.getSkills().hasSkill("injury.brain_damage")) return;

        _actor.getSkills().add(::new("scripts/skills/injury_permanent/brain_damage_injury"));
    }

    function inflictSickness(_actor)
    {
        //Check for sickness and increment the potion counter (shares with Anatomist & Barbarian).

        if(_actor.getFlags().getAsInt("ActiveMutations") > this.m.Tier)
        {
            //they are mixing potions! punish them with illness
            if (_actor.getSkills().hasSkill("injury.sickness"))
		    {
			    _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(this.Math.rand(1, 3));
		    }
		    else
		    {
			    _actor.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
		    }

		    _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(_actor.getFlags().getAsInt("ActiveMutations"));
        }

        //increment the mutation counter (so anatomist pots will be penalized if used)
        _actor.getFlags().increment("ActiveMutations");

        local time = 0.0;
        if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

        _actor.getFlags().set("PotionLastUsed", time);
		_actor.getFlags().increment("PotionsUsed");
    }
});