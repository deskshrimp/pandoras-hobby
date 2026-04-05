this.ph_inc_goblin_overseer_potion_item <- this.inherit("scripts/items/misc/anatomist/pandora/ph_incomplete_anatomist_potion_item", {
	m = {},
	function create()
	{
		this.ph_incomplete_anatomist_potion_item.create();
		this.m.ID = "misc.ph_inc_goblin_overseer_potion";
		this.m.Name = "Incomplete Deadeye\'s Draught";
		this.m.Icon = "misc/mod_ph/potion_13_inc.png";
	}
});

