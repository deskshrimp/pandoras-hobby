this.ph_ghoul_guts_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_ghoul_guts";
		this.m.Name = "Nachzehrer Guts";
		this.m.Description = "Research Note #1842: What allows the insatiable ghouls to grow so rapidly? Swallow men whole? And, how does one extract the answers from this mass of foul festering filth?";
		this.m.Icon = "misc/ph_nach_guts.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 100;
	}

});