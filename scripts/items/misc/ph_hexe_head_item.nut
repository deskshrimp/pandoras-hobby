this.ph_hexe_head_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_hexe_head";
		this.m.Name = "Hexe Head (shaved)";
		this.m.Description = "Research Note #2078 - in a florid cursive sccrawl: One hexe head. Hair shorn off; still frightens superstisious folk - alas research requires funding. Prelimenary measures within human parameters. Question: If hexe magic is in the brain, is it safe to cut the skull? Unknown.";
		this.m.Icon = "misc/ph_hexe_head.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 666;
	}

});