this.ph_ancient_necro_ammy_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.ph_ancient_necro_ammy";
		this.m.Name = "Ancient Necromancer's Talisman";
		this.m.Description = "Experiment #1909: A most curious reaction was discovered when the skull was filled with a mixture of powdered ancient bones and the hair of an especially powerful warlock. As of yet we have found no means of controlling or inhibiting the reaction, but the current results are exceptionally promising.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false; //no sprite set
		this.m.IconLarge = "";
		this.m.Icon = "accessory/ph_ancient_necromancer_trophy.png";
		this.m.Sprite = "ph_ancient_necro_trophy";
		this.m.Value = 1000;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
		this.m.StaminaModifier = -2;
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
			id = 64,
			type = "text",
		    text = "Worn in Accessory Slot"
		});

		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Periodically raises Ancient Dead (" + ::MSU.Text.colorPositive("friendly ones") + ")."
		});
		return result;
	}

    function onEquip()
	{
		this.accessory.onEquip();

        this.addSkill(::new("scripts/skills/special/ph_necro_ammy_effect"));
	}
});

