this.ph_named_light_padding_replacement_upgrade <- this.inherit("scripts/items/armor_upgrades/named/ph_named_armor_upgrade", {
	m = {		
	},
	function create()
	{
		this.ph_named_armor_upgrade.create();
		this.m.ID = "armor_upgrade.ph_named_light_padding_replacement";		
		this.m.Description = "Crafted from exotic materials, this replacement padding can provide more protection than regular padding and less weight.";
		this.m.ArmorDescription = "This armor has its padding replaced by a lighter and slightly more durable one.";
        this.m.NameList = ["Spidersilk Padding"];
		this.m.CreatureNames = ::Const.Strings.PH_SpiderNames;
		this.m.Icon = "armor_upgrades/ph_upgrade_05.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/ph_icon_upgrade_05.png";
		this.m.OverlayIconLarge = "armor_upgrades/ph_inventory_upgrade_05.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_05_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_05_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_05_back_dead";
		this.m.Value = 1300;

        this.m.ConditionModifier = 5;
		this.m.ConditionRollMin = 100;	//5
		this.m.ConditionRollMax = 300;	//15

		this.m.StaminaModifier = 0;

        this.m.SpecialModifier = 20;
		this.m.SpecialRollMin = 100; //20
		this.m.SpecialRollMax = 125; //25

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
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Reduces an armor\'s penalty to Maximum Fatigue by [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.SpecialModifier +"%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

	function onAdded()
	{
		this.m.StaminaModifier = ::Math.floor(this.m.Armor.m.StaminaModifier * this.m.SpecialModifier * 0.01);
		this.ph_named_armor_upgrade.onAdded();
	}

	function onRemoved()
	{
		this.m.StaminaModifier = 0;
		this.ph_named_armor_upgrade.onRemoved();
	}
});

