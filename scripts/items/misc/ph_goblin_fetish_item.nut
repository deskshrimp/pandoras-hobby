this.ph_goblin_fetish_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_goblin_fetish_";
		this.m.Name = "Shaman's Fetish";
		this.m.Description = "Research Note #1954: Greenfolk Shaman's oft exhibit a proclivity for all manner of strange unexplained abilities the lay folk refer to as \'magic\'. Their bodies and personal effects must hold some clues as to the nature of their uncanny abilities. What purpose does the fetish serve? Also, our inability to procure a fully intact fetish is a curious detail in itself.";
		this.m.Icon = "misc/ph_goblin_fetish.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});