this.ph_champ_bone_plating_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {
        MaxUses = 2,
		UsesRemaining = 2,
	},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.ph_champ_bone_plating";
		this.m.Name = "Heavy Bone Plating";
		this.m.Description = "Crafted from surprisingly strong bones, these dense platings make for an ablative armor to be worn ontop of regular armor.";
		this.m.ArmorDescription = "A layer of heavy bone plates is attached to this armor.";
		this.m.Icon = "armor_upgrades/ph_upgrade_06.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/ph_icon_upgrade_06.png";
		this.m.OverlayIconLarge = "armor_upgrades/ph_inventory_upgrade_06.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "ph_upgrade_06_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "ph_upgrade_06_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "ph_upgrade_06_back_dead";
		this.m.StaminaModifier = 6;
		this.m.Value = 1500;
        this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Completely absorbs the first two hits of every combat encounter which doesn\'t ignore armor"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Maximum Fatigue"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Completely absorbs the first two hits of every combat encounter which doesn\'t ignore armor"
		});
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.UsesRemaining == 0)
		{
			return;
		}

		if (_hitInfo.BodyPart == this.Const.BodyPart.Body && _hitInfo.DamageDirect < 1.0)
		{
			this.m.UsesRemaining--;
			_properties.DamageReceivedTotalMult = 0.0;
		}
	}

	function onCombatFinished()
	{
		this.m.UsesRemaining = this.m.MaxUses;
	}

});

