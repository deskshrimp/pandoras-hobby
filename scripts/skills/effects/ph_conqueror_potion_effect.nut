this.ph_conqueror_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ph_conqueror_potion";
		this.m.Name = "Skulltaker's Focus";
		this.m.Icon = "skills/ph_potion_conq_effect.png";
		this.m.IconMini = "";
		this.m.Overlay = "ph_potion_conq_effect";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "This character is driven by an irresitable urge to collect the skulls of the slain. Their aim drifts against their will and their strikes lead to an unnatural amount of decapitations.";
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
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "+9% chance to hit the head."
			},
            {
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "+31% chance to decapitate with any weapon."
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += 9;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
			{
				::World.Statistics.getFlags().set("isConquerorPotionAcquired", false);
			}
		}
	}

	function onDismiss()
	{
		if( this.getContainer().getActor().getFlags().getAsInt(this.m.ID) == 0 )
		{
			::World.Statistics.getFlags().set("isPHConquerorPotionAcquired", false);
		}
	}

});

