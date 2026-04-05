this.ph_spider_eyes_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_spider_eyes";
		this.m.Name = "\'Preserved\' Spider Eyes";
		this.m.Description = "Research Note #2416: A simultaneous analysis the properties of the blood, venom, and eyes of these fascinating arachnids could uncover both the nature of their excellent vision and new preservation techniques for organic matter... Alas, both are unlikely as the mixture is steadily disolving into a simple verdant slime.";
		this.m.Icon = "misc/ph_preserved_spider_eyes.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}
});