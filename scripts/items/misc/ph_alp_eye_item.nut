this.ph_alp_eye_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_alp_eye_item";
		this.m.Name = "Dreaming Eye";
		this.m.Description = "Research Note #2492 - A most fascinating creature, the alp is said to see using a secret third eye, like this particularly fine specimen. There is however, the oft neglected detail that alp bodies are covered in a variety of soft \'horns\' that I surmise must serve a similar function as a cat's whiskers.";
		this.m.Icon = "misc/ph_champ_alp_eye.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1500;
	}
});