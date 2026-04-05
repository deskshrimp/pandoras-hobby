this.ph_schrat_sprouts_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_schrat_sprouts";
		this.m.Name = "Schrat Roots";
		this.m.Description = "Research Note #2782: How have schrat crossed the line between plant and animal? Or, perhaps, one should consider a more mundane line of inquiry? Roots? Rhizomes? Neither? Are these tendrils edible? A Schrat could provide a near endless supply of this ruffage...";
		this.m.Icon = "misc/ph_schrat_sprouts.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 300;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/cleave_hit_hitpoints_01.wav", this.Const.Sound.Volume.Inventory);
	}
});

