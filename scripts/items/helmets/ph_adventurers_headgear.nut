this.ph_adventurers_headgear <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.ph_adventurers_headgear";
		this.m.Name = "Adventurer\'s Headgear";
		this.m.Description = "A flat-topped metal helmet with a distinctive, bird-like faceplate filled with herbs to ward away sickness and disease.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ReplaceSprite = true;
		this.m.Variant = 422;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 2500;
		this.m.Condition = 245;
		this.m.ConditionMax = 245;
		this.m.StaminaModifier = -15;
		this.m.Vision = -3;
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

