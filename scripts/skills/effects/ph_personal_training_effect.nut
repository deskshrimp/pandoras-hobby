this.ph_personal_training_effect <- this.inherit("scripts/skills/skill", {
	m = 
    {
        BonusAttribs = [],
    },
	function create()
	{
		this.m.ID = "effects.ph_personal_training";
		this.m.Name = "Extra Training";
		this.m.Icon = "skills/status_effect_106.png";		
		this.m.Overlay = "status_effect_106";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsSerialized = true;

        this.m.BonusAttribs.resize(::Const.Attributes.COUNT, 0);
	}

	function getDescription()
	{
		return "Thanks to the extra time they spent with the drill instructor, this character feels especially ready for the next battle.";
	}

    function applyTrainingEffect(_num)
    {
        local count = 0;
        while(count < _num)
        {
            local index = ::Math.rand(0, ::Const.Attributes.COUNT-1);

            if(this.m.BonusAttribs[index] != 0) continue;

            if(index <= ::Const.Attributes.Initiative)
            {
                //HP, Init, Res, or Fat
                this.m.BonusAttribs[index] = ::Math.rand(3, 10);
            }
            else
            {
                //Melee & Ranged skill or def
                this.m.BonusAttribs[index] = ::Math.rand(2, 5);
            }

			count++;
        }
    }

	function onUpdate( _properties )
	{
		_properties.Hitpoints += this.m.BonusAttribs[::Const.Attributes.Hitpoints];
		_properties.Bravery += this.m.BonusAttribs[::Const.Attributes.Bravery];
		_properties.Stamina += this.m.BonusAttribs[::Const.Attributes.Fatigue];
		_properties.Initiative += this.m.BonusAttribs[::Const.Attributes.Initiative];
		_properties.MeleeSkill += this.m.BonusAttribs[::Const.Attributes.MeleeSkill];
		_properties.RangedSkill += this.m.BonusAttribs[::Const.Attributes.RangedSkill];
		_properties.MeleeDefense += this.m.BonusAttribs[::Const.Attributes.MeleeDefense];
		_properties.RangedDefense += this.m.BonusAttribs[::Const.Attributes.RangedDefense];
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
			}
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

		return ret;
	}

    function onSerialize( _out )
	{
		this.skill.onSerialize(_out);

		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			_out.writeU8(this.m.BonusAttribs[i]);
		}
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);

		for(local i = 0; i<::Const.Attributes.COUNT; i++)
		{
			this.m.BonusAttribs[i] = _in.readU8();
		}
	}
});