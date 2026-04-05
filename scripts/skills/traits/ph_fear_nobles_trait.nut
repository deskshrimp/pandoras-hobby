this.ph_fear_nobles_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ph_fear_nobles";
		this.m.Name = "Fear of Nobles";
		this.m.Icon = "ui/traits/ph_fear_nobles.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left him scared of the nobility, making him less reliable when facing them on the battlefield.";		
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.ph_hate_nobles"
		];
	}

	function getTooltip()
	{
		return [
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
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Resolve when in battle with the forces of Noble Houses or City States."
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local fightingNobles = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.NobleHouse || this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.OrientalCityState)
			{
				fightingNobles = true;
				break;
			}
		}

		if (fightingNobles)
		{
			_properties.Bravery -= 10;
		}
	}

});

