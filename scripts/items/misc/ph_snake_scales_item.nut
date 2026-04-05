this.ph_snake_scales_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_snake_scales";
		this.m.Name = "Verdant Scales";
		this.m.Description = "Research Note #657: Serpents are a cylindrical vessel of dense muscle surrounding a disgestive tract and covered in a layer of natural chainmail. One might expect a serpent clad in armor thus to be as slow as the perverbial snail who carries a house upon his back, but the coiled muscles of a serpent propel its strikes with speed surpassing that of any man.";
		this.m.Icon = "misc/ph_snake_champ.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});

