this.ph_zombie_ring_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_zombie_ring";
		this.m.Name = "Tarnished Signet Ring";
		this.m.Description = "Research Note #1069: Signet ring. Damaged beyond repair. Recovered from one of the especially large walking corpses colloquially referred to as a Fallen Hero. Was this man truly a hero? Could he not have been just a random brigand, bastard, or forgotten hedge knight that received the misfortunate gift of putrified undeath. Only this ring may hold the answer to that inquiry.";
		this.m.Icon = "misc/ph_fallen_hero_ring.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});