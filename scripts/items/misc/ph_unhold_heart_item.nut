this.ph_unhold_heart_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_unhold_heart";
		this.m.Name = "Hallowed Heart";
		this.m.Description = "Research Note #61C: This marvelous cardiac specimen is a solid wall of muscle with an unatural hue. Superstitious folk claim it was \'touched\' by the Ijirok. Supposedly, consuming it will soemtimes bestow his blessing upon the eater, but suitable volunteers have been hard to retain.";
		this.m.Icon = "misc/ph_ijirok_heart.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}
});