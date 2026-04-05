this.ph_keener_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		CurrentLevel = 1,
		BonusAttribs = [],
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ph_keener_trait";
		this.m.Name = "Keener";
		this.m.Icon = "ui/traits/ph_trait_icon_keener.png";
		this.m.Description = "This character is dedicated to doing their best, whether its work or training, they are always putting in extra hours to hone their skills.";
		this.m.Titles = [
			"the Keener",
			"the Tryhard",
			"the Tireless",
		];
		this.m.Excluded = [
			"trait.paranoid",
			"trait.insecure",
			"trait.hesitant",
			"trait.dastard",
			"trait.pessimist",
		];

		this.m.BonusAttribs.resize(::Const.Attributes.COUNT, 0);
	}

	function onUpdate( _properties )
	{
		//check for changes
		this.ph_UpdateSkillEffects();

		//apply bonuses!
		_properties.Hitpoints += this.m.BonusAttribs[::Const.Attributes.Hitpoints];
		_properties.Bravery += this.m.BonusAttribs[::Const.Attributes.Bravery];
		_properties.Stamina += this.m.BonusAttribs[::Const.Attributes.Fatigue];
		_properties.Initiative += this.m.BonusAttribs[::Const.Attributes.Initiative];
		_properties.MeleeSkill += this.m.BonusAttribs[::Const.Attributes.MeleeSkill];
		_properties.RangedSkill += this.m.BonusAttribs[::Const.Attributes.RangedSkill];
		_properties.MeleeDefense += this.m.BonusAttribs[::Const.Attributes.MeleeDefense];
		_properties.RangedDefense += this.m.BonusAttribs[::Const.Attributes.RangedDefense];
	}

	function ph_UpdateSkillEffects()
	{
		local actor = this.getContainer().getActor();
        if( actor == null || actor.isNull() ) return;

		while(actor.getLevel() > this.m.CurrentLevel)
		{
			local failChance = (this.m.CurrentLevel == 1) ? 0 : this.m.CurrentLevel*10;
			this.ph_RollForBonusStats(failChance);
			this.m.CurrentLevel++;
		}
	}

	function ph_RollForBonusStats(_dudWeight)
	{
		local weights = [];
		weights.resize(::Const.Attributes.COUNT, 0);
		weights[::Const.Attributes.Hitpoints]	= 20;
		weights[::Const.Attributes.Bravery] 	= 20;
		weights[::Const.Attributes.Fatigue] 	= 20;
		weights[::Const.Attributes.Initiative] 	= 27;
		weights[::Const.Attributes.MeleeSkill] 	= 10;
		weights[::Const.Attributes.RangedSkill] = 10;
		weights[::Const.Attributes.MeleeDefense] = 10;
		weights[::Const.Attributes.RangedDefense] = 15;		

		local totalWeight = _dudWeight;
		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			totalWeight += weights[i];
		}

		local roll = ::Math.rand(0, totalWeight);
		local w = 0;
		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			if( roll < (weights[i] + w) )
			{
				//::logInfo("KEENER -> gained " + i);
				
				this.m.BonusAttribs[i] += 1;

				return; //one stat only!
			}
			w += weights[i];
		}

		//::logInfo("KEENER -> gained spirit!");
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			           
		];

		local attribIcons = [
			"health",
			"bravery",
			"fatigue",
			"initiative",
			"melee_skill",
			"ranged_skill",
			"melee_defense",
			"ranged_defense"
		];
		local attribText = [
			"Hitpoints",
			"Resolve",
			"Max Fatigue",
			"Initiative",
			"Melee Skill",
			"Ranged Skill",
			"Melee Defense",
			"Ranged Defense"
		];
		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			if(this.m.BonusAttribs[i] > 0)	
			{
				ret.push({
					id = 10 + i,
					type = "text",
					icon = "ui/icons/" + attribIcons[i] + ".png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.BonusAttribs[i] + "[/color] " + attribText[i]
					
				});
			}
		}

		if(this.m.CurrentLevel == 1)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Today\'s Gains: Spirit!"
			});
		}

		return ret;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);

		_out.writeU8(this.m.CurrentLevel);		

		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			_out.writeU8(this.m.BonusAttribs[i]);
		}
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		
		this.m.CurrentLevel = _in.readU8();		

		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			this.m.BonusAttribs[i] = _in.readU8();
		}
	}
});

