this.ph_vamp_skull_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_vamp_skull";
		this.m.Name = "Fanged Skull with Fragments";
		this.m.Description = "Research Note #185: Upon death the necrosavant's body is reduced to ashes, yet its skull remains intact. Further examination shows the bone is of typical hardness, but yields no further explaination for this phenomenon. There is also the supposition that necromancers and necrosavants may related, however, I have found no evidence as such.";
		this.m.Icon = "misc/ph_vamp_sample.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2500;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});