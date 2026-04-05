this.ph_warlock_hair_item <- this.inherit("scripts/items/ph_research_sample_item", {
	m = {},
	function create()
	{
		this.ph_research_sample_item.create();
		this.m.ID = "misc.ph_warlock_hair";
		this.m.Name = "Warlock's Locks";
		this.m.Description = "Research Note #849 - on a page marred with dark smudges: Studies on the nature #f undeath have #ften been postulated to be the ### to unlocking th# secrets of immortal###. Whatever ### methods achieved, the donor ## #### sample has decayed at an alarming rate; turning enitrely to ash!";
		this.m.Icon = "misc/ph_ashen_hair.png";	
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 2500;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}
});