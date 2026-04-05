this.ph_adventurers_carapace <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.ph_adventurers_carapace";
		this.m.Name = "Adventurer\'s Carapace";
		this.m.Description = "A fine beetle-like carapce of light scales worn over a thick leather coat worn over a sturdy tunic, reinforced with iron bracers and improved with additional pouches for tools.";
		//"The secret is layers. Many layers. Like the proverbial cake, excepting that this cake is wholy truthful and exceptional at keeping your innards intact and, well, in."
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 422;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 3500;
		this.m.Condition = 225;
		this.m.ConditionMax = 225;
		this.m.StaminaModifier = -26;
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