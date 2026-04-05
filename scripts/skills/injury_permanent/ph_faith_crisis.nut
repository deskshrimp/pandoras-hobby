this.ph_faith_crisis <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "trait.ph_faith_crisis";
		this.m.Name = "Crisis of Faith";
		this.m.Icon = "skills/status_effect_107.png";
		this.m.Description = "This character is trapped in a personal crisis. Their faith is split between the Old Gods and Davkul. Does he wish to reforge the world in their honor or bask in the end of days?";		

		this.m.IsTreatable = false; //keep it permanent (fountain of youth can fix it, but that's it)		
		this.m.IsFresh = false;
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
				id = 7,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Resolve"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] Initiative"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Ranged Skill"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onApplyAppearance()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("eye_rings"))
		{
			actor.getSprite("eye_rings").Visible = true;
		}
	}

	function PH_removeVisuals()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("eye_rings"))
		{
			actor.getSprite("eye_rings").Visible = false;
		}
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 0.85;
        _properties.InitiativeMult *= 0.85;
		_properties.MeleeSkillMult *= 0.9;
		_properties.RangedSkillMult *= 0.9;
	}

});