this.ph_wolf_pelt_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_wolf_pelt";
		this.m.Name = "Unusually Large Albino Wolf Pelt";
		this.m.Description = "Research Note #1992: Particularly irascible direwolf specimen are apparently predisposed to albinism. This leaves one to ponder, is their albinism the cause of their terrible nature or has some other feature of their anatomy stripped them of both their pigmentation and their sanity?";
		this.m.Icon = "misc/ph_inventory_champ_wolfpelt.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1800;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});

