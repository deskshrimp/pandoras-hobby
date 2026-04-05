this.ph_unhold_liver_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_unhold_liver";
		this.m.Name = "Immortal Liver";
		this.m.Description = "Research Note #61 - traced over until it cut through the page: Superstitious fools focus on the grandiose cardiac muscles when the real science involves this infinitely regenerating organ. It must be the source of the beast's uncanny regenerative abilities.";
		this.m.Icon = "misc/ph_unhold_liver.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1250;
	}
});