this.ph_named_direwolf_mantle_upgrade <- this.inherit("scripts/items/armor_upgrades/named/ph_named_armor_upgrade", {
	m = {		
	},
	function create()
	{
		this.ph_named_armor_upgrade.create();
		this.m.ID = "armor_upgrade.ph_named_direwolf_mantle";		
		this.m.Description = "Pelts taken from terrible albino direwolves, cured and sewn together to be worn as a beast hunter\'s trophy around the neck. Donning the skin of these beasts turns one into a terrifying figure.";
		this.m.ArmorDescription = "A mantle of albino direwolf pelts has been attached to this armor, which transforms the wearer into a terrifying figure.";
        this.m.NameList = ["Pelt Mantle"];
		this.m.CreatureNames = ::Const.Strings.PH_DirewolfNames;
		this.m.Icon = "armor_upgrades/ph_upgrade_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/ph_icon_upgrade_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/ph_inventory_upgrade_01.png";
		this.m.SpriteFront = "ph_upgrade_01_front";
		this.m.SpriteBack = "ph_upgrade_01_back";
		this.m.SpriteDamagedFront = "ph_upgrade_01_front_damaged";
		this.m.SpriteDamagedBack = "ph_upgrade_01_back";
		this.m.SpriteCorpseFront = "ph_upgrade_01_front_dead";
		this.m.SpriteCorpseBack = "ph_upgrade_01_back_dead";
		this.m.Value = 1000;

        this.m.ConditionModifier = 15;
		this.m.ConditionRollMin = 135;	//20
		this.m.ConditionRollMax = 200;	//30

		this.m.StaminaModifier = 0;

        this.m.SpecialModifier = 5;
		this.m.SpecialRollMin = 100; //5
		this.m.SpecialRollMax = 200; //10

		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ConditionModifier + "[/color] Durability"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.SpecialModifier + "[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]this.m.SpecialModifier[/color]"
		});
	}

	function onUpdateProperties( _properties )
	{
		_properties.Threat += this.m.SpecialModifier;
	}
});

