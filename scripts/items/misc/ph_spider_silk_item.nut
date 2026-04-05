this.ph_spider_silk_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_spider_silk";
		this.m.Name = "Iron Gossamer";
		this.m.Description = "Research Note #2416s: Silk threads of unusual strength and hue. Did the creature that excreted them have an especially iron-rich diet?";
		this.m.Icon = "misc/ph_champ_spider_silk.png";
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});