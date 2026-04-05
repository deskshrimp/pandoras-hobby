this.ph_generic_sample_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_generic_sample";
		this.m.Name = "Inferior Research Sample";
		this.m.Description = "Research Note #42: Another of the plethora of poorly collected and inadaquately preserved research samples. And, yet there may still be secrets of profound and terrible importance slowly decaying inside this jar.";
		this.m.Icon = "misc/ph_generic_sample.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 100;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});