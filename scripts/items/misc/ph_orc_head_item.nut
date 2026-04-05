this.ph_orc_head_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_orc_head";
		this.m.Name = "Orc Head";
		this.m.Description = "Research Note #590: If one could somehow grant life or perhaps even undeath to a severed head would it still retain its secrets? Or, when the spark of life flees the body does it extract our truths as well as our being? The undead do seem to wholly lack intelligence and exhibit only the faintest will, most likely instilled by the master that granted them undeath. Erm. One Orc head. Largely intact, with a forehead hard as plate.";
		this.m.Icon = "misc/ph_orc_head.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

});