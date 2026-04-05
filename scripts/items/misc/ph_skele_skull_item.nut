this.ph_skele_skull_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_skele_skull";
		this.m.Name = "Ancient Skull (intact)";
		this.m.Description = "Research Note #1909: The fully intact skull of an Ancient Dead of some regard. What secrets did this vessel once hold? What great ideas and lost technologies could be rediscovered if one could interrogate these wisened dead? Does such great knowledge leave any indelible marks or energies behind that we may yet still extract?";
		this.m.Icon = "misc/ph_skele_skull.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 3000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});