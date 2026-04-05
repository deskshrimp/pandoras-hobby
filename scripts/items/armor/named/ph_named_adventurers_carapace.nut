this.ph_named_adventurers_carapace <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.ph_named_adventurers_carapace";		
        this.m.Description = "A finely crafted adventurer's carapce armor modified to suit the Gilder's tastes. As always, the result is almost too shiny to sully in battle.";
        this.m.NameList = [
            "Gilded Beetle",
            "Gilder's Beetle Mail",
            "Desert Carapace",
            "Golden Prophet",
            "Wasteland Wayfinder"
		];
		this.m.Variant = 420;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 8000;
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
		this.m.StaminaModifier = -26;
		this.randomizeValues();
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "ph_bust_" + this.m.VariantString + "_" + variant;
		this.m.SpriteDamaged = "ph_bust_" + this.m.VariantString + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "ph_bust_" + this.m.VariantString + "_" + variant + "_dead";
		this.m.IconLarge = "armor/ph_inventory_" + this.m.VariantString + "_armor_" + variant + ".png";
		this.m.Icon = "armor/ph_icon_" + this.m.VariantString + "_armor_" + variant + ".png";
	}
});

