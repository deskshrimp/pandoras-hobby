this.ph_sand_jar_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_sand_jar";
		this.m.Name = "Jar of \'Dead\' Sand";
		this.m.Description = "Research Note #2180 - How does unlife beget life? And, how again does it lose it? Is the spark of life so fragile that through the meanest force one may extinguish it even in so sturdy and unliving of a vessel?";
		this.m.Icon = "misc/ph_sand_jar.png";
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