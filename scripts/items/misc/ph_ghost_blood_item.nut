this.ph_ghost_blood_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_ghost_blood";
		this.m.Name = "Ectoplasm";
		this.m.Description = "Research Note #1537 - By what process do ethereal vapors or geist \'flesh\' become denatured into this gelatinous blood-like substance? If one could reverse this process a man could walk through walls!";
		this.m.Icon = "misc/ph_ghost_blood.png";		
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}
});