this.ph_hate_nobles_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ph_hate_nobles";
		this.m.Name = "Hate for Nobles";
		this.m.Icon = "ui/traits/ph_hate_nobles.png";
		this.m.Description = "Some past event in this character\'s life has fueled a burning hatred for everything and anything to do with the Nobility.";
		this.m.Titles = [
			"Kingslayer",
			"Proletariat"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.craven",
			"trait.dastard",
			"trait.fainthearted",
			"trait.ph_fear_nobles"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve when in battle with the forces of Noble Houses or City States."
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
			_properties.Bravery += 10;
		}
	}

});

