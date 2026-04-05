this.ph_ghoul_brain_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_ghoul_brain";
		this.m.Name = "Nachzehrer Brain (unusual hue)";
		this.m.Description = "Research Note #1842-B: This particular brain is slightly remarkable for its unusual color, however, this particular quirk elucidates little.";
		this.m.Icon = "misc/ph_champ_ghoul.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 100;
	}

});