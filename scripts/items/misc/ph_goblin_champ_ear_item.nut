this.ph_goblin_champ_ear_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_goblin_champ_ear";
		this.m.Name = "Goblin Champion's Ear";
		this.m.Description = "Research Note #1860: Largely identical to samples retrieved from lesser goblins. No great differences in physiology. Cheap jewelry does little to improve its scientific or market value.";
		this.m.Icon = "misc/ph_goblin_over_ear.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 500;
	}

});