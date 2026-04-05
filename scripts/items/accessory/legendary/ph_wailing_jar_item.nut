this.ph_wailing_jar_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.ph_wailing_jar";
		this.m.Name = "Wailing Jar";
		this.m.Description = "Experiment #1537: While all attempts to harness the energies and knowledge trapped in ectoplasm were ostensibly failures, placing the resulting liquid in a vial with this ingenious stopper creates a rather startling result when shaken.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false; //no sprite set
		this.m.IconLarge = "";
		this.m.Icon = "accessory/ph_screaming_potion.png";
		this.m.Sprite = "";
		this.m.Value = 1000;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
		this.m.StaminaModifier = -4;
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
			text = "Releases a geistly wail when shaken!"
		});
		return result;
	}

    function onEquip()
	{
		this.accessory.onEquip();

        this.addSkill(::new("scripts/skills/actives/ph_wailing_jar_skill"));
	}
});

