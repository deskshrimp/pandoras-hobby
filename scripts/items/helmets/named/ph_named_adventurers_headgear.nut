this.ph_named_adventurers_headgear <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.ph_named_adventurers_headgear";
		this.m.Description = "A gilded beaked helmet worn only by the highest ranking anatomists in the southern city states.";
		this.m.NameList = [
			"Mask of the Vizier",
            "Gilder's Messenger",
            "Gilded Headgear",
            "Gilded Buzzard",
            "Helm of the Corpse Eater",
            "Sun Searcher"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 420;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 6500;
		this.m.Condition = 250;
		this.m.ConditionMax = 250;
		this.m.StaminaModifier = -15;
		this.m.Vision = -3;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "ph_bust_" + this.m.VariantString + "_" + variant;
		this.m.SpriteDamaged = "ph_bust_" + this.m.VariantString + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "ph_bust_" + this.m.VariantString + "_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/ph_inventory_" + this.m.VariantString + "_" + variant + ".png";
	}

    function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Only take [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of damage inflicted by harmful miasmas"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.helmet.onUpdateProperties(_properties);
		_properties.IsResistantToMiasma = true;
	}
});

