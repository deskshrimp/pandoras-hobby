this.ph_grisly_trophy_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.ph_grisly_trophy";
		this.m.Name = "Grisly Trophy Necklace";
		this.m.Description = "This necklace fashioned from trophies taken from a variety of foul champions is a declaration of war against all creatures that lurk in the dark.";
		this.m.SlotType = ::Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/ph_grisly_trophy_item.png";
		this.m.Sprite = "ph_grisly_trophy";
		this.m.Value = 1000;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.Legendary;
	}

	function getTooltip()
	{
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve"
		});

		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve at morale checks against fear, panic or mind control effects"
		});
		return result;
	}

	function getSellPriceMult()
	{
		return ::World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return ::World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		_properties.Bravery += 10;
		_properties.MoraleCheckBravery[1] += 20;
	}

});