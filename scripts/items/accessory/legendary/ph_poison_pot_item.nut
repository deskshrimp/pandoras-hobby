this.ph_poison_pot_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.ph_poison_pot";
		this.m.Name = "\'Endless\' Poison Pot";
		this.m.Description = "Experiment #2416: Two parts verdant slime, one relatively full large webknecht gland, plus a slowing toxin to stabalize. The end result of this particular experiment is a pot of foul smelling poisonous sludge that does not lose it potency despite extended use and exposure to the elements.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false; //no sprite set
		this.m.IconLarge = "";
		this.m.Icon = "accessory/ph_poison_pot.png";
		this.m.Sprite = "";
		this.m.Value = 1000;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
		this.m.StaminaModifier = -8;
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
			text = "A pot of poison that can be used to coat your weapons. Be careful not to spill!"
		});
		
		result.push({
			id = 40,
			type = "hint",			
			text = "It really is endless."
		});
		
		return result;
	}

    function onEquip()
	{
		this.accessory.onEquip();

        this.addSkill(::new("scripts/skills/actives/ph_coat_with_spider_poison_skill"));

		//Note: might want to hook this to hide the skill while you have the coating active, but players may also want to reload before the effect has worn off.
	}
});