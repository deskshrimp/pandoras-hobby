this.ph_toothed_throwing_net <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "tool.ph_toothed_throwing_net";
		this.m.Name = "Toothed Throwing Net";
		this.m.Description = "Fish\'s devilish invention. A net strengthened with webknecht silk and studded with Nachzehrer teeth. Damned difficult to escape from.";
		this.m.IconLarge = "tools/ph_inventory_throwing_net_03.png";
		this.m.Icon = "tools/ph_throwing_net_03_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Tool | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "ph_icon_throwing_net_03";
		this.m.Value = 150;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = -10;
		this.m.IsDroppedAsLoot = true;
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
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.RangeMax + "[/color] tiles"
		});

		if (this.m.StaminaModifier < 0)
		{
			result.push({
				id = 8,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Maximum Fatigue [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
			});
		}

		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Will root a target in place and reduce their defenses"
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Is destroyed on use"
		});
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Chance to break free is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]-22[/color]"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/throw_net");
		skill.PH_setToothed(true);
		this.addSkill(skill);
	}

});