this.ph_skele_clavicle_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_skele_clavicle";
		this.m.Name = "Sturdy Ancient Clavicle";
		this.m.Description = "Research Note #2935: Despite their advanced age which should have rendered them into dust and fertilizer, the bones of the Ancient Dead are unfathomably sturdy. If one we could grant such prowess to men; they would be as lesser gods with bones of stone and iron.";
		this.m.Icon = "misc/ph_skele_clavicle.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1500;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}
});